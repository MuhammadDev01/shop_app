import 'package:flutter/material.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';

Widget buildListProducts(
        {required ProductModel model, required BuildContext context,bool oldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  model.image,
                  width: 150,
                ),
                if (model.discount != 0&&oldPrice)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
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
                  const Spacer(),
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
                      if (model.discount != 0&&oldPrice)
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
      ),
    );
