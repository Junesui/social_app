package com.z.service;

import java.io.IOException;

import com.z.vo.PostVo;

/**
 * 投稿接口
 */
public interface PostService {

    // 投稿
    public void post(PostVo postVo) throws IOException;
    
}
