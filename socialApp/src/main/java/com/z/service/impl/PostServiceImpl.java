package com.z.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.z.common.R;
import com.z.constant.FileConstant;
import com.z.constant.PostConstant;
import com.z.entity.CallRoom;
import com.z.entity.CallUser;
import com.z.entity.Post;
import com.z.entity.PostImg;
import com.z.interceptor.LoginInterceptor;
import com.z.mapper.PostMapper;
import com.z.properties.FileConfigProperties;
import com.z.service.PostService;
import com.z.util.MyFileUtil;
import com.z.vo.PostVo;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostMapper postMapper;
    @Autowired
    private FileConfigProperties fileProperties;

    @Transactional
    @Override
    public R post(PostVo postVo) throws IOException {
        Long userId = LoginInterceptor.threadLocal.get().getUserId();
        LoginInterceptor.threadLocal.remove();

        Integer type = postVo.getType();
        String text = postVo.getText();
        MultipartFile[] files = postVo.getFiles();
        // 1.保存投稿表
        Post post = new Post();
        post.setUserId(userId);
        post.setContent(text);
        post.setType(type);
        post.setCreatedAt(System.currentTimeMillis());
        post.setUpdatedAt(System.currentTimeMillis());
        postMapper.save(post);
        Long postId = post.getId();

        // 2.保存图片和投稿图片表
        List<PostImg> postImgs = new ArrayList<PostImg>();
        if (!ObjectUtils.isEmpty(files)) {
            for (int i = 0; i < files.length; i++) {
                String imgPath = MyFileUtil.getFullFilePath(fileProperties.getSavaBaseDir(), FileConstant.POST, userId);
                String thumPath = imgPath + FileConstant.THUM_SUFFIX;
                String imgUrl = new StringBuffer().append(fileProperties.getAccessPrefix())
                        .append(imgPath.substring(fileProperties.getSavaBaseDir().length())).toString();
                String thumUrl = new StringBuffer().append(fileProperties.getAccessPrefix())
                        .append(thumPath.substring(fileProperties.getSavaBaseDir().length())).toString();
                PostImg postImg = new PostImg();
                postImg.setPostId(postId);
                postImg.setImg(imgUrl);
                postImg.setImgThumbnail(thumUrl);
                postImg.setCreatedAt(System.currentTimeMillis());
                postImg.setUpdatedAt(System.currentTimeMillis());
                postImgs.add(postImg);
                // 保存图片
                MyFileUtil.save(files[i], imgPath);
                MyFileUtil.saveThum(files[i], thumPath);
            }
        }
        // 保存投稿图片表
        if (!ObjectUtils.isEmpty(postImgs)) {
            postMapper.savePostImgs(postImgs);
        }

        // 3.如果投稿是语音或视频类型，保存通话房间和通话房间-用户关联表
        if (type == PostConstant.POST_TYPE_CALL || type == PostConstant.POST_TYPE_VIDEO) {
            // 保存通话房间表
            CallRoom callRoom = new CallRoom();
            Integer roomType = type == PostConstant.POST_TYPE_CALL ? PostConstant.ROOM_TYPE_CALL
                    : PostConstant.ROOM_TYPE_VIDEO;
            callRoom.setOwerId(userId);
            callRoom.setType(roomType);
            callRoom.setIsCalling(true);
            callRoom.setStartAt(System.currentTimeMillis());
            callRoom.setCreatedAt(System.currentTimeMillis());
            callRoom.setUpdatedAt(System.currentTimeMillis());
            postMapper.saveCallRoom(callRoom);
            Long callRoomid = callRoom.getId();

            // 保存通话房间-用户关联表
            CallUser callUser = new CallUser();
            callUser.setCallRoomId(callRoomid);
            callUser.setUserId(userId);
            callUser.setIsOwner(true);
            callUser.setJoinAt(System.currentTimeMillis());
            callUser.setCreatedAt(System.currentTimeMillis());
            callUser.setUpdatedAt(System.currentTimeMillis());
            postMapper.saveCallUser(callUser);
            return R.success().data(callRoom);
        }
        return R.success();

    }

}
