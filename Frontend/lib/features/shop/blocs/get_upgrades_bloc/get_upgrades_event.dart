part of 'get_upgrades_bloc.dart';

sealed class GetUpgradesEvent extends Equatable {
  const GetUpgradesEvent();

  @override
  List<Object> get props => [];
}

class OnGetUpgradesEvent extends GetUpgradesEvent {}
