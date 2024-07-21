class CategoriesModel {
  late bool status;
  late DataModel data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int currnetPage;
  List<DataDataModel> dataData = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    currnetPage = json['current_page'];
    json['data'].forEach((element) {
      dataData.add(DataDataModel.fromJson(element));
    });
  }
}

class DataDataModel {
  late int id;
  late String name;
  late String image;

  DataDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
