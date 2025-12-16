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
  }

  Future<void> _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      final cached = await _gameRepository.getCachedCheckpoint();
      
      int balance = cached?.balance ?? 0;
      int energy = cached?.energy ?? 1000;
      int maxEnergy = cached?.maxEnergy ?? 1000;
      int profitPerHour = cached?.profitPerHour?.round() ?? 0; // Assuming int for simplicity or keep double
      int level = cached?.level ?? 1;
      if (level < 1) level = 1; // Safeguard

      emit(GameLoaded(
        balance: balance,
        energy: energy,
        maxEnergy: maxEnergy,
        profitPerHour: profitPerHour.toDouble(), // Convert back to double for state if needed
        level: level,
      ));

      // Initial Sync
      try {
        final synced = await _gameRepository.sync(0);
        
        balance = synced.balance ?? balance;
        energy = synced.energy ?? energy;
        maxEnergy = synced.maxEnergy ?? maxEnergy;
        profitPerHour = (synced.profitPerHour ?? profitPerHour).round();
        level = synced.level ?? level;
        if (level < 1) level = 1;

        emit(GameLoaded(
          balance: balance,
          energy: energy,
          maxEnergy: maxEnergy,
          profitPerHour: profitPerHour.toDouble(),
          level: level,
        ));
      } catch (e) {
        log("Sync failed: $e");
      }
      
      _startFlushTimer();
      _startRegenTimer(); // Start regeneration
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

      final newBalance = currentinfo.balance + 1;
      final newEnergy = currentinfo.energy - 1;
      
      int level = currentinfo.level;
      if (level < 1) level = 1;
      
      double progress = currentinfo.progress;
      final required = _requiredClicksForLevel(level);
      
      // Safeguard division by zero
      if (required > 0) {
        progress += 1.0 / required;
      }

      if (progress >= 1.0) {
        progress = 0; // Reset progress
        level++;
      }

      _pendingClicks++;
      _pendingEnergy++;

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
          emit(current.copyWith(energy: current.energy + 1));
        }
      }
  }

  int _requiredClicksForLevel(int level) {
    if (level <= 1) return 100; // Safeguard level 0 or negative
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
     await _flushData(emit);
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

  Future<void> _flushData(Emitter<GameState> emit) async {
    if (_pendingClicks == 0) return;

    final clicksToSend = _pendingClicks;
    final energyToSend = _pendingEnergy;
    
    _pendingClicks = 0;
    _pendingEnergy = 0;

    try {
      await _gameRepository.click(clicksToSend, energyToSend);
    } catch (e) {
        print("Failed to sync clicks: $e");
    }
  }

  @override
  Future<void> close() {
    _syncTimer?.cancel();
    _regenTimer?.cancel();
    return super.close();
  }
}
