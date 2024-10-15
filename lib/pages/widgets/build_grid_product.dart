import 'package:flutter/material.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/utils/app_theme.dart';

Widget buildGridProduct(ProductModel model, BuildContext context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // لتنسيق النص في جهة اليسار
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  model.image,
                  width: double.infinity,
                  //  fit: BoxFit.cover, // يجعل الصورة تتكيف مع حجم المساحة
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // لضبط النص في اليسار
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8), // لإضافة مسافة صغيرة بين النص والسعر
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                    SizedBox(width: 8),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        HomeCubit.get(context).changeFavoriteProduct(
                          productId: model.id,
                        );
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            HomeCubit.get(context).favoritesMap[model.id] ==
                                    true
                                ? Colors.red
                                : defaultColor,
                        radius: 14,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 16,
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
