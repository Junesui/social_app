package com.z.util.zego;

/**
 * 即构相关工具类
 */
public class ZegoUtil {
    /**
     * 生成用于与即构服务端通信的鉴权 token
     * 
     * @param appId                  Zego派发的数字ID, 开发者的唯一标识
     * @param secretKey              由即构提供的与 appId 对应的密钥
     * @param effectiveTimeInSeconds token有效时间(秒)
     * @param verbose                是否调试模式(调试时，置为 true, 可在控制台输出更多信息；正式运行时，置为 false)
     * @param userId                 用户ID(同一 appId 下全网唯一)
     * @return 生成的Token
     */
    public static String gengrateToken(Long appId, String secretKey, int effectiveTimeInSeconds, Boolean verbose,
            String userId) {
        // 普通token，payload字段可传空
        String payload = "";
        TokenServerAssistant.TokenInfo token = TokenServerAssistant.generateToken04(appId, userId, secretKey,
                effectiveTimeInSeconds, payload);
        if (token.error == null || token.error.code == TokenServerAssistant.ErrorCode.SUCCESS) {
            return token.data;
        }
        return "";
    }
}
