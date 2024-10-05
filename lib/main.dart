import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
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
  Widget widget;
  if (CachedHelper.getData(key: kOnBoarding) == null) {
    widget = const BoardingPage();
  } else {
    if (CachedHelper.getData(key: kOnLogging) == null) {
      widget = const LoginPage();
    } else {
      token = CachedHelper.getData(key: kOnLogging);
      widget = const HomeLayout();
    }
  }
  runApp(ShopApp(
    currentPage: widget,
  ));
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: currentPage,
        theme: defaultTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
