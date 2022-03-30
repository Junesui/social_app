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
    //访问路径前缀
    private String accessPrefix;
    // 文件保存的基本路径
    private String savaBaseDir;
}