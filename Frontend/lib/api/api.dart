import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("/api/v1/Game/upgrades")
  Future<List<UpgradeModel>> getAllUpgrades();

  @GET("/api/Admin/ClearDB")
  Future<void> clearDB();

  @POST("/api/Auth/login-telegram")
  Future<LoginResponse> loginTelegram(@Body() TelegramValidateRequest body);

  @POST("/api/Auth/login")
  Future<void> login(@Body() TelegramValidateRequest body);

  @POST("/api/v1/Game/sync")
  Future<ClickResponse> gameSync(@Body() SyncRequest request);

  @POST("/api/v1/Game/buy/{upgradeId}")
  Future<BuyUpgradeResponse> buyUpgrade(@Path("upgradeId") String upgradeId);

  @POST("/api/Game/BuyBooster")
  Future<StringApiResponse> buyBooster(@Body() BuyBoosterRequest body);
}
