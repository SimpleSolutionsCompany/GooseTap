part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameStarted extends GameEvent {}

class GameClicked extends GameEvent {}

class GameSyncRequested extends GameEvent {}

class GameEnergyRegen extends GameEvent {}

class BoosterPurchased extends GameEvent {
  final String type;
  const BoosterPurchased(this.type);
}
