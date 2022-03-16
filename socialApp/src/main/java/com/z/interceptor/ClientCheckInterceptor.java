package com.z.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * 检查是否是从我们的项目发送的请求拦截器。防止非法请求攻击 
 * 简单判断（前端所有请求添加请求头 - AcceptDcheck:zh 或自定义的其他请求头）
 */
@Component
public class ClientCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        return true;

        /// 获取并判断自定义的请求头。GlobalExceptionHandler 中判断异常并返回信息
        // String AcceptDcheck = request.getHeader("AcceptDcheck");
        // 
        // if (!StringUtils.isEmpty(AcceptDcheck) && AcceptDcheck.equals("zh")) {
        // // 来自客户端的正常请求
        // return true;
        // } else {
        // // 非法请求
        // throw new SocialappException(ResultCodeEnum.ILLEGAL_REQUEST);
        // }

    }

}
