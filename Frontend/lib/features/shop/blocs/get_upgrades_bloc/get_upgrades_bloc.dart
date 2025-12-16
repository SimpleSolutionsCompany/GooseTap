import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:goose_tap/api/repository/upgrades_repository.dart';

part 'get_upgrades_event.dart';
part 'get_upgrades_state.dart';

class GetUpgradesBloc extends Bloc<GetUpgradesEvent, GetUpgradesState> {
  final UpgradesRepository upgradesRepository;

  GetUpgradesBloc({required this.upgradesRepository}) : super(GetUpgradesInitial()) {
    on<OnGetUpgradesEvent>(_onGetUpgradesEvent);
    on<OnBuyUpgradeEvent>(_onBuyUpgradeEvent);
  }

  Future<void> _onGetUpgradesEvent(
    OnGetUpgradesEvent event,
    Emitter<GetUpgradesState> emit,
  ) async {
    emit(GetUpgradesProgress());
    try {
      // First try to load from cache immediately
      final cached = await upgradesRepository.getCachedUpgrades();
      if (cached.isNotEmpty) {
        emit(GetUpgradesSuccess(upgrades: cached));
      }

      // Then fetch fresh data
      final upgrades = await upgradesRepository.getUpgrades();
      emit(GetUpgradesSuccess(upgrades: upgrades));
    } catch (e) {
      log("Error is $e");
      // If we emitted success from cache, we might want to keep showing it but maybe show a snackbar?
      // For now, if we have cache, we don't emit failure to replace success.
      if (state is! GetUpgradesSuccess) {
         emit(GetUpgradesFailure(errorMessage: e.toString()));
      }
    }
  }

  Future<void> _onBuyUpgradeEvent(
    OnBuyUpgradeEvent event,
    Emitter<GetUpgradesState> emit,
  ) async {
      try {
          await upgradesRepository.buyUpgrade(event.id);
          // Refresh list after buying
          add(OnGetUpgradesEvent());
      } catch (e) {
          log("Error buying upgrade: $e");
          // Ideally emit a side-effect or error state, but for simplicty just logging
      }
  }
}
