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
   telephone            VARCHAR(20) not null comment '�ֻ�����',
   email                VARCHAR(50) comment '����',
   password             VARCHAR(255) not null comment '����',
   gender               TINYINT unsigned not null comment '�Ա�0��Ů��1���У�',
   real_name            VARCHAR(16) not null comment '��ʵ����',
   id_number            CHAR(18) not null comment '���֤����',
   salt                 char(10) comment '�Σ��������ʹ�ã�',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_admin comment '����Ա��';

/*==============================================================*/
/* Table: t_admin_role                                          */
/*==============================================================*/
create table t_admin_role
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   admin_id             BIGINT unsigned not null comment '����ԱID',
   role_id              BIGINT unsigned not null comment '��ɫID',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_admin_role comment '����Ա-��ɫ������';

/*==============================================================*/
/* Table: t_age_verify_img                                      */
/*==============================================================*/
create table t_age_verify_img
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   img                  VARCHAR(255) not null comment 'ͼƬURL',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_age_verify_img comment '�û�������֤ͼƬ��';

/*==============================================================*/
/* Table: t_banned_words                                        */
/*==============================================================*/
create table t_banned_words
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   word                 VARCHAR(255) not null comment 'Υ����',
   type                 TINYINT unsigned not null comment '���͡������ó�����0: "general", 1: "group", 2: "user"��',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_banned_words comment 'Υ���ʱ�';

/*==============================================================*/
/* Table: t_calling_room                                        */
/*==============================================================*/
create table t_calling_room
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   ower_id              BIGINT unsigned not null comment '����ID',
   title                VARCHAR(255) comment '�������',
   type                 TINYINT unsigned not null comment '�������ͣ�0: "call", 1: "video"��',
   max_participants     INT unsigned default 8 comment '��������',
   is_calling           BOOLEAN comment '�Ƿ����ڽ�����',
   is_only_age_verfy    BOOLEAN comment '�Ƿ������������֤���û�����',
   is_only_vip          BOOLEAN comment '�Ƿ�ֻ����vip�û�����',
   start_at             BIGINT unsigned not null comment '��ʼʱ��',
   end_at               BIGINT unsigned comment '����ʱ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_calling_room comment 'ͨ�������';

/*==============================================================*/
/* Table: t_calling_user                                        */
/*==============================================================*/
create table t_calling_user
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   calling_room_id      BIGINT unsigned not null comment '����ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   is_owner             BOOLEAN comment '�Ƿ��Ƿ���',
   join_at              BIGINT unsigned not null comment '���뷿��ʱ��',
   leave_at             BIGINT unsigned comment '�뿪����ʱ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_calling_user comment 'ͨ������-�û�������';

/*==============================================================*/
/* Table: t_comment                                             */
/*==============================================================*/
create table t_comment
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned not null comment 'Ͷ��ID',
   commentator_id       BIGINT unsigned not null comment '������ID',
   parent_id            BIGINT unsigned comment '��ID��ΪNULLʱ������Ͷ�壻��ΪNULLʱ���ظ����ۡ���',
   content              VARCHAR(1000) comment '��������',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_comment comment '���۱�';

/*==============================================================*/
/* Table: t_follower                                            */
/*==============================================================*/
create table t_follower
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   follower_id          BIGINT unsigned not null comment '��˿ID',
   is_follow            BOOLEAN comment '�Ƿ��ע',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_follower comment '��˿��';

/*==============================================================*/
/* Table: t_group                                               */
/*==============================================================*/
create table t_group
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   owner_id             BIGINT unsigned not null comment '������ID',
   group_category_id    BIGINT unsigned not null comment '�����ID',
   title                VARCHAR(255) not null comment '��ı���',
   description          VARCHAR(1000) comment '�������',
   cover                VARCHAR(255) comment '����URL',
   cover_thumbnail      VARCHAR(255) comment '��������ͼURL',
   is_need_agree        BOOLEAN comment '�û������Ƿ���Ҫ���',
   is_calling_top       BOOLEAN comment '�Ƿ�ͨ���ö�',
   is_only_age_verfy    BOOLEAN comment '�Ƿ������������֤���û�����',
   is_only_same_gender  BOOLEAN comment '�Ƿ�ʹ�����ͬ�Ա���˼���',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_group comment '�û���������ı�
';

/*==============================================================*/
/* Table: t_group_category                                      */
/*==============================================================*/
create table t_group_category
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 CHAR(10) not null comment '��������',
   icon                 VARCHAR(255) comment '����ͼ��URL',
   color                CHAR(10) comment 'ʮ�����Ʊ�ʾ����ɫ��ҳ����ʾʹ��',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_group_category comment '������';

/*==============================================================*/
/* Table: t_history                                             */
/*==============================================================*/
create table t_history
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   visitor_id           BIGINT unsigned not null comment '������ID',
   visited_id           BIGINT unsigned not null comment '��������ID',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_history comment '��ҳ������ʷ��';

