import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/helper/end_points.dart';
import 'package:shop_app/models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  Future<void> searchProduct({
    required String text,
  }) async {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: sEARCHPRODUCT,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState(searchModel: searchModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SearchFailureState());
    });
  }
}
