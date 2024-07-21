import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/pages/search_page.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is FavouritesSuccessState) {
          if (!state.favouritesModel!.status) {
            showToast(
              message: state.favouritesModel!.message,
              color: Colors.red,
            );
          }
        }
        if (state is FavouritesFailureState) {
          showToast(
            message: state.error,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
          body:
              HomeCubit.get(context).pages[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: HomeCubit.get(context).currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              HomeCubit.get(context).changeNavBarIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
