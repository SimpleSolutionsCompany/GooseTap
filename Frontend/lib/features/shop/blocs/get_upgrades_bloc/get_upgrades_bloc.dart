import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';

part 'get_upgrades_event.dart';
part 'get_upgrades_state.dart';

class GetUpgradesBloc extends Bloc<GetUpgradesEvent, GetUpgradesState> {
  GetUpgradesBloc({required this.restClient}) : super(GetUpgradesInitial()) {
    on<OnGetUpgradesEvent>(_onGetUpgradesEvent);
  }

  Future<void> _onGetUpgradesEvent(
    OnGetUpgradesEvent event,
    Emitter<GetUpgradesState> emit,
  ) async {
    emit(GetUpgradesProgress());
    try {
      final MainUpgradeModel response = await restClient.getAllUpgrades();
      final List<UpgradeModel> upgrades = response.upgrades;
      emit(GetUpgradesSuccess(upgrades: upgrades));
    } catch (e) {
      log("Error is $e");
      emit(GetUpgradesFailure(errorMessage: e.toString()));
    }
  }

  final RestClient restClient;
}
