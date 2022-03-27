package com.z.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.UUID;
import net.coobird.thumbnailator.Thumbnails;

/**
 * 文件上传工具类
 */
public class MyFileUtil {

    /**
     * 保存文件
     * 
     * @param file         要保存的源文件
     * @param fullFilePath 文件全路径
     * @throws IOException
     */
    public static void save(MultipartFile file, String fullFilePath) throws IOException {
        String dirPath = FileUtil.getParent(fullFilePath, 1);
        // 判断目录是否存在，不存在则创建目录
        if (!FileUtil.isDirectory(dirPath)) {
            FileUtil.mkdir(dirPath);
        }

        // 保存文件
        FileUtil.writeFromStream(new ByteArrayInputStream(file.getBytes()), fullFilePath);
    }

    /**
     * 保存图片缩略图(200*200)
     * 
     * @param file         源文件
     * @param fullFilePath 文件的全路径
     * @throws IOException
     */
    public static void saveThum(MultipartFile file, String fullFilePath) throws IOException {
        ByteArrayInputStream is = new ByteArrayInputStream(file.getBytes());
        FileOutputStream os = new FileOutputStream(new File(fullFilePath));
        Thumbnails.of(is).size(200, 200).toOutputStream(os);
        is.close();
        os.close();
    }

    /**
     * 生成保存文件的全路径 [saveBaseDir/type/userId/year/month/day/filename]
     * 
     * @param saveBaseDir 保存的共同基本路径[从配置文件获取]
     * @param type        保存的类型[常量文件中获取]
     * @param userId      当前登录的用户信息ID
     * @return 文件全路径
     */
    public static String getFullFilePath(String saveBaseDir, String type, Long userId) {
        int year = DateUtil.thisYear();
        int month = DateUtil.thisMonth() + 1;
        int day = DateUtil.thisDayOfMonth();

        String path = new StringBuffer().append(saveBaseDir).append("/").append(type).append("/").append(userId)
                .append("/").append(year).append("/").append(month).append("/").append(day).append("/")
                .append(UUID.randomUUID().toString().replace("-", "")).toString();

        return path;
    }
    

}
