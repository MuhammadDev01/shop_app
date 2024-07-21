import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates {}

final class RegisterInitialState extends RegisterStates {}

final class RegisterLoadingState extends RegisterStates {}

final class RegisterSuccessState extends RegisterStates {
  final LoginModel? registerModel;

  RegisterSuccessState({this.registerModel});
}

final class RegisterFailureState extends RegisterStates {
  final String errorMassege;

  RegisterFailureState({required this.errorMassege});
}

final class ChangePasswordIconState extends RegisterStates {}
