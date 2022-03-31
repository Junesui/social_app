package com.z.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.common.ResultCodeEnum;
import com.z.dto.PostDTO;
import com.z.service.PostService;

/**
 * 投稿控制器
 */
@RestController
@RequestMapping("/post")
public class PostController {

    @Autowired
    private PostService postService;

    /**
     * 投稿
     * 
     * @param postVo 投稿数据对象
     * @return
     */
    @PostMapping("/post")
    public R post(PostDTO postVo) {
        try {
            R r = postService.post(postVo);
            return r;
        } catch (IOException e) {
            return R.error(ResultCodeEnum.POST_ERROR);
        }

    }

}
