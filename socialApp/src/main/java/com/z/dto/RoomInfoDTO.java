package com.z.dto;

import lombok.Data;

/**
 * 用户登录通话房间时，从服务端返回给页面的房间信息对象
 */
@Data
public class RoomInfoDTO {
    // 即构appId
    private Long appId;
    // 房间ID
    private Long roomId;
    // 用户ID
    private Long userId;
    // 用于登录房间的 token
    private String token;
    // 用户头像缩略图
    private String avatarThum;
    // 用户昵称
    private String nickname;
    
}
