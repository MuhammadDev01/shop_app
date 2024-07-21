import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/components/theme.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/cubit/login/login_state.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
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
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login now to browse out hot offers',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      customTextFormField(
                        controller: emailController,
                        label: const Text('Email Address'),
                        prefixIcon: const Icon(Icons.email_outlined),
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
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
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).changePasswordIcon();
                          },
                          icon: Icon(LoginCubit.get(context).suffixIcon),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => customButton(
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text('REGISTER'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void loginToHomeMethod(LoginSuccessState state, BuildContext context) {
    showToast(
      message: state.loginModel!.message!,
      color: Colors.green,
    ).then((value) {
      CachedHelper.saveData(
              key: kOnLogging, value: state.loginModel!.data!.token)
          .then((value) {
        if (value) {
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
    });
  }
}
