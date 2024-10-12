import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';

Widget buildCategoriesList(DataDataModel model, context) => Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(
            model.image,
            height: 180,
            width: 180,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black.withOpacity(0.8),
            ),
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
      ),
    );
