part of 'auth_cubit.dart';

@immutable
sealed class AuthStates {}

final class AuthInitialState extends AuthStates {}

final class ChangePasswordIconState extends AuthStates {}

final class ChangeThemeAppState extends AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthSuccessState extends AuthStates {
  final AuthModel? authModel;

  AuthSuccessState({this.authModel});
}

final class AuthFailureState extends AuthStates {
  final String errorMassege;

  AuthFailureState({required this.errorMassege});
}
