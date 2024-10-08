import 'package:shop_app/models/auth_model.dart';

abstract class LoginStates {}

final class LoginInitialState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {
  final AuthModel? loginModel;

  LoginSuccessState({this.loginModel});
}

final class LoginFailureState extends LoginStates {
  final String errorMassege;

  LoginFailureState({required this.errorMassege});
}

final class ChangePasswordIconState extends LoginStates {}
final class ChangeThemeAppState extends LoginStates {}
