package com.z.util;

import java.util.Calendar;
import java.util.Date;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.z.common.ResultCodeEnum;
import com.z.entity.UserAuth;
import com.z.exception.SocialappException;

/**
 * JWT 登录认证工具类
 */
public class JwtUtil {

    /**
     * 生成 token
     * 
     * @param userAuth 用户登录对象
     * @return
     */
    public static String createToken(UserAuth userAuth, Integer loginKeepDays, String tokenSecretKey) {
        // token有效时间
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, loginKeepDays);

        return JWT.create().withAudience(userAuth.getId().toString()) // 签发对象
                .withIssuedAt(new Date()) // 发行时间
                .withExpiresAt(calendar.getTime()) // 到期时间
                .withClaim("userAuth", JSONObject.toJSONString(userAuth)) // 载荷
                .sign(Algorithm.HMAC256(tokenSecretKey)); // 加密
    }

    /**
     * 验证 token 的合法性
     * 
     * @param token
     * @return
     */
    public static Boolean verifyToken(String token, String tokenSecretKey) {
        try {
            JWTVerifier verifier = JWT.require(Algorithm.HMAC256(tokenSecretKey)).build();
            verifier.verify(token);
        } catch (JWTVerificationException exception) {
            throw new SocialappException(ResultCodeEnum.NOT_LOGIN);
        }
        return true;
    }

    /**
     * 获取生成 token 时候的签发对象(用户登录ID)
     * 
     * @param token
     * @return 签发对象
     */
    public static String getUserAuthId(String token) {
        String userAuthId = JWT.decode(token).getAudience().get(0);
        return userAuthId;
    }

}
