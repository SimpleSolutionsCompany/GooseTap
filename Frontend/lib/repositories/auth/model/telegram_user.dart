import 'package:equatable/equatable.dart';
import "dart:js_interop" as js;

class TelegramUser extends Equatable {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;

  const TelegramUser({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
  });

  TelegramUser? getTelegramUserData() {
    // final teleram = js.conte
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
