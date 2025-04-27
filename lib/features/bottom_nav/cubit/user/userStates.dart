
import '../../../../core/models/user.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class Changeindex extends UsersState {}

class UsersSuccess extends UsersState {
  final List<UserModel> users;
  UsersSuccess(this.users);
}

class UsersFailure extends UsersState {
  final String error;
  UsersFailure(this.error);
}
