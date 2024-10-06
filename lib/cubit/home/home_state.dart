part of 'home_cubit.dart';

@immutable
sealed class HomeStates {}

final class HomeInitialState extends HomeStates {}

final class HomeLoadingState extends HomeStates {}

final class HomeSuccessState extends HomeStates {}

final class HomeFailureState extends HomeStates {}

final class HomeChangeNavBarState extends HomeStates {}

final class CategoriesSuccessState extends HomeStates {}

final class CategoriesFailureState extends HomeStates {}

final class FavouritesSuccessState extends HomeStates {
  final FavouritesModel? favouritesModel;

  FavouritesSuccessState({this.favouritesModel});
}

final class FavouritesFailureState extends HomeStates {
  final String error;

  FavouritesFailureState({required this.error});
}

final class FavouritesChangeState extends HomeStates {}

final class GetFavouritesLoadingState extends HomeStates {}

final class GetFavouritesSuccessState extends HomeStates {}

final class GetFavouritesFailureState extends HomeStates {}

final class GetProfileLoadingState extends HomeStates {}

final class GetProfileSuccessState extends HomeStates {
  final AuthModel userModel;

  GetProfileSuccessState({required this.userModel});
}

final class GetProfileFailureState extends HomeStates {}

final class UpdateProfileLoadingState extends HomeStates {}

final class UpdateProfileSuccessState extends HomeStates {
  final AuthModel updateUserModel;

  UpdateProfileSuccessState({required this.updateUserModel});
}

final class UpdateProfileFailureState extends HomeStates {}