/*==============================================================*/
/* Table: t_join_group                                          */
/*==============================================================*/
create table t_join_group
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   group_id             BIGINT unsigned not null comment '��ID',
   is_join              BOOLEAN comment '�Ƿ����',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_join_group comment '�û��μӵ���ı�';

/*==============================================================*/
/* Table: t_letter                                              */
/*==============================================================*/
create table t_letter
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   letter_user_id       BIGINT unsigned not null comment '������ID',
   letter               VARCHAR(1000) comment '��������',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_letter comment '���Ա�';

/*==============================================================*/
/* Table: t_like                                                */
/*==============================================================*/
create table t_like
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned comment 'Ͷ��ID',
   comment_id           BIGINT unsigned comment '����ID',
   user_id              BIGINT unsigned not null comment '������ID',
   is_like              BOOLEAN comment '�Ƿ����',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_like comment '���ޱ�';

/*==============================================================*/
/* Table: t_login_log                                           */
/*==============================================================*/
create table t_login_log
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   user_auth_id         BIGINT unsigned not null comment '�û���ȨID',
   platform             TINYINT unsigned comment 'ƽ̨��0: "Andorid", 1: "IOS"��',
   model                VARCHAR(50) comment '�ͺ�',
   brand                VARCHAR(50) comment 'Ʒ��',
   skd_version          CHAR(10) comment 'SDK�汾',
   sys_version          CHAR(10) comment 'ϵͳ�汾',
   login_ip             VARCHAR(255) comment '��¼ip',
   login_address        VARCHAR(255),
   login_at             BIGINT unsigned comment '��¼ʱ��',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_login_log comment '��¼��־��';

/*==============================================================*/
/* Table: t_login_status                                        */
/*==============================================================*/
create table t_login_status
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   is_online            BOOLEAN comment '�û��Ƿ�����',
   online_status        VARCHAR(30) comment '����״̬',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_login_status comment '��¼״̬��';

/*==============================================================*/
/* Table: t_notice                                              */
/*==============================================================*/
create table t_notice
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   receiver_id          BIGINT unsigned not null comment '�����û�ID',
   action_user_id       BIGINT unsigned not null comment '�����û�ID',
   type                 TINYINT unsigned not null comment '֪ͨ���ͣ�0: "group_created", 1:"group_invite", 2:"follow", 3:"like",  4:"group_accepted"��',
   object_id            BIGINT unsigned comment '֪ͨ����ID��Ͷ��ID����ID...����ǹ�ע�����ã�',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_notice comment '��Ϣ֪ͨ��';

/*==============================================================*/
/* Table: t_permission                                          */
/*==============================================================*/
create table t_permission
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 VARCHAR(10) not null comment 'Ȩ������',
   ename                VARCHAR(50) not null comment 'Ȩ��Ӣ������',
   description          VARCHAR(255) comment 'Ȩ������',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_permission comment 'Ȩ�ޱ�';

/*==============================================================*/
/* Table: t_post                                                */
/*==============================================================*/
create table t_post
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   group_id             BIGINT unsigned comment '��ID',
   content              VARCHAR(1000) comment 'Ͷ������',
   type                 TINYINT unsigned not null comment 'Ͷ�����ͣ�0: "text", 1: "image", 2: "call", 3: "video"��',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_post comment 'Ͷ���';

/*==============================================================*/
/* Table: t_post_img                                            */
/*==============================================================*/
create table t_post_img
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   post_id              BIGINT unsigned not null comment 'Ͷ��ID',
   img                  VARCHAR(255) not null comment 'ͼƬURL',
   img_thumbnail        VARCHAR(255) not null comment 'ͼƬ����ͼURL',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_post_img comment 'Ͷ��ͼƬ��';

/*==============================================================*/
/* Table: t_report                                              */
/*==============================================================*/
create table t_report
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   reporter_id          BIGINT unsigned not null comment '�ٱ���ID',
   reproted_id          BIGINT unsigned not null comment '���ٱ���ϢID�������������á�ͨ������ID��Ͷ��ID...��',
   report_reason_id     BIGINT unsigned not null comment '�ٱ�����ID',
   type                 TINYINT unsigned not null comment '�ٱ����ͣ�0: "post", 1: "call", 2: "group"��',
   attach_img1          VARCHAR(255) comment '����ͼƬ1��URL',
   attach_img2          VARCHAR(255) comment '����ͼƬ2��URL',
   attach_img3          VARCHAR(255) comment '����ͼƬ3��URL',
   attach_img4          VARCHAR(255) comment '����ͼƬ4��URL',
   attach_img5          VARCHAR(255) comment '����ͼƬ5��URL',
   description          VARCHAR(1000) comment '��ϸ����',
   is_handled           BOOLEAN comment '�Ƿ��Ѵ���',
   handler_id           BIGINT unsigned comment '������ID������Ա��ID��',
   handled_at           BIGINT unsigned,
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_report comment '�ٱ���';

