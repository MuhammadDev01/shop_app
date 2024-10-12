import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/helper/end_points.dart';
import 'package:shop_app/models/auth_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

//*change icon show password
  bool isSecure = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  changePasswordIcon() {
    isSecure = !isSecure;
    suffixIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordIconState());
  }

//*change theme app
  ThemeMode currentTheme = ThemeMode.light;
  changeTheme() {
    currentTheme == ThemeMode.light
        ? currentTheme = ThemeMode.dark
        : currentTheme = ThemeMode.light;
    emit(ChangeThemeAppState());
  }

  //*login
  AuthModel? loginModel;

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    DioHelper.postData(
      url: lOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = AuthModel.fromJson(value.data);
      emit(AuthSuccessState(authModel: loginModel));
    }).catchError((error) {
      emit(AuthFailureState(errorMassege: error.toString()));
    });
  }

  //*register
  AuthModel? registerModel;

  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoadingState());
    try {
      final response = await DioHelper.postData(
        url: rEGISTER,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        },
      );
      registerModel = AuthModel.fromJson(response.data);
      emit(AuthSuccessState(authModel: registerModel));
    } catch (error) {
      debugPrint(error.toString());
      emit(AuthFailureState(errorMassege: error.toString()));
    }
  }
}
