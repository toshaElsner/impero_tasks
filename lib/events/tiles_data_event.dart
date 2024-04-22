import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TilesDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to get categories
class GetCategories extends TilesDataEvent {
  final BuildContext context;

  GetCategories(this.context);
}

/// Event to get sub categories
class GetSubCategories extends TilesDataEvent {
  final BuildContext context;
  final int? i;
  final int? page;

  GetSubCategories(this.context, this.page, [this.i]);
}

/// Event to get products
class GetProducts extends TilesDataEvent {
  final int? i;
  final int? page;

  GetProducts(this.page, [this.i]);
}
