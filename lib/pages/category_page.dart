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
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8),
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
        );
      },
    );
  }

  Widget buildCategoryItem(context, DataDataModel model) => InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              model.image,
              height: 150,
              width: 150,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                model.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 24,
            ),
          ],
        ),
      );
}
