part of 'get_upgrades_bloc.dart';

sealed class GetUpgradesState extends Equatable {
  const GetUpgradesState();

  @override
  List<Object> get props => [];
}

final class GetUpgradesInitial extends GetUpgradesState {}

final class GetUpgradesProgress extends GetUpgradesState {}

final class GetUpgradesFailure extends GetUpgradesState {
  final String errorMessage;

  const GetUpgradesFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class GetUpgradesSuccess extends GetUpgradesState {
  final List<UpgradeModel> upgrades;

  const GetUpgradesSuccess({required this.upgrades});

  @override
  List<Object> get props => [upgrades];
}
