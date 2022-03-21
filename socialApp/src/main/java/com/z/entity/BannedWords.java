package com.z.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 违禁词表
 */
@Data
public class BannedWords implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String word;
    private Integer type;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;
}
