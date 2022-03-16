package com.z.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 通话房间表
 */
@Data
public class CallingRoomEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long owerId;
    private String title;
    private Integer type;
    private Integer maxParticipants;
    private Boolean isCalling;
    private Boolean isOnlyAgeVerfy;
    private Boolean isOnlyVip;
    private Long startAt;
    private Long endAt;
    private Long createdAt;
    private Long updatedAt;
}
