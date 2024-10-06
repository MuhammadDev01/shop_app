import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/cubit/app/app_cubit.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/cubit/login/login_state.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (!state.loginModel!.status) {
            showToast(
              message: state.loginModel!.message!,
              color: Colors.red,
            );
          } else {
            loginToHomeMethod(state, context);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _logoAndTitleLogin(context),
                      const SizedBox(
                        height: 20,
                      ),
                      _loginFields(context),
                      const SizedBox(
                        height: 20,
                      ),
                      _loginButton(state),
                      const SizedBox(
                        height: 20,
                      ),
                      _goToRegister(context),
                    ],
                  ),
                ),
              ),
              _darkModeCustomButton(context),
            ],
          ),
        );
      },
    );
  }

  IconButton _darkModeCustomButton(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(vertical: 30),
      onPressed: () {
        AppCubit.get(context).changeTheme();
      },
      icon: Icon(Icons.wb_sunny_outlined),
    );
  }

  //widgets
  ConditionalBuilder _loginButton(LoginStates state) {
    return ConditionalBuilder(
      condition: state is! LoginLoadingState,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: customButton(
          onTap: () {
            if (formKey.currentState!.validate()) {
              LoginCubit.get(context).userLogin(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
          textbutton: 'login',
          color: defaultColor,
        ),
      ),
    );
  }

  Widget _loginFields(BuildContext context) {
    return Column(
      children: [
        customTextFormField(
          controller: emailController,
          label: const Text('Email Address'),
          prefixIcon: const Icon(Icons.email_outlined),
          textInputType: TextInputType.emailAddress,
          borderColor: AppCubit.get(context).currentTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        customTextFormField(
          controller: passwordController,
          onSubmitted: (p0) {
            if (formKey.currentState!.validate()) {
              LoginCubit.get(context).userLogin(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
          label: const Text('password'),
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: LoginCubit.get(context).isSecure,
          textInputType: TextInputType.visiblePassword,
          borderColor: AppCubit.get(context).currentTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
          suffixIcon: IconButton(
            onPressed: () {
              LoginCubit.get(context).changePasswordIcon();
            },
            icon: Icon(LoginCubit.get(context).suffixIcon),
          ),
        ),
      ],
    );
  }

  Column _logoAndTitleLogin(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          logoImage,
          scale: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'welcome to shopify'.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Login now to browse out hot offers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _goToRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account ?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          },
          child: Text(
            'REGISTER',
            style: TextStyle(
              decoration: TextDecoration.underline, // Apply underline
            ),
          ),
        ),
      ],
    );
  }

  //methods
  Future<void> loginToHomeMethod(
      LoginSuccessState state, BuildContext context) async {
    await CachedHelper.saveData(
      key: kOnLogging,
      value: state.loginModel!.data!.token,
    ).then((value) {
      if (value && context.mounted) {
        token = state.loginModel!.data!.token!;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeLayout(),
          ),
          (route) => false,
        );
      }
    });
  }
}
