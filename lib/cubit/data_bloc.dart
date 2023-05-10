import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management/cubit/data_state.dart';

import '../repository/biodata_repository.dart';

class DataBloc extends Cubit<DataState> {
  DataBloc() : super(ItemInitial());

  Future<void> deleteData(String id) async {
    emit(ItemDeleting());
    try {
      await BiodataRepository().deleteData(id);
      emit(ItemDeleted());
    } catch (e) {
      emit(ItemFailed("Gagal Hapus Item: $e"));
    }
  }
}
