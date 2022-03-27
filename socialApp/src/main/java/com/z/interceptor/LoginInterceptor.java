package com.z.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import com.z.common.ResultCodeEnum;
import com.z.constant.UserConstant;
import com.z.entity.UserAuth;
import com.z.exception.SocialappException;
import com.z.properties.JWTConfigProperties;
import com.z.util.JwtUtil;

/**
 * 登录验证拦截器
 *
 */
@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private JWTConfigProperties jwtConfigProperties;

    // 存放当前登录用户
    public static ThreadLocal<UserAuth> threadLocal = new ThreadLocal<>();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // 从请求头中获取 token
        String token = request.getHeader(UserConstant.TOKEN_NAME);
        if (!StringUtils.isEmpty(token)) {
            // 验证 token
            Boolean isLogin = JwtUtil.verifyToken(token, jwtConfigProperties.getTokenSecretKey());
            if (isLogin) {
                // 已登录
                UserAuth userAuth = JwtUtil.getUserAuth(token);
                threadLocal.set(userAuth);
                return true;
            } else {
                // 未登录
                throw new SocialappException(ResultCodeEnum.NOT_LOGIN);
            }
        } else {
            // 未登录
            throw new SocialappException(ResultCodeEnum.NOT_LOGIN);
        }
    }

}
