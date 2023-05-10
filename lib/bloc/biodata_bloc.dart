import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management/bloc/biodata_event.dart';
import 'package:latihan_state_management/bloc/biodata_state.dart';
import 'package:latihan_state_management/models/biodata_model.dart';
import 'package:latihan_state_management/repository/biodata_repository.dart';

class BiodataBloc extends Bloc<BiodataEvent, BiodataState> {
  final BiodataRepository repository = BiodataRepository();

  BiodataBloc() : super(BiodataInitialState()) {
    on<GetBiodata>((event, emit) async {
      await _getBiodata(emit);
    });
  }

  Future<void> _getBiodata(Emitter<BiodataState> emit) async {
    emit(BiodataLoadingState());
    try {
      List<BiodataModel> dataList = await repository.getDataList();
      if (dataList.isEmpty) {
        emit(BiodataEmpty());
      } else {
        emit(BiodataSuccessState(dataList));
      }
    } catch (e) {
      emit(BiodataErrorState(e.toString()));
    }
  }
}
