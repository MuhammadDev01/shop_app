import 'package:flutter/material.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/utils/app_theme.dart';

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
