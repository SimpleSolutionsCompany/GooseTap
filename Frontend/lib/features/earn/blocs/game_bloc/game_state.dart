part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

final class GameLoading extends GameState {}

final class GameLoaded extends GameState {
  final int balance;
  final int energy;
  final int maxEnergy;
  final double profitPerHour;
  final int level;
  final double progress; // Added progress

  // Boosters
  final int multitapLevel;
  final int energyLimitLevel;
  final int rechargeSpeedLevel;
  
  final int profitPerClick;
  final int energyRestorePerSecond;

  const GameLoaded({
    required this.balance,
    required this.energy,
    required this.maxEnergy,
    required this.profitPerHour,
    required this.level,
    this.progress = 0.0,
    
    this.multitapLevel = 1,
    this.energyLimitLevel = 1,
    this.rechargeSpeedLevel = 1,
    this.profitPerClick = 1,
    this.energyRestorePerSecond = 1,
  });

  GameLoaded copyWith({
    int? balance,
    int? energy,
    int? maxEnergy,
    double? profitPerHour,
    int? level,
    double? progress,
    int? multitapLevel,
    int? energyLimitLevel,
    int? rechargeSpeedLevel,
    int? profitPerClick,
    int? energyRestorePerSecond,
  }) {
    return GameLoaded(
      balance: balance ?? this.balance,
      energy: energy ?? this.energy,
      maxEnergy: maxEnergy ?? this.maxEnergy,
      profitPerHour: profitPerHour ?? this.profitPerHour,
      level: level ?? this.level,
      progress: progress ?? this.progress,
      multitapLevel: multitapLevel ?? this.multitapLevel,
      energyLimitLevel: energyLimitLevel ?? this.energyLimitLevel,
      rechargeSpeedLevel: rechargeSpeedLevel ?? this.rechargeSpeedLevel,
      profitPerClick: profitPerClick ?? this.profitPerClick,
      energyRestorePerSecond: energyRestorePerSecond ?? this.energyRestorePerSecond,
    );
  }

  @override
  List<Object> get props => [balance, energy, maxEnergy, profitPerHour, level, progress];
}

final class GameError extends GameState {
  final String message;

  const GameError({required this.message});

  @override
  List<Object> get props => [message];
}
