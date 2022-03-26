package com.z.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.z.common.R;
import com.z.common.ResultCodeEnum;
import com.z.constant.PhoneCodeConstant;
import com.z.constant.UserConstant;
import com.z.entity.UserAuth;
import com.z.properties.JWTConfigProperties;
import com.z.service.UserService;
import com.z.util.JwtUtil;
import com.z.util.RedisUtil;
import com.z.vo.LoginVo;

/**
 * 用户控制器
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private UserService userService;
    @Autowired
    private JWTConfigProperties jwtProperties;

    /**
     * 登录
     * 
     * @param loginVo 登录数据对象
     * @return
     */
    @PostMapping("/login")
    public R login(@RequestBody LoginVo loginVo) {
        String username = loginVo.getUsername();
        String password = loginVo.getPassword();
        Integer loginType = loginVo.getLoginType();
        // 手机验证码登录
        if (loginType == UserConstant.LOGIN_TYPE_PHONE_CODE) {
            return loginWithPhoneCode(username, password);
        }

        return R.error(ResultCodeEnum.NOT_LOGIN);
    }

    /**
     * 手机验证码登录
     * 
     * @param phone 手机号码
     * @param code  验证码
     * @return R
     */
    private R loginWithPhoneCode(String phone, String code) {
        // 判断验证码是否正确
        String redisCode = redisUtil.get(PhoneCodeConstant.CODE_TYPE_LOGIN + phone);
        if (StringUtils.isEmpty(redisCode) || !code.equals(redisCode)) {
            return R.error(ResultCodeEnum.CODE_ERROR);
        }
        // 判断用户是否已注册，没有，则进行手机号注册
        UserAuth userAuth = userService.findByUsername(phone, UserConstant.LOGIN_TYPE_PHONE_CODE);
        if (ObjectUtils.isEmpty(userAuth)) {
            userService.saveByPhone(phone, UserConstant.LOGIN_TYPE_PHONE_CODE);
            userAuth = userService.findByUsername(phone, UserConstant.LOGIN_TYPE_PHONE_CODE);
        }
        userAuth.setPassword(null);
        // 生成token并返回
        String loginToken = JwtUtil.createToken(userAuth, jwtProperties.getLoginKeepDays(),
                jwtProperties.getTokenSecretKey());
        return R.success().data(loginToken);
    }
}
