package com.pay4j.test;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Arrays;

public class NavicatPassword {
	public static void main(String[] args) throws Exception {
		NavicatPassword navicatPassword = new NavicatPassword();

		// Navicat 11及以前的版本
        // String decode = navicatPassword.decrypt("你的密码", 11);

		// Navicat 12及以后的版本
		String decode = navicatPassword.decrypt("A4F67324B8BE8942C13459FA4D0FD741", 12);

		System.out.println(decode);
	}

	private static final String AES_KEY = "libcckeylibcckey";
	private static final String AES_IV = "libcciv libcciv ";
	private static final String BLOW_KEY = "3DC5CA39";
	private static final String BLOW_IV = "d9c7c3c8870d64bd";

	public static String encrypt(String plaintext, int version) throws Exception {
		switch (version) {
			case 11:
				return encryptEleven(plaintext);
			case 12:
				return encryptTwelve(plaintext);
			default:
				throw new IllegalArgumentException("Unsupported version");
		}
	}

	public static String decrypt(String ciphertext, int version) throws Exception {
		switch (version) {
			case 11:
				return decryptEleven(ciphertext);
			case 12:
				return decryptTwelve(ciphertext);
			default:
				throw new IllegalArgumentException("Unsupported version");
		}
	}

	private static String encryptEleven(String plaintext) throws Exception {
		byte[] iv = hexStringToByteArray(BLOW_IV);
		byte[] key = hashToBytes(BLOW_KEY);

		int round = plaintext.length() / 8;
		int leftLength = plaintext.length() % 8;
		StringBuilder result = new StringBuilder();
		byte[] currentVector = iv.clone();

		Cipher cipher = Cipher.getInstance("Blowfish/ECB/NoPadding");
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, "Blowfish");
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);

		for (int i = 0; i < round; i++) {
			byte[] block = xorBytes(plaintext.substring(i * 8, (i + 1) * 8).getBytes(), currentVector);
			byte[] temp = cipher.doFinal(block);
			currentVector = xorBytes(currentVector, temp);
			result.append(bytesToHex(temp));
		}

		if (leftLength > 0) {
			currentVector = cipher.doFinal(currentVector);
			byte[] block = xorBytes(plaintext.substring(round * 8).getBytes(), currentVector);
			result.append(bytesToHex(block));
		}

		return result.toString().toUpperCase();
	}

	private static String encryptTwelve(String plaintext) throws Exception {
		byte[] iv = AES_IV.getBytes();
		byte[] key = AES_KEY.getBytes();

		Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, "AES");
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

		byte[] result = cipher.doFinal(plaintext.getBytes());
		return bytesToHex(result).toUpperCase();
	}

	private static String decryptEleven(String ciphertext) throws Exception {
		byte[] iv = hexStringToByteArray(BLOW_IV);
		byte[] key = hashToBytes(BLOW_KEY);
		byte[] encrypted = hexStringToByteArray(ciphertext.toLowerCase());

		int round = encrypted.length / 8;
		int leftLength = encrypted.length % 8;
		StringBuilder result = new StringBuilder();
		byte[] currentVector = iv.clone();

		Cipher cipher = Cipher.getInstance("Blowfish/ECB/NoPadding");
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, "Blowfish");
		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);

		for (int i = 0; i < round; i++) {
			byte[] block = Arrays.copyOfRange(encrypted, i * 8, (i + 1) * 8);
			byte[] temp = xorBytes(cipher.doFinal(block), currentVector);
			currentVector = xorBytes(currentVector, block);
			result.append(new String(temp));
		}

		if (leftLength > 0) {
			currentVector = cipher.doFinal(currentVector);
			byte[] block = Arrays.copyOfRange(encrypted, round * 8, round * 8 + leftLength);

			result.append(new String(xorBytes(block, currentVector), StandardCharsets.UTF_8));
		}

		return result.toString();
	}

	private static String decryptTwelve(String ciphertext) throws Exception {
		byte[] iv = AES_IV.getBytes();
		byte[] key = AES_KEY.getBytes();
		byte[] encrypted = hexStringToByteArray(ciphertext.toLowerCase());

		Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, "AES");
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

		byte[] result = cipher.doFinal(encrypted);
		return new String(result);
	}

	private static byte[] xorBytes(byte[] bytes1, byte[] bytes2) {
		byte[] result = new byte[bytes1.length];
		for (int i = 0; i < bytes1.length; i++) {
			result[i] = (byte) (bytes1[i] ^ bytes2[i]);
		}
		return result;
	}

	private static byte[] hexStringToByteArray(String s) {
		int len = s.length();
		byte[] data = new byte[len / 2];
		for (int i = 0; i < len; i += 2) {
			data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));
		}
		return data;
	}

	private static byte[] hashToBytes(String s) throws Exception {
		return MessageDigest.getInstance("SHA-1").digest(s.getBytes());
	}

	private static String bytesToHex(byte[] bytes) {
		StringBuilder result = new StringBuilder();
		for (byte b : bytes) {
			result.append(String.format("%02X", b));
		}
		return result.toString();
	}
}
