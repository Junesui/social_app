package com.socialapp.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 用户隐私设置表
 */
@Data
public class UserPrivacySettings implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Boolean isAllowFollow;
    private Boolean isShowPostOnlyFollower;
    private Boolean isWriteLetterOnlyFollower;
    private Boolean isShowJoinGroup;
    private Boolean isChatOnlyFollow;
    private Boolean isCallInviteOnlyFollow;
    private Boolean isGroupInviteOnlyFollow;
    private Boolean isAllowSearch;
    private Boolean isHideOnlineStatus;
    private Boolean isHideAccessHistory;
    private Long createdAt;
    private Long updatedAt;

}
