
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_app/config.dart';

import '../events/tiles_data_event.dart';
import '../models/tiles_category_model.dart';
import '../states/tiles_data_state.dart';
import '../utils/connectivity.dart';


class TilesDataBloc extends Bloc<TilesDataEvent, TilesDataStates> {
  List<Category>? categories;
  List<SubCategories> subCategories = [];

  TilesDataBloc() : super(TilesInitial()) {
    on<GetCategories>(getCategories);
    on<GetSubCategories>(getSubCategories);
  }

  /// API for fetch categories
  getCategories(GetCategories event, Emitter<TilesDataStates> emit) async {
    emit(TilesInitial());
    try {
      if (await hasConnectivity()) {
        emit(TilesDataLoading());
        final response = await http.post(
          Uri.parse('${Config.baseUrl}DashBoard'),
          headers: Config.headers,
          body: jsonEncode({
            "CategoryId": 0,
            "PageIndex": 1,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          categories = TilesCategoryModel.fromJson(data).result!.category;
          emit(TilesDataSuccess());
        }
      }
    } catch (exception) {
      print("Error --> ${exception.toString()}");
      emit(TilesDataFailure(errorMsg: exception.toString()));
    }
  }

  /// API for fetch sub categories
  getSubCategories(
      GetSubCategories event, Emitter<TilesDataStates> emit) async {
    try {
      if (await hasConnectivity()) {
        int cId = event.i ?? 0;
        final response = await http.post(
          Uri.parse('${Config.baseUrl}DashBoard'),
          headers: Config.headers,
          body: jsonEncode({
            "CategoryId": cId,
            "PageIndex": event.page,
          }),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          var categories = TilesCategoryModel.fromJson(data).result!.category;
          categories!.forEach((category) {
            subCategories.addAll(category.subCategories ?? []);
          });
          emit(TilesDataLoading());
          emit(TilesDataSuccess());
        }
      }
    } catch (exception) {
      print("Error --> ${exception.toString()}");
      emit(TilesDataFailure(errorMsg: exception.toString()));
    }
  }

}
