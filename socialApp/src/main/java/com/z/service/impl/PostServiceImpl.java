package com.z.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.z.service.PostService;
import com.z.vo.PostVo;

@Service
public class PostServiceImpl implements PostService{
    
    @Autowired
    private PostMapping postMapper;


    @Transactional
    @Override
    public void post(PostVo postVo) {
        Integer type = postVo.getType();
        String text = postVo.getText();
        MultipartFile[] files = postVo.getFiles();
        // 保存投稿表
        
        
        // 保存投稿图片表
    }

}
