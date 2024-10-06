import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/login_state.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/helper/end_points.dart';
import 'package:shop_app/models/login_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  bool isSecure = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  changePasswordIcon() {
    isSecure = !isSecure;
    suffixIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordIconState());
  }

  ThemeMode currentTheme = ThemeMode.light;
  changeTheme(BuildContext context) {
    currentTheme == ThemeMode.light
        ? currentTheme = ThemeMode.dark
        : currentTheme = ThemeMode.light;
    emit(ChangeThemeAppState());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: lOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      emit(LoginFailureState(errorMassege: error.toString()));
    });
  }
}
