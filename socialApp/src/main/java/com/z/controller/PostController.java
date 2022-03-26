package com.z.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.service.PostService;
import com.z.vo.PostVo;

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
    public R post(PostVo postVo) {
        postService.post(postVo);
        return R.success();
    }
}
