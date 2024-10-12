import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/widgets/build_list_product.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavouritesLoadingState,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProducts(
              context: context,
              model: HomeCubit.get(context)
                  .getFavouritesModel!
                  .data
                  .datadata[index]
                  .product,
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount:
                HomeCubit.get(context).getFavouritesModel!.data.datadata.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
