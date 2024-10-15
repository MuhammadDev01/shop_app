import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/cubit/auth/auth_cubit.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/models/auth_model.dart';
import 'package:shop_app/pages/login_page.dart';
import 'package:shop_app/utils/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) async {
        if (state is UpdateProfileSuccessState) {
          await showToast(
            message: 'Success',
            color: Colors.teal,
          );
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          fallback: (_) => const Center(
            child: CircularProgressIndicator(
               color: defaultColor,
            ),
          ),
          condition: HomeCubit.get(context).userModel != null,
          builder: (context) {
            Data model = HomeCubit.get(context).userModel!.data!;
            nameController.text = model.name!;
            emailController.text = model.email!;
            phoneController.text = model.phone!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is UpdateProfileLoadingState)
                      const LinearProgressIndicator(
                        color: defaultColor,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(
                      prefixIcon: const Icon(Icons.person),
                      borderColor:
                          AuthCubit.get(context).currentTheme == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                      textInputType: TextInputType.name,
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextFormField(
                      prefixIcon: const Icon(Icons.email),
                      borderColor:
                          AuthCubit.get(context).currentTheme == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextFormField(
                      prefixIcon: const Icon(Icons.phone),
                      borderColor:
                          AuthCubit.get(context).currentTheme == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                      textInputType: TextInputType.phone,
                      hintText: 'Phone',
                      controller: phoneController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customButton(
                      context: context,
                      onTap: () {
                        HomeCubit.get(context).updateUserProfile(
                          email: emailController.text,
                          name: nameController.text,
                          phone: phoneController.text,
                        );
                      },
                      textbutton: 'UPDATE',
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customButton(
                      context: context,
                      onTap: () async {
                        await CachedHelper.removeData(key: kOnLogging);

                        goToSignIn();
                      },
                      textbutton: 'LOGOUT',
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void goToSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
      (route) => false,
    );
  }
}
