import 'package:shop_app/models/home_model.dart';

class GetFavouritesModel {
  late bool status;
  late DataModel data;
  GetFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<Datum> datadata = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      datadata.add(Datum.fromJson(element));
    });
  }
}

class Datum {
  late int id;
  late ProductModel product;
  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}
