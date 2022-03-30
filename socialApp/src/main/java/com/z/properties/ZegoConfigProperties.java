package com.z.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 即构相关配置 
 */
@ConfigurationProperties(prefix = "socialapp.zego")
@Component
@Data
public class ZegoConfigProperties {
    // 即构appId(由即构提供)
    private Long appId;
    // 即构密钥(由即构提供)
    private String secretKey;
    // 生成token有效时间(秒)
    private int effectiveTimeInSeconds;
    // 调试时，置为 true, 可在控制台输出更多信息；正式运行时，置为 false
    private Boolean verbose;
}
