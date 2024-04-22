import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ColorStripEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to Add data
class AddData extends ColorStripEvent {
  AddData();
}

/// Event to change data on user clicks
class ChangeData extends ColorStripEvent {
  final int selectedIndexOfCategory;
  final int selectedIndexOfColor;
  ChangeData(this.selectedIndexOfCategory, this.selectedIndexOfColor);
}