/*==============================================================*/
/* Table: t_report_reason                                       */
/*==============================================================*/
create table t_report_reason
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   content              VARCHAR(255) comment '����',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_report_reason comment '�ٱ����ɱ�';

/*==============================================================*/
/* Table: t_role                                                */
/*==============================================================*/
create table t_role
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   name                 VARCHAR(10) not null comment '��ɫ����',
   ename                VARCHAR(50) not null comment '��ɫӢ������',
   description          VARCHAR(255) comment '��ɫ����',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_role comment '��ɫ��';

/*==============================================================*/
/* Table: t_role_permission                                     */
/*==============================================================*/
create table t_role_permission
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   role_id              BIGINT unsigned not null comment '��ɫID',
   permission_id        BIGINT unsigned not null comment 'Ȩ��ID',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_role_permission comment '��ɫ-Ȩ�޹�����';

/*==============================================================*/
/* Table: t_user                                                */
/*==============================================================*/
create table t_user
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   userid               VARCHAR(64) not null comment '�û���ʶID',
   telephone            VARCHAR(20) comment '�ֻ���',
   email                VARCHAR(50) comment '����',
   nickname             VARCHAR(255) not null comment '�ǳ�',
   biography            VARCHAR(255) comment '���˼��',
   avatar_thumbnail     VARCHAR(255) comment 'ͷ������ͼURL',
   avatar               VARCHAR(255) comment 'ͷ��URL',
   cover                VARCHAR(255) comment '����URL',
   cover_thumbnail      VARCHAR(255) comment '��������ͼURL',
   province             CHAR(10) comment 'ʡ��',
   gender               TINYINT unsigned comment '�Ա�0��Ů��1���У�',
   birthday             CHAR(10) comment '����',
   is_age_verified      BOOLEAN comment '�Ƿ���������֤',
   is_vip               BOOLEAN comment '�Ƿ���vip',
   vip_start_at         BIGINT unsigned comment 'vip��ͨʱ��',
   vip_end_at           BIGINT unsigned comment 'vip����ʱ��',
   is_new_user          BOOLEAN comment '�Ƿ������û�',
   is_dangerous_user    BOOLEAN comment '�Ƿ���Σ���û�',
   status               VARCHAR(30) comment '״̬',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id),
   key AK_uq_userid (userid)
);

alter table t_user comment '�û���
';

/*==============================================================*/
/* Table: t_user_auth                                           */
/*==============================================================*/
create table t_user_auth
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   type                 TINYINT unsigned not null comment '��¼���ͣ�0: "phone", 1: "wechat", 2: "qq", 3: "weibo"��',
   identifier           VARCHAR(255) not null comment '��¼���û���',
   credential           VARCHAR(255) not null comment '��¼������',
   salt                 char(10) comment '�Σ��������ʹ�ã�',
   is_deleted           BOOLEAN comment '�Ƿ�ɾ��',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_user_auth comment '�û���Ȩ��';

/*==============================================================*/
/* Table: t_user_block                                          */
/*==============================================================*/
create table t_user_block
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   blocked_user_id      BIGINT unsigned not null comment '�������û�ID',
   is_block             BOOLEAN comment '�Ƿ�����',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_user_block comment '�����û���';

/*==============================================================*/
/* Table: t_user_privacy_settings                               */
/*==============================================================*/
create table t_user_privacy_settings
(
   id                   BIGINT unsigned not null auto_increment comment 'ID',
   user_id              BIGINT unsigned not null comment '�û�ID',
   is_allow_follow      BOOLEAN default true comment '�Ƿ�����ֱ�ӹ�ע',
   is_show_post_only_follower BOOLEAN comment '�Ƿ�Ͷ�����˿�ɼ�',
   is_write_letter_only_follower BOOLEAN comment '�Ƿ����˿��������',
   is_show_join_group   BOOLEAN default true comment '�Ƿ�չʾ�������',
   is_chat_only_follow  BOOLEAN comment '�Ƿ�������ע���˷�����Ϣ',
   is_call_invite_only_follow BOOLEAN comment '�Ƿ�������ע���˷���ͨ������',
   is_group_invite_only_follow BOOLEAN comment '�Ƿ�������ע���˷��ͼ����������',
   is_allow_search      BOOLEAN default true comment '�Ƿ�ɱ��û�����',
   is_hide_online_status BOOLEAN comment '�Ƿ���������״̬����Աר�ã�',
   is_hide_access_history BOOLEAN comment '�Ƿ����ط��ʼ�¼����Աר�ã�',
   created_at           BIGINT unsigned not null comment '����ʱ��',
   updated_at           BIGINT unsigned not null comment '����ʱ��',
   primary key (id)
);

alter table t_user_privacy_settings comment '�û���˽���ñ�';

