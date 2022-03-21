package com.z.common;

import lombok.Data;

/**
 * 统一返回结果封装
 */
@Data
public class R {

    // 是否成功
    private Boolean success;
    // 状态码
    private Integer code;
    // 消息
    private String message;
    // 数据
    private Object data;

    // 私有构造方法
    private R() {
    }

    // 成功静态方法
    public static R success() {
        R r = new R();
        r.setSuccess(true);
        r.setCode(ResultCodeEnum.SUCCESS.getCode());
        r.setMessage(ResultCodeEnum.SUCCESS.getMessage());
        return r;
    }

    // 失败静态方法
    public static R error(ResultCodeEnum resultCodeEnum) {
        R r = new R();
        r.setSuccess(false);
        r.setCode(resultCodeEnum.getCode());
        r.setMessage(resultCodeEnum.getMessage());
        return r;
    }

    // 设置数据
    public R data(Object data) {
        this.data = data;
        return this;
    }

}
