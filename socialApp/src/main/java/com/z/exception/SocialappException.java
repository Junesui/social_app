package com.z.exception;

import com.z.common.ResultCodeEnum;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 自定义异常类
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SocialappException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private ResultCodeEnum resultCodeEnum;

    public SocialappException(ResultCodeEnum resultCodeEnum) {
        this.resultCodeEnum = resultCodeEnum;
    }
}
