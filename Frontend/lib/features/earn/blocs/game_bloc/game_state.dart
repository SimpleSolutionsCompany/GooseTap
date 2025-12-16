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

  const GameLoaded({
    required this.balance,
    required this.energy,
    required this.maxEnergy,
    required this.profitPerHour,
    required this.level,
    this.progress = 0.0, // Default to 0
  });

  GameLoaded copyWith({
    int? balance,
    int? energy,
    int? maxEnergy,
    double? profitPerHour,
    int? level,
    double? progress,
  }) {
    return GameLoaded(
      balance: balance ?? this.balance,
      energy: energy ?? this.energy,
      maxEnergy: maxEnergy ?? this.maxEnergy,
      profitPerHour: profitPerHour ?? this.profitPerHour,
      level: level ?? this.level,
      progress: progress ?? this.progress,
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
