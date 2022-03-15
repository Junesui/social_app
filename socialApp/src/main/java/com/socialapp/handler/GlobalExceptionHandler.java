package com.socialapp.handler;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.socialapp.common.R;
import com.socialapp.common.ResultCodeEnum;
import com.socialapp.exception.SocialappException;

import lombok.extern.slf4j.Slf4j;

/**
 * 统一异常处理
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    /**
     * 自定义异常处理
     * 
     * @param socialappException 自定义异常类
     * @return
     */
    @ExceptionHandler(SocialappException.class)
    public R handleDaigouException(SocialappException socialappException) {
        return R.error(socialappException.getResultCodeEnum());
    }

    /**
     * 全局异常
     * 
     * @param throwable
     * @return
     */
    @ExceptionHandler(Throwable.class)
    public R handleException(Throwable throwable) {
        log.error("全局异常：", throwable);
        return R.error(ResultCodeEnum.UNKNOWN_ERROR);
    }
}
