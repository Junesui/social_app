/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022-03-08 20:24:48                          */
/*==============================================================*/


drop table if exists t_admin;

drop table if exists t_admin_role;

drop table if exists t_age_verify_img;

drop table if exists t_banned_words;

drop table if exists t_calling_room;

drop table if exists t_calling_user;

drop table if exists t_comment;

drop table if exists t_follower;

drop table if exists t_group;

drop table if exists t_group_category;

drop table if exists t_history;

drop table if exists t_join_group;

drop table if exists t_letter;

drop table if exists t_like;

drop table if exists t_login_log;

drop table if exists t_login_status;

drop table if exists t_notice;

drop table if exists t_permission;

drop table if exists t_post;

drop table if exists t_post_img;

drop table if exists t_report;

drop table if exists t_report_reason;

drop table if exists t_role;

drop table if exists t_role_permission;

drop table if exists t_user;

drop table if exists t_user_auth;

drop table if exists t_user_block;

drop table if exists t_user_privacy_settings;

/*==============================================================*/
/* Table: t_admin                                               */
/*==============================================================*/
create table t_admin
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   telephone            VARCHAR(20) not null comment '手机号码',
   email                VARCHAR(50) comment '邮箱',
   password             VARCHAR(255) not null comment '密码',
   gender               TINYINT unsigned not null comment '性别（0：女，1：男）',
   real_name            VARCHAR(16) not null comment '真实姓名',
   id_number            CHAR(18) not null comment '身份证号码',
   salt                 char(10) comment '盐（密码加密使用）',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_admin comment '管理员表';

/*==============================================================*/
/* Table: t_admin_role                                          */
/*==============================================================*/
create table t_admin_role
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   admin_id             BIGINT unsigned not null comment '管理员ID',
   role_id              BIGINT unsigned not null comment '角色ID',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_admin_role comment '管理员-角色关联表';

/*==============================================================*/
/* Table: t_age_verify_img                                      */
/*==============================================================*/
create table t_age_verify_img
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   img                  VARCHAR(255) not null comment '图片URL',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_age_verify_img comment '用户年龄认证图片表';

/*==============================================================*/
/* Table: t_banned_words                                        */
/*==============================================================*/
create table t_banned_words
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   word                 VARCHAR(255) not null comment '违禁词',
   type                 TINYINT unsigned not null comment '类型。（适用场景：0: "general", 1: "group", 2: "user"）',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_banned_words comment '违禁词表';

/*==============================================================*/
/* Table: t_calling_room                                        */
/*==============================================================*/
create table t_calling_room
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   ower_id              BIGINT unsigned not null comment '房主ID',
   title                VARCHAR(255) comment '房间标题',
   type                 TINYINT unsigned not null comment '房间类型（0: "call", 1: "video"）',
   max_participants     INT unsigned default 8 comment '最大参与者',
   is_calling           BOOLEAN comment '是否正在进行中',
   is_only_age_verfy    BOOLEAN comment '是否仅允许年龄认证的用户加入',
   is_only_vip          BOOLEAN comment '是否只允许vip用户进入',
   start_at             BIGINT unsigned not null comment '开始时间',
   end_at               BIGINT unsigned comment '结束时间',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_calling_room comment '通话房间表';

/*==============================================================*/
/* Table: t_calling_user                                        */
/*==============================================================*/
create table t_calling_user
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   calling_room_id      BIGINT unsigned not null comment '房间ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   is_owner             BOOLEAN comment '是否是房主',
   join_at              BIGINT unsigned not null comment '加入房间时间',
   leave_at             BIGINT unsigned comment '离开房间时间',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_calling_user comment '通话房间-用户关联表';

/*==============================================================*/
/* Table: t_comment                                             */
/*==============================================================*/
create table t_comment
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned not null comment '投稿ID',
   commentator_id       BIGINT unsigned not null comment '评论人ID',
   parent_id            BIGINT unsigned comment '父ID（为NULL时，评论投稿；不为NULL时，回复评论。）',
   content              VARCHAR(1000) comment '评论内容',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_comment comment '评论表';

/*==============================================================*/
/* Table: t_follower                                            */
/*==============================================================*/
create table t_follower
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   follower_id          BIGINT unsigned not null comment '粉丝ID',
   is_follow            BOOLEAN comment '是否关注',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_follower comment '粉丝表';

/*==============================================================*/
/* Table: t_group                                               */
/*==============================================================*/
create table t_group
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   owner_id             BIGINT unsigned not null comment '创建人ID',
   group_category_id    BIGINT unsigned not null comment '组分类ID',
   title                VARCHAR(255) not null comment '组的标题',
   description          VARCHAR(1000) comment '组的描述',
   cover                VARCHAR(255) comment '封面URL',
   cover_thumbnail      VARCHAR(255) comment '封面缩略图URL',
   is_need_agree        BOOLEAN comment '用户加入是否需要审核',
   is_calling_top       BOOLEAN comment '是否通话置顶',
   is_only_age_verfy    BOOLEAN comment '是否仅允许年龄认证的用户加入',
   is_only_same_gender  BOOLEAN comment '是否和创建者同性别的人加入',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_group comment '用户创建的组的表
