part of 'app_cubit.dart';

@immutable
sealed class AppStates {}

final class AppCubitInitial extends AppStates {}
final class ChangeThemeAppState extends AppStates {}
