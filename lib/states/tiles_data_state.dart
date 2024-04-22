import 'package:equatable/equatable.dart';

abstract class TilesDataStates extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return super.toString();
  }
}

/// Initial state
class TilesInitial extends TilesDataStates {
  TilesInitial();
  @override
  String toString() {
    return super.toString();
  }
}

/// Loading state
class TilesDataLoading extends TilesDataStates {
  TilesDataLoading();
  @override
  String toString() {
    return super.toString();
  }
}

/// Success state
class TilesDataSuccess extends TilesDataStates {
  TilesDataSuccess();
  @override
  String toString() {
    return super.toString();
  }
}

/// Failure state with error message
class TilesDataFailure extends TilesDataStates {
  final String? errorMsg;

  TilesDataFailure({
    this.errorMsg,
  });

  @override
  String toString() {
    return super.toString();
  }
}
