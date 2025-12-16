import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("/api/Upgrades")
  Future<MainUpgradeModel> getAllUpgrades();

  @GET("/api/Admin/ClearDB")
  Future<void> clearDB();

  @POST("/api/Auth/login-telegram")
  Future<LoginResponse> loginTelegram(@Body() TelegramValidateRequest body);

  @POST("/api/Auth/login")
  Future<void> login(@Body() TelegramValidateRequest body);

  @POST("/api/Game/Click")
  Future<StringApiResponse> gameClick(@Body() GameUpdateRequest body);

  @POST("/api/Game/Sync")
  Future<CheckpointResponse> gameSync(@Body() SyncRequest body);

  @POST("/api/Upgrades/Buy")
  Future<void> buyUpgrade(@Body() BuyUpgradeRequest body);

  @POST("/api/Game/BuyBooster")
  Future<StringApiResponse> buyBooster(@Body() BuyBoosterRequest body);
}
