import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../events/color_strip_event.dart';
import '../models/color_categories.dart';
import '../states/color_strip_state.dart';

class ColorStripBloc extends Bloc<ColorStripEvent, ColorStripStates> {
  List<ColorCategories> categories = [];

  ColorStripBloc() : super(Initial()) {
    on<AddData>(addDataToModel);
    on<ChangeData>(changeValueToModel);
  }

  /// Adding static data to model
  addDataToModel(AddData event, Emitter<ColorStripStates> emit) {
    try {
      emit(DataLoading());
      categories.add(ColorCategories(
          "Total Hardness (ppm)",
          [
            {Colors.purple[50]!: 12},
            {Colors.purple[100]!: 33},
            {Colors.purple[200]!: 134},
            {Colors.purple[300]!: 511},
            {Colors.purple[400]!: 002}
          ],
          3));
      categories.add(ColorCategories(
          "Total Chlorine (ppm)",
          [
            {Colors.yellow[50]!: 32},
            {Colors.yellow[100]!: 44},
            {Colors.yellow[200]!: 323},
            {Colors.yellow[300]!: 320},
            {Colors.yellow[400]!: 33}
          ],
          2));
      categories.add(ColorCategories(
          "Free Chlorine (ppm)",
          [
            {Colors.blue[50]!: 9},
            {Colors.blue[100]!: 2},
            {Colors.blue[200]!: 523},
            {Colors.blue[300]!: 23},
            {Colors.blue[400]!: 5}
          ],
          0));
      categories.add(ColorCategories(
          "pH (ppm)",
          [
            {Colors.red[50]!: 43},
            {Colors.red[100]!: 02},
            {Colors.red[200]!: 54},
            {Colors.red[300]!: 767},
            {Colors.red[400]!: 4563}
          ],
          3));
      categories.add(ColorCategories(
          "Total Alkalinity (ppm)",
          [
            {Colors.green[50]!: 5},
            {Colors.green[100]!: 56},
            {Colors.green[200]!: 43},
            {Colors.green[300]!: 45436},
            {Colors.green[400]!: 645}
          ],
          2));
      categories.add(ColorCategories(
          "Cyanuric Acid(ppm)",
          [
            {Colors.cyan[50]!: 345},
            {Colors.cyan[100]!: 3},
            {Colors.cyan[200]!: 75},
            {Colors.cyan[300]!: 34},
            {Colors.cyan[400]!: 676}
          ],
          0));
      emit(DataSuccess());
      print("Data Success");
    } on Exception catch (e) {
      emit(DataFailure(errorMsg: e.toString()));
      print("Data exception");
    }
  }

  changeValueToModel(ChangeData event, Emitter<ColorStripStates> emit){
    emit(DataLoading());
    categories[event.selectedIndexOfCategory].selectedColorIndex = event.selectedIndexOfColor;
    emit(DataSuccess());
  }
}
