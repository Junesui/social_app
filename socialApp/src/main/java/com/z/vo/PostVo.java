package com.z.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 投稿时的数据对象
 */
@Data
public class PostVo {
    private Integer type;
    private String text;
    private MultipartFile[] files;
}
