package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 组分类表
 */
@Data
public class GroupCategory implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private String icon;
    private String color;
    private Boolean isDeleted;
    private Long createdAt;
    private Long updatedAt;

}
