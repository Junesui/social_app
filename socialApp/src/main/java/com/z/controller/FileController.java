package com.z.controller;

import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.properties.FileConfigProperties;

import cn.hutool.core.io.FileUtil;

/**
 * 文件下载控制器
 */
@RestController
@RequestMapping("/file/download")
public class FileController {

    @Autowired
    private FileConfigProperties fileProperties;

    /**
     * 文件下载
     * 
     * @param type     保存的类型[常量文件中获取]
     * @param userId   当前登录的用户信息ID
     * @param year     年
     * @param month    月
     * @param day      日
     * @param fileName 文件名
     * @param response 响应对象
     * @throws IOException
     */
    @GetMapping("/{type}/{userId}/{year}/{month}/{day}/{fileName}")
    public void download(@PathVariable("type") String type, @PathVariable("userId") Long userId,
            @PathVariable("year") String year, @PathVariable("month") String month, @PathVariable("day") String day,
            @PathVariable("fileName") String fileName, HttpServletResponse response) throws IOException {

        // 获取文件的全路径
        String filePath = new StringBuffer().append(fileProperties.getSavaBaseDir()).append("/").append(type)
                .append("/").append(userId).append("/").append(year).append("/").append(month).append("/").append(day)
                .append("/").append(fileName).toString();

        // 1.创建输出流对象
        ServletOutputStream os = response.getOutputStream();

        // 2.读取文件
        byte[] bytes = FileUtil.readBytes(filePath);

        // 3.设置返回内容格式
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);

        // 4. 数据写入到输出流
        os.write(bytes);

        // 5.关流
        os.close();

    }

}