';

/*==============================================================*/
/* Table: t_group_category                                      */
/*==============================================================*/
create table t_group_category
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 CHAR(10) not null comment '分类名称',
   icon                 VARCHAR(255) comment '分类图标URL',
   color                CHAR(10) comment '十六进制表示的颜色，页面显示使用',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_group_category comment '组分类表';

/*==============================================================*/
/* Table: t_history                                             */
/*==============================================================*/
create table t_history
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   visitor_id           BIGINT unsigned not null comment '访问者ID',
   visited_id           BIGINT unsigned not null comment '被访问者ID',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_history comment '主页访问历史表';

/*==============================================================*/
/* Table: t_join_group                                          */
/*==============================================================*/
create table t_join_group
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   group_id             BIGINT unsigned not null comment '组ID',
   is_join              BOOLEAN comment '是否加入',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_join_group comment '用户参加的组的表';

/*==============================================================*/
/* Table: t_letter                                              */
/*==============================================================*/
create table t_letter
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   letter_user_id       BIGINT unsigned not null comment '留言人ID',
   letter               VARCHAR(1000) comment '留言内容',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_letter comment '留言表';

/*==============================================================*/
/* Table: t_like                                                */
/*==============================================================*/
create table t_like
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned comment '投稿ID',
   comment_id           BIGINT unsigned comment '评论ID',
   user_id              BIGINT unsigned not null comment '点赞人ID',
   is_like              BOOLEAN comment '是否点赞',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_like comment '点赞表';

/*==============================================================*/
/* Table: t_login_log                                           */
/*==============================================================*/
create table t_login_log
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   user_auth_id         BIGINT unsigned not null comment '用户授权ID',
   platform             TINYINT unsigned comment '平台（0: "Andorid", 1: "IOS"）',
   model                VARCHAR(50) comment '型号',
   brand                VARCHAR(50) comment '品牌',
   skd_version          CHAR(10) comment 'SDK版本',
   sys_version          CHAR(10) comment '系统版本',
   login_ip             VARCHAR(255) comment '登录ip',
   login_address        VARCHAR(255),
   login_at             BIGINT unsigned comment '登录时间',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_login_log comment '登录日志表';

/*==============================================================*/
/* Table: t_login_status                                        */
/*==============================================================*/
create table t_login_status
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   is_online            BOOLEAN comment '用户是否在线',
   online_status        VARCHAR(30) comment '在线状态',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_login_status comment '登录状态表';

/*==============================================================*/
/* Table: t_notice                                              */
/*==============================================================*/
create table t_notice
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   receiver_id          BIGINT unsigned not null comment '接收用户ID',
   action_user_id       BIGINT unsigned not null comment '动作用户ID',
   type                 TINYINT unsigned not null comment '通知类型（0: "group_created", 1:"group_invite", 2:"follow", 3:"like",  4:"group_accepted"）',
   object_id            BIGINT unsigned comment '通知对象ID（投稿ID，组ID...如果是关注则不设置）',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_notice comment '消息通知表';

/*==============================================================*/
/* Table: t_permission                                          */
/*==============================================================*/
create table t_permission
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 VARCHAR(10) not null comment '权限名称',
   ename                VARCHAR(50) not null comment '权限英文名称',
   description          VARCHAR(255) comment '权限描述',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_permission comment '权限表';

/*==============================================================*/
/* Table: t_post                                                */
/*==============================================================*/
create table t_post
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   group_id             BIGINT unsigned comment '组ID',
   content              VARCHAR(1000) comment '投稿内容',
   type                 TINYINT unsigned not null comment '投稿类型（0: "text", 1: "image", 2: "call", 3: "video"）',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_post comment '投稿表';

/*==============================================================*/
/* Table: t_post_img                                            */
/*==============================================================*/
create table t_post_img
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned not null comment '投稿ID',
   img                  VARCHAR(255) not null comment '图片URL',
   img_thumbnail        VARCHAR(255) not null comment '图片缩略图URL',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_post_img comment '投稿图片表';

