package com.z.controller;

import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.constant.PhoneCodeConstant;
import com.z.util.RedisUtil;

/**
 * 手机验证码控制器
 */
@RestController
@RequestMapping("/phonecode")
public class PhoneCodeController {

    @Autowired
    private RedisUtil redisUtil;

    /**
     * 发送验证码
     * 
     * @param phone 手机号码
     * @param type  发送验证码的类型（登录，修改密码等）
     * @return
     */
    @GetMapping("/send")
    public R send(@RequestParam("phone") String phone, @RequestParam("type") String type) {
            // 判断redis中该类型的验证码是否已存在
            Boolean isNotExist = StringUtils.isEmpty(redisUtil.get(type + phone));
            Boolean isCanSend = false;
            // 若存在，判断redis中的验证码是否已保存超过1分钟
            if (!isNotExist) {
                Integer hasExpire = Integer.parseInt(
                        redisUtil.getExpire(type + phone, TimeUnit.MINUTES).toString());
                isCanSend = (PhoneCodeConstant.CODE_MINS - hasExpire) > 1;
            }
            // 不存在或者保存超过一分钟，则发送验证码
            if (isNotExist || isCanSend) {
                // TODO 发送手机验证码，假设code为123456
                String code = "123456";
                redisUtil.setEx(type + phone, code, PhoneCodeConstant.CODE_MINS,
                        TimeUnit.MINUTES);
            }

        return R.success();
    }
    

}
