import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/pages/widgets/product_page_body.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: (HomeCubit.get(context).homeModel != null) &&
                (HomeCubit.get(context).categoriesModel != null),
            builder: (context) => ProductPageBody(
              categoriesModel: HomeCubit.get(context).categoriesModel!,
              homeModel: HomeCubit.get(context).homeModel!,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
