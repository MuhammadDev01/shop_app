import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/pages/widgets/build_categories_list.dart';
import 'package:shop_app/pages/widgets/build_grid_product.dart';

class ProductPageBody extends StatelessWidget {
  const ProductPageBody(
      {super.key, required this.homeModel, required this.categoriesModel});
  final HomeModel homeModel;
  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                _categoriesList(categoriesModel, context),
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
  }

  SingleChildScrollView _categoriesList(
      CategoriesModel categoriesModel, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoriesModel.data.dataData
            .map((model) => buildCategoriesList(model, context))
            .toList(),
      ),
    );
  }
}
