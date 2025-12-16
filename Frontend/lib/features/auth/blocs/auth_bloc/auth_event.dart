part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginTelegramRequested extends AuthEvent {
  final String initData;

  const AuthLoginTelegramRequested(this.initData);

  @override
  List<Object> get props => [initData];
}
