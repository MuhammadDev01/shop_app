import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/cubit/app/app_cubit.dart';
import 'package:shop_app/cubit/login/login_state.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/cubit/login/login_cubit.dart';
import 'package:shop_app/cubit/register/register_cubit.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/pages/boarding_page.dart';
import 'package:shop_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachedHelper.init();
  DioHelper.init();
  Widget currentPage;
  if (CachedHelper.getData(key: kOnBoarding) == null) {
    currentPage = const BoardingPage();
  } else {
    if (CachedHelper.getData(key: kOnLogging) == null) {
      currentPage = LoginPage();
    } else {
      token = CachedHelper.getData(key: kOnLogging);
      currentPage = const HomeLayout();
    }
  }
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ShopApp(
        currentPage: currentPage,
      ), // Wrap your app
    ),
  );
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("$bloc $change");
    super.onChange(bloc, change);
  }
}

class ShopApp extends StatelessWidget {
  final Widget currentPage;

  const ShopApp({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavouritesData()
            ..getProfileData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        )
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: currentPage,
            theme: defaultTheme(context),
            darkTheme: darkTheme(context),
            themeMode: AppCubit.get(context).currentTheme,
          );
        },
      ),
    );
  }
}
