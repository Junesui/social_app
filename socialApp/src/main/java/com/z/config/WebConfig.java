package com.z.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.z.interceptor.ClientCheckInterceptor;
import com.z.interceptor.LoginInterceptor;

/**
 * Web 拦截器配置
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Autowired
    private ClientCheckInterceptor clientCheckInterceptor;
    @Autowired
    private LoginInterceptor loginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册客户端检查拦截器
        registry.addInterceptor(clientCheckInterceptor).addPathPatterns("/**");
        
        // 注册登录拦截器
        List<String> loginExcludePath = new ArrayList<String>();
        loginExcludePath.add("/phonecode/send");
        loginExcludePath.add("/file/download/**");
        loginExcludePath.add("/user/login");
        registry.addInterceptor(loginInterceptor).addPathPatterns("/**").excludePathPatterns(loginExcludePath);
    }

}
