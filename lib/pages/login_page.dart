import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/cubit/auth/auth_cubit.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/pages/register_page.dart';
import 'package:shop_app/utils/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (!state.authModel!.status) {
            showToast(
              message: state.authModel!.message!,
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
        AuthCubit.get(context).changeTheme();
      },
      icon: Icon(Icons.wb_sunny_outlined),
    );
  }

  //widgets
  ConditionalBuilder _loginButton(AuthStates state) {
    return ConditionalBuilder(
      condition: state is! AuthLoadingState,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: customButton(
          context: context,
          onTap: () {
            if (formKey.currentState!.validate()) {
              AuthCubit.get(context).userLogin(
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
          borderColor: AuthCubit.get(context).currentTheme == ThemeMode.dark
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
              AuthCubit.get(context).userLogin(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
          label: const Text('password'),
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: AuthCubit.get(context).isSecure,
          textInputType: TextInputType.visiblePassword,
          borderColor: AuthCubit.get(context).currentTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
          suffixIcon: IconButton(
            onPressed: () {
              AuthCubit.get(context).changePasswordIcon();
            },
            icon: Icon(
              AuthCubit.get(context).suffixIcon,
            ),
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
      AuthSuccessState state, BuildContext context) async {
    await CachedHelper.saveData(
      key: kOnLogging,
      value: state.authModel!.data!.token,
    ).then((value) {
      if (value && context.mounted) {
        token = state.authModel!.data!.token!;
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
