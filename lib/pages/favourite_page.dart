import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/show_toast.dart';
import 'package:shop_app/pages/widgets/build_favorite_list_product.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetFavouritesFailureState) {
          showToast(message: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (state is FavouritesChangeState)
              LinearProgressIndicator(color: Colors.cyan),
            HomeCubit.get(context).getFavouritesModel!.data.datadata.isEmpty
                ? _emptyFavoriteProducts(context)
                : _favouriteProductsListView(context),
          ],
        );
      },
    );
  }

  Center _emptyFavoriteProducts(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no favourite.png',
            scale: MediaQuery.sizeOf(context).width / 400,
          ),
          Text(
            'No favorites yet',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            "keep track of the job listings you're\n interested in by clicking the ♥️ icon",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _favouriteProductsListView(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildFavoritesListProducts(
          index: index,
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
    );
  }
}
