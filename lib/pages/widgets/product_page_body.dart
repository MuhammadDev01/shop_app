import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/pages/widgets/build_categories_list.dart';
import 'package:shop_app/pages/widgets/build_grid_product.dart';

class ProductPageBody extends StatelessWidget {
  const ProductPageBody({
    super.key,
    required this.homeModel,
    required this.categoriesModel,
  });
  final HomeModel homeModel;
  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: const SizedBox(
            height: 10.0,
          ),
        ),
        SliverToBoxAdapter(child: _productsSlider()),
        SliverPadding(
          padding: const EdgeInsets.all(10.0), // Adjust padding as needed
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                _categoriesList(categoriesModel, context),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'New Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: Container(
            color: Colors.grey.shade100,
            child: _productsGridView(context),
          ),
        ),
      ],
    );
  }

  Widget _productsGridView(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, index) => buildGridProduct(
        homeModel.data.products[index],
        context,
      ),
      itemCount: homeModel.data.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        mainAxisSpacing: 2, // المسافة بين العناصر عمودياً
        crossAxisSpacing: 2, // المسافة بين الأعمدة أفقياً
      ),
    );
  }

  CarouselSlider _productsSlider() {
    return CarouselSlider(
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
