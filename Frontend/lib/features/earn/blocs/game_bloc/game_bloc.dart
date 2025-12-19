import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:goose_tap/api/repository/game_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _gameRepository;
  Timer? _syncTimer;

  // Temporary buffer
  int _pendingClicks = 0;
  int _pendingEnergy = 0;

  Timer? _regenTimer;

  GameBloc({required GameRepository gameRepository})
      : _gameRepository = gameRepository,
        super(GameInitial()) {
    on<GameStarted>(_onGameStarted);
    on<GameClicked>(_onGameClicked);
    on<GameSyncRequested>(_onGameSyncRequested);
    on<GameEnergyRegen>(_onGameEnergyRegen);
    on<BoosterPurchased>(_onBoosterPurchased);
  }

  Future<void> _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      final cached = await _gameRepository.getCachedCheckpoint();
      
      int balance = cached?.balance ?? 0;
      int profitPerClick = cached?.profitPerClick ?? 1;
      int energyRestorePerSecond = cached?.energyRestorePerSecond ?? 1;
      int maxEnergy = cached?.maxEnergy ?? 1000;
      
      double profitPerHour = 0;
      int level = cached?.level ?? 1;
      double progress = cached?.progress ?? 0.0;

      emit(GameLoaded(
        balance: balance,
        energy: energy,
        maxEnergy: maxEnergy,
        profitPerHour: profitPerHour.toDouble(),
        level: level,
        progress: progress,
        multitapLevel: multitapLevel,
        energyLimitLevel: energyLimitLevel,
        rechargeSpeedLevel: rechargeSpeedLevel,
        profitPerClick: profitPerClick,
        energyRestorePerSecond: energyRestorePerSecond,
      ));

      // Initial Sync
      try {
        final synced = await _gameRepository.sync(
          clicks: 0,
          level: level,
          progress: progress,
        );
        
        balance = synced.balance;
        energy = synced.currentEnergy;
        profitPerClick = synced.profitPerClick;
        energyRestorePerSecond = synced.energyRestorePerSecond;
        maxEnergy = synced.maxEnergy;

        emit(GameLoaded(
          balance: balance,
          energy: energy,
          maxEnergy: maxEnergy,
          profitPerHour: profitPerHour.toDouble(),
          level: level,
          progress: progress,
          multitapLevel: multitapLevel,
          energyLimitLevel: energyLimitLevel,
          rechargeSpeedLevel: rechargeSpeedLevel,
          profitPerClick: profitPerClick,
          energyRestorePerSecond: energyRestorePerSecond,
        ));
      } catch (e) {
        log("Sync failed: $e");
      }
      
      _startFlushTimer();
      _startRegenTimer(); 
    } catch (e) {
      emit(GameError(message: e.toString()));
    }
  }

  void _onGameClicked(
    GameClicked event,
    Emitter<GameState> emit,
  ) {
    if (state is GameLoaded) {
      final currentinfo = state as GameLoaded;
      
      if (currentinfo.energy < 1) return;

      // Use dynamic profitPerClick
      final newBalance = currentinfo.balance + currentinfo.profitPerClick;
      final newEnergy = currentinfo.energy - 1;
      
      int level = currentinfo.level;
      if (level < 1) level = 1;
      
      double progress = currentinfo.progress;
      final required = _requiredClicksForLevel(level);
      
      if (required > 0) {
        progress += currentinfo.profitPerClick / required; // Progress based on earnings or clicks? Usually earnings.
        // Let's assume progress is based on coins earned
      }

      if (progress >= 1.0) {
        progress = 0; 
        level++;
      }

      _pendingClicks++; // This counts physical clicks
      _pendingEnergy++; // This counts energy spent

      emit(currentinfo.copyWith(
        balance: newBalance,
        energy: newEnergy,
        level: level,
        progress: progress,
      ));
    }
  }

  void _onGameEnergyRegen(GameEnergyRegen event, Emitter<GameState> emit) {
      if (state is GameLoaded) {
        final current = state as GameLoaded;
        if (current.energy < current.maxEnergy) {
          int newEnergy = current.energy + current.energyRestorePerSecond;
          if (newEnergy > current.maxEnergy) newEnergy = current.maxEnergy;
          emit(current.copyWith(energy: newEnergy));
        }
      }
  }

  Future<void> _onBoosterPurchased(BoosterPurchased event, Emitter<GameState> emit) async {
    try {
      if (state is GameLoaded) {
         // Optimistic update could be complex because we need price logic here to deduct balance
         // For now, let's just make the call and then Sync
         await _gameRepository.buyBooster(BuyBoosterRequest(type: event.type));
         add(GameSyncRequested());
      }
    } catch (e) {
      log("Booster purchase failed: $e");
    }
  }

  int _requiredClicksForLevel(int level) {
    if (level <= 1) return 100;
    if (level == 2) return 1000;
    if (level == 3) return 3000;
    if (level == 4) return 5000;
    if (level == 5) return 8000;
    if (level == 6) return 15000;
    if (level == 7) return 30000;
    if (level == 8) return 50000;
    return level * 1000;
  }

  Future<void> _onGameSyncRequested(
    GameSyncRequested event,
    Emitter<GameState> emit,
  ) async {
    final clicksToSync = _pendingClicks;
    int? currentLevel;
    double? currentProgress;
    
    if (state is GameLoaded) {
      final current = state as GameLoaded;
      currentLevel = current.level;
      currentProgress = current.progress;
    }

    try {
      final synced = await _gameRepository.sync(
        clicks: clicksToSync,
        level: currentLevel,
        progress: currentProgress,
      );

      // Only reset pending if sync was successful
      _pendingClicks -= clicksToSync;
      if (_pendingClicks < 0) _pendingClicks = 0;

      if (state is GameLoaded) {
        final current = state as GameLoaded;
        emit(current.copyWith(
          balance: synced.balance,
          energy: synced.currentEnergy,
          maxEnergy: synced.maxEnergy,
          profitPerClick: synced.profitPerClick,
          energyRestorePerSecond: synced.energyRestorePerSecond,
        ));
      }
    } catch (e) {
      log("Sync error: $e. Pending clicks $clicksToSync kept in buffer.");
    }
  }

  void _startFlushTimer() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      add(GameSyncRequested());
    });
  }

  void _startRegenTimer() {
    _regenTimer?.cancel();
    _regenTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(GameEnergyRegen());
    });
  }

  @override
  Future<void> close() {
    _syncTimer?.cancel();
    _regenTimer?.cancel();
    return super.close();
  }
}
