import 'package:equatable/equatable.dart';

abstract class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String uId;
  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends RegisterState {
  final String message;
  RegisterErrorState(this.message);
}

class RegisterInitialState extends RegisterState {}

class RegisterToggleVisibilityState extends RegisterState {}

class CreateNewUserSuccessState extends RegisterState {}
