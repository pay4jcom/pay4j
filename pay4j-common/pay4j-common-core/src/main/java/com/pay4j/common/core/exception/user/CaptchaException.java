package com.pay4j.common.core.exception.user;

import java.io.Serial;

/**
 * 验证码错误异常类
 *
 * @author pay4j
 */
public class CaptchaException extends UserException {

    @Serial
    private static final long serialVersionUID = 1L;

    public CaptchaException() {
        super("user.jcaptcha.error");
    }
}
