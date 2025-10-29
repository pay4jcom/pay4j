package com.pay4j.common.oss.exception;

import java.io.Serial;

/**
 * OSS异常类
 *
 * @author Pay4j
 */
public class OssException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 1L;

    public OssException(String msg) {
        super(msg);
    }

}
