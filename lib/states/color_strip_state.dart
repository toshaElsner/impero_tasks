import 'package:equatable/equatable.dart';

abstract class ColorStripStates extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return super.toString();
  }
}

/// Initial state
class Initial extends ColorStripStates {
  Initial();
  @override
  String toString() {
    return super.toString();
  }
}

/// Loading state
class DataLoading extends ColorStripStates {
  DataLoading();
  @override
  String toString() {
    return super.toString();
  }
}

/// Success state
class DataSuccess extends ColorStripStates {
  DataSuccess();
  @override
  String toString() {
    return super.toString();
  }
}

/// Failure state with error message
class DataFailure extends ColorStripStates {
  final String? errorMsg;

  DataFailure({
    this.errorMsg,
  });

  @override
  String toString() {
    return super.toString();
  }
}
