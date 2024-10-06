import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/cubit/register/register_cubit.dart';
import 'package:shop_app/cubit/register/register_state.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/layout/home_layout.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel!.status) {
            registerToHomeMethod(state);
          } else {
            showToast(
              message: state.registerModel!.message!,
              color: Colors.red,
            );
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
                        'REGISTER',
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
                        'Register now to browse out hot offers',
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
                        borderColor: LoginCubit.get(context).currentTheme ==
                                ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customTextFormField(
                        controller: passwordController,
                        label: const Text('password'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: LoginCubit.get(context).isSecure,
                        textInputType: TextInputType.visiblePassword,
                        borderColor: LoginCubit.get(context).currentTheme ==
                                ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).changePasswordIcon();
                          },
                          icon: Icon(LoginCubit.get(context).suffixIcon),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customTextFormField(
                        controller: nameController,
                        label: const Text('Name'),
                        prefixIcon: const Icon(Icons.person),
                        textInputType: TextInputType.name,
                        borderColor: LoginCubit.get(context).currentTheme ==
                                ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customTextFormField(
                        controller: phoneController,
                        label: const Text('Phone'),
                        prefixIcon: const Icon(Icons.phone),
                        borderColor: LoginCubit.get(context).currentTheme ==
                                ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        textInputType: TextInputType.phone,
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => customButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          textbutton: 'register',
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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

  void registerToHomeMethod(RegisterSuccessState state) async {
    await CachedHelper.saveData(
        key: kOnLogging, value: state.registerModel!.data!.token);

    token = state.registerModel!.data!.token!;

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeLayout(),
        ),
        (route) => false,
      );
    }
  }
}
