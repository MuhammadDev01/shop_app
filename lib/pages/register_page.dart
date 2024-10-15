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
import 'package:shop_app/utils/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.authModel!.status) {
            _registerToHome(state, context);
          } else {
            showToast(
              message: state.authModel!.message!,
              color: Colors.red,
            );
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
                  child: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _registerTitleAndLogo(context),
                        const SizedBox(
                          height: 20,
                        ),
                        _registerFields(context),
                        const SizedBox(
                          height: 20,
                        ),
                        _registerButton(state),
                      ],
                    ),
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

//widgets
  ConditionalBuilder _registerButton(AuthStates state) {
    return ConditionalBuilder(
      condition: state is! AuthLoadingState,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: customButton(
          context: context,
          onTap: () {
            if (formKey.currentState!.validate()) {
              AuthCubit.get(context).userRegister(
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

  Widget _registerFields(BuildContext context) {
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
        const SizedBox(
          height: 10,
        ),
        customTextFormField(
          controller: nameController,
          label: const Text('Name'),
          prefixIcon: const Icon(Icons.person),
          textInputType: TextInputType.name,
          borderColor: AuthCubit.get(context).currentTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        customTextFormField(
          controller: phoneController,
          label: const Text('Phone'),
          prefixIcon: const Icon(Icons.phone),
          borderColor: AuthCubit.get(context).currentTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
          textInputType: TextInputType.phone,
          onSubmitted: (value) {
            if (formKey.currentState!.validate()) {
              AuthCubit.get(context).userRegister(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
                phone: phoneController.text,
              );
            }
          },
        ),
      ],
    );
  }

  Column _registerTitleAndLogo(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          logoImage,
          scale: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'shopify register'.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Register now to browse out hot offers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  //functions
  void _registerToHome(AuthSuccessState state, BuildContext context) async {
    await CachedHelper.saveData(
            key: kOnLogging, value: state.authModel!.data!.token)
        .then((value) {
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
