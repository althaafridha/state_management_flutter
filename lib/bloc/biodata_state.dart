import '../models/biodata_model.dart';

abstract class BiodataState {}

class BiodataInitialState extends BiodataState {}

class BiodataLoadingState extends BiodataState {}

class BiodataSuccessState extends BiodataState {
  final List<BiodataModel> dataList;

  BiodataSuccessState(this.dataList);
}

class BiodataErrorState extends BiodataState {
  final String message;

  BiodataErrorState(this.message);
}

class BiodataEmpty extends BiodataState {}
