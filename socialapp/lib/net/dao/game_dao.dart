import 'package:dio/dio.dart';
import 'package:socialapp/model/game/game_model.dart';

class GameDao {
  /// https://api.yay.space/v1/games/apps?number=20
  /// 游戏
  static Future<GameModel> getGame() async {
    String url = "https://api.yay.space/v1/games/apps?number=20";
    var response = await Dio().get(url);
    return GameModel.fromJson(response.data);
  }
}
