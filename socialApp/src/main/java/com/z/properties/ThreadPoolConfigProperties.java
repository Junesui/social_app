package com.z.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 线程池配置的参数
 */
@ConfigurationProperties(prefix = "socialapp.threadpool")
@Component
@Data
public class ThreadPoolConfigProperties {
    // 核心线程数
    private Integer coreSize;
    // 最大线程数
    private Integer maxSize;
    // 空闲线程可存活时间(秒)
    private Integer keepAliveTime;
}
