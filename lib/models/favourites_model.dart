class FavouritesModel{
  late bool status;
  late String message;
  FavouritesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }

}