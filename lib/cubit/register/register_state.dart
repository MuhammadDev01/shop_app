import 'package:shop_app/models/auth_model.dart';

abstract class RegisterStates {}

final class RegisterInitialState extends RegisterStates {}

final class RegisterLoadingState extends RegisterStates {}

final class RegisterSuccessState extends RegisterStates {
  final AuthModel? registerModel;

  RegisterSuccessState({this.registerModel});
}

final class RegisterFailureState extends RegisterStates {
  final String errorMassege;

  RegisterFailureState({required this.errorMassege});
}

final class ChangePasswordIconState extends RegisterStates {}

final class RegisterChangeThemeAppState extends RegisterStates {}
