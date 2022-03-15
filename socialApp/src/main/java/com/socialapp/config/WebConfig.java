package com.socialapp.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.socialapp.interceptor.ClientCheckInterceptor;

/**
 * Web 拦截器配置
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Autowired
    private ClientCheckInterceptor clientCheckInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册客户端检查拦截器
        registry.addInterceptor(clientCheckInterceptor).addPathPatterns("/**");
        
    }

}
