package com.z.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.common.ResultCodeEnum;
import com.z.constant.PhoneCodeConstant;
import com.z.constant.UserConstant;
import com.z.entity.UserAuth;
import com.z.service.UserService;
import com.z.util.RedisUtil;
import com.z.vo.LoginVo;

@RestController
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private UserService userService;

    /**
     * 登录
     * @param loginVo 登录数据
     * @return
     */
    public R login(@RequestBody LoginVo loginVo) {
        String username = loginVo.getUsername();
        String password = loginVo.getPassword();
        Integer loginType = loginVo.getLoginType();
        // 手机验证码登录
        if (loginType == UserConstant.LOGIN_TYPE_PHONE_CODE) {
            // 判断验证码是否正确
            String redisCode = redisUtil.get(PhoneCodeConstant.CODE_TYPE_LOGIN+username);
            if (StringUtils.isEmpty(redisCode) || !password.equals(redisCode)) {
                return R.error(ResultCodeEnum.CODE_ERROR);
            }
            // 判断用户是否已注册
            UserAuth userAuth = userService.findByUsername(username,UserConstant.LOGIN_TYPE_PHONE_CODE);
            if (ObjectUtils.isEmpty(userAuth)) {
                
            }
            
        }

        // TODO 从Redis获取登录类型的验证码并验证
        // TODO 判断改手机号是否已注册，没有没有，则进行注册
        return R.success();
    }
}





