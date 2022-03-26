package com.z.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 文件操作相关配置的参数
 */
@ConfigurationProperties(prefix = "socialapp.file")
@Component
@Data
public class FileConfigProperties {
    private String accessPrefix;
    private String savaBaseDir;
}