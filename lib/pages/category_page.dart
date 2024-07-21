import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategoryItem(
              context,
              HomeCubit.get(context).categoriesModel!.data.dataData[index],
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount:
                HomeCubit.get(context).categoriesModel!.data.dataData.length,
          ),
        );
      },
    );
  }

  Widget buildCategoryItem(context,DataDataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image.network(
              model.image,
              height: 140,
              width: 140,
            ),
            const SizedBox(
              width: 30,
            ),
             Text(
              model.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 36,
              ),
            ),
          ],
        ),
      );
}
