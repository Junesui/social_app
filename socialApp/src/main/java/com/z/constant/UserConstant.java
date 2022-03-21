package com.z.constant;

/**
 * 用户相关常量
 */
public class UserConstant {

    // 用户登录成功后，放入请求头中令牌的名称
    public static final String TOKEN_NAME = "loginToken";

    /********************* 登录类型 *********************/
    // 手机验证码登录
    public static final Integer LOGIN_TYPE_PHONE_CODE = 0;
    // 账号密码登录
    public static final Integer LOGIN_TYPE_ACCOUNT = 1;
    // qq登录
    public static final Integer LOGIN_TYPE_QQ = 2;
    // 微信登录
    public static final Integer LOGIN_TYPE_WECHAT = 3;
    // 微博登录
    public static final Integer LOGIN_TYPE_WEIBO = 4;

}
