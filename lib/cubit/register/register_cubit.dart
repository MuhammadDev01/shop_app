import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app/app_cubit.dart';
import 'package:shop_app/cubit/register/register_state.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/helper/end_points.dart';
import 'package:shop_app/models/auth_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  AuthModel? registerModel;
  bool isSecure = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  changePasswordIcon() {
    isSecure = !isSecure;
    suffixIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordIconState());
  }

  changeTheme(BuildContext context) {
    AppCubit.get(context).currentTheme == ThemeMode.light
        ? AppCubit.get(context).currentTheme = ThemeMode.dark
        : AppCubit.get(context).currentTheme = ThemeMode.light;
    emit(RegisterChangeThemeAppState());
  }

  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
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
      emit(RegisterSuccessState(registerModel: registerModel));
    } catch (error) {
      debugPrint(error.toString());
      emit(RegisterFailureState(errorMassege: error.toString()));
    }
  }
}
