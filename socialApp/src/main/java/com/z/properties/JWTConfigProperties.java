package com.z.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 登录令牌配置的参数
 */
@ConfigurationProperties(prefix = "socialapp.jwt")
@Component
@Data
public class JWTConfigProperties {
    private Integer loginKeepDays;
    private String tokenSecretKey;
}