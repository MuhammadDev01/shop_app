import 'package:shop_app/models/home_model.dart';

class SearchModel {
  late bool status;
  late DataModel data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int currnetPage;
  List<ProductModel> dataData = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    currnetPage = json['current_page'];
    json['data'].forEach((element) {
      dataData.add(ProductModel.fromJson(element));
    });
  }
}
