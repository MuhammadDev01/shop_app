part of 'search_cubit.dart';

@immutable
sealed class SearchStates {}

final class SearchInitialState extends SearchStates {}

final class SearchLoadingState extends SearchStates {}

final class SearchSuccessState extends SearchStates {
  final SearchModel? searchModel;

  SearchSuccessState({this.searchModel});
}

final class SearchFailureState extends SearchStates {}
