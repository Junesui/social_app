/// 通话房间信息
class CallingRoomInfoModel {
  CallingRoomInfoModel({
    this.appId,
    this.roomId,
    this.userId,
    this.token,
    this.avatarThum,
    this.nickname,
  });

  CallingRoomInfoModel.fromJson(dynamic json) {
    appId = json['appId'];
    roomId = json['roomId'];
    userId = json['userId'];
    token = json['token'];
    avatarThum = json['avatarThum'];
    nickname = json['nickname'];
  }
  int? appId;
  int? roomId;
  int? userId;
  String? token;
  String? avatarThum;
  String? nickname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roomId'] = roomId;
    map['userId'] = userId;
    map['token'] = token;
    map['avatarThum'] = avatarThum;
    map['nickname'] = nickname;
    return map;
  }
}
