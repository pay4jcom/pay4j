package com.pay4j.common.core.exception.user;

import java.io.Serial;

/**
 * 验证码失效异常类
 *
 * @author pay4j
 */
public class CaptchaExpireException extends UserException {

    @Serial
    private static final long serialVersionUID = 1L;

    public CaptchaExpireException() {
        super("user.jcaptcha.expire");
    }
}
