import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppCubitInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode currentTheme = ThemeMode.light;
  changeTheme() {
    currentTheme == ThemeMode.light
        ? currentTheme = ThemeMode.dark
        : currentTheme = ThemeMode.light;
    emit(ChangeThemeAppState());
  }
}
