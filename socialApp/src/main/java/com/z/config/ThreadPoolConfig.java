package com.z.config;

import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 线程池配置类
 */
@Configuration
public class ThreadPoolConfig {

    @Bean
    public ThreadPoolExecutor threadPoolExecutor(ThreadPoolConfigProperties myProperties) {
        return new ThreadPoolExecutor(myProperties.getCoreSize(), // 核心线程数量。这些线程一直存在
                myProperties.getMaxSize(), // 最大线程数。允许得最大线程数
                myProperties.getKeepAliveTime(), // 空闲线程存活时间。当没有任务时，空闲线程可存活时间
                TimeUnit.SECONDS, // 空闲线程存活时间的单位
                new LinkedBlockingDeque<>(100000), // 线程队列（设置最大容量十万个）。当线程数大于{核心线程数量}时，其他线程进入队列
                Executors.defaultThreadFactory(), // 线程工厂
                new ThreadPoolExecutor.AbortPolicy()); // 当超过{最大线程数}时，采取的拒绝策略。 根据自己需求配置拒绝策略
    }

}