/*==============================================================*/
/* Table: t_report                                              */
/*==============================================================*/
create table t_report
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   reporter_id          BIGINT unsigned not null comment '举报人ID',
   reproted_id          BIGINT unsigned not null comment '被举报信息ID（根据类型设置。通话房间ID，投稿ID...）',
   report_reason_id     BIGINT unsigned not null comment '举报理由ID',
   type                 TINYINT unsigned not null comment '举报类型（0: "post", 1: "call", 2: "group"）',
   attach_img1          VARCHAR(255) comment '附件图片1的URL',
   attach_img2          VARCHAR(255) comment '附件图片2的URL',
   attach_img3          VARCHAR(255) comment '附件图片3的URL',
   attach_img4          VARCHAR(255) comment '附件图片4的URL',
   attach_img5          VARCHAR(255) comment '附件图片5的URL',
   description          VARCHAR(1000) comment '详细描述',
   is_handled           BOOLEAN comment '是否已处理',
   handler_id           BIGINT unsigned comment '处理人ID（管理员表ID）',
   handled_at           BIGINT unsigned,
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_report comment '举报表';

/*==============================================================*/
/* Table: t_report_reason                                       */
/*==============================================================*/
create table t_report_reason
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   content              VARCHAR(255) comment '内容',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_report_reason comment '举报理由表';

/*==============================================================*/
/* Table: t_role                                                */
/*==============================================================*/
create table t_role
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 VARCHAR(10) not null comment '角色名称',
   ename                VARCHAR(50) not null comment '角色英文名称',
   description          VARCHAR(255) comment '角色描述',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_role comment '角色表';

/*==============================================================*/
/* Table: t_role_permission                                     */
/*==============================================================*/
create table t_role_permission
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   role_id              BIGINT unsigned not null comment '角色ID',
   permission_id        BIGINT unsigned not null comment '权限ID',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_role_permission comment '角色-权限关联表';

/*==============================================================*/
/* Table: t_user                                                */
/*==============================================================*/
create table t_user
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   userid               VARCHAR(64) not null comment '用户标识ID',
   telephone            VARCHAR(20) comment '手机号',
   email                VARCHAR(50) comment '邮箱',
   nickname             VARCHAR(255) not null comment '昵称',
   biography            VARCHAR(255) comment '个人简介',
   avatar_thumbnail     VARCHAR(255) comment '头像缩略图URL',
   avatar               VARCHAR(255) comment '头像URL',
   cover                VARCHAR(255) comment '封面URL',
   cover_thumbnail      VARCHAR(255) comment '封面缩略图URL',
   province             CHAR(10) comment '省份',
   gender               TINYINT unsigned comment '性别（0：女，1：男）',
   birthday             CHAR(10) comment '生日',
   is_age_verified      BOOLEAN comment '是否已年龄认证',
   is_vip               BOOLEAN comment '是否是vip',
   vip_start_at         BIGINT unsigned comment 'vip开通时间',
   vip_end_at           BIGINT unsigned comment 'vip到期时间',
   is_new_user          BOOLEAN comment '是否是新用户',
   is_dangerous_user    BOOLEAN comment '是否是危险用户',
   status               VARCHAR(30) comment '状态',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id),
   key AK_uq_userid (userid)
);

alter table t_user comment '用户表
';

/*==============================================================*/
/* Table: t_user_auth                                           */
/*==============================================================*/
create table t_user_auth
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   type                 TINYINT unsigned not null comment '登录类型（0: "phone", 1: "wechat", 2: "qq", 3: "weibo"）',
   identifier           VARCHAR(255) not null comment '登录的用户名',
   credential           VARCHAR(255) not null comment '登录的密码',
   salt                 char(10) comment '盐（密码加密使用）',
   is_deleted           BOOLEAN comment '是否删除',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_user_auth comment '用户授权表';

/*==============================================================*/
/* Table: t_user_block                                          */
/*==============================================================*/
create table t_user_block
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   blocked_user_id      BIGINT unsigned not null comment '被屏蔽用户ID',
   is_block             BOOLEAN comment '是否屏蔽',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_user_block comment '屏蔽用户表';

/*==============================================================*/
/* Table: t_user_privacy_settings                               */
/*==============================================================*/
create table t_user_privacy_settings
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '用户ID',
   is_allow_follow      BOOLEAN default true comment '是否允许直接关注',
   is_show_post_only_follower BOOLEAN comment '是否投稿仅粉丝可见',
   is_write_letter_only_follower BOOLEAN comment '是否仅粉丝可以留言',
   is_show_join_group   BOOLEAN default true comment '是否展示加入的组',
   is_chat_only_follow  BOOLEAN comment '是否仅允许关注的人发送消息',
   is_call_invite_only_follow BOOLEAN comment '是否仅允许关注的人发送通话邀请',
   is_group_invite_only_follow BOOLEAN comment '是否仅允许关注的人发送加入组的邀请',
   is_allow_search      BOOLEAN default true comment '是否可被用户搜索',
   is_hide_online_status BOOLEAN comment '是否隐藏在线状态（会员专用）',
   is_hide_access_history BOOLEAN comment '是否隐藏访问记录（会员专用）',
   created_at           BIGINT unsigned not null comment '创建时间',
   updated_at           BIGINT unsigned not null comment '更新时间',
   primary key (id)
);

alter table t_user_privacy_settings comment '用户隐私设置表';

