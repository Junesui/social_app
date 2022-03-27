package com.z.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.z.entity.CallRoom;
import com.z.entity.CallUser;
import com.z.entity.Post;
import com.z.entity.PostImg;

/**
 * 投稿接口
 */
@Mapper
public interface PostMapper {

    // 保存投稿表
    void save(Post post);

    // 保存投稿图片表
    void savePostImgs(List<PostImg> postImgs);

    // 保存通话房间表
    void saveCallRoom(CallRoom callRoom);

    // 保存通话房间-用户关联表
    void saveCallUser(CallUser callUser);
}
