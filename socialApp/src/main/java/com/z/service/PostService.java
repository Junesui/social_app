package com.z.service;

import java.io.IOException;

import com.z.common.R;
import com.z.vo.PostVo;

/**
 * 投稿接口
 */
public interface PostService {

    // 投稿
    public R post(PostVo postVo) throws IOException;
    
}
