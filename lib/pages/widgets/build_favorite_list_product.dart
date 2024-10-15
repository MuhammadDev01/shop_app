import 'package:flutter/material.dart';
import 'package:shop_app/utils/app_theme.dart';
import 'package:shop_app/cubit/home/home_cubit.dart';
import 'package:shop_app/models/home_model.dart';

Widget buildFavoritesListProducts({
  required ProductModel model,
  required BuildContext context,
  required int index,
  bool oldPrice = true,
}) {
  return Padding(
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
              if (model.discount != 0 && oldPrice)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: const Text(
                    'DISOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: defaultColor,
                          ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (model.discount != 0 && oldPrice)
                      Text(
                        '${model.oldPrice}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        HomeCubit.get(context).deleteProductFromFavorites(
                          productId: model.id,
                          index: index,
                        );
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.red,
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
    ),
  );
}
