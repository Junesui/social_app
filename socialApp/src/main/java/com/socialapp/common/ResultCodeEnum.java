package com.socialapp.common;

import lombok.Getter;
import lombok.ToString;

/***
 * 返回结果状态码和信息定义 
 * 1. 状态码定义规则为5位数字 
 * 2. 前两位表示业务场景，最后三位表示错误码。例如：10001。10:通用 001:系统未知异常
 * 
 * 错误码列表： 
 * 10: 通用， 
 * 11: 用户，
 * 12: ...
 */
@Getter
@ToString
public enum ResultCodeEnum {

    // 共通
    SUCCESS(10000, "成功"), 
    UNKNOWN_ERROR(10001,"未知错误"),

    
    
    // 用户
    
    ;

    // 状态码
    private Integer code;
    // 消息
    private String message;

    ResultCodeEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
