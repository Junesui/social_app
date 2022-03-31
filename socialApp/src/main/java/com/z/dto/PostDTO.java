package com.z.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 投稿时从页面传输的数据对象
 */
@Data
public class PostDTO {
    // 投稿类型
    private Integer type;
    // 投稿文字
    private String text;
    // 投稿附带文件(图片)
    private MultipartFile[] files;
}
