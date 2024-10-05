import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

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
            builder: (context) => productsBuilder(
              HomeCubit.get(context).homeModel!,
              HomeCubit.get(context).categoriesModel!,
              context,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    HomeModel homeModel,
    CategoriesModel categoriesModel,
    BuildContext context,
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        e.image,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoriesList(
                        categoriesModel.data.dataData[index],
                        context,
                      ),
                      itemCount: categoriesModel.data.dataData.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 1 / 1.4,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          
                          crossAxisCount: 2,
                          children: List.generate(
                            homeModel.data.products.length,
                            (index) => buildGridProduct(
                              homeModel.data.products[index],
                              context,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, BuildContext context) => Container(
color: Colors.white,
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    model.image,
                    height: 250,
                    width: double.infinity,
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: const Text(
                        'DISOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          HomeCubit.get(context).postFavouritesData(
                            productId: model.id,
                          );
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              HomeCubit.get(context).favorites[model.id] == true
                                  ? Colors.red
                                  : defaultColor,
                          radius: 21,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
  );
  Widget buildCategoriesList(DataDataModel model, context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(
            model.image,
            height: 180,
            width: 180,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 180,
            child: Text(
              textAlign: TextAlign.center,
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
}
