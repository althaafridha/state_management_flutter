import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management/bloc/biodata_bloc.dart';
import 'package:latihan_state_management/bloc/biodata_event.dart';
import 'package:latihan_state_management/widgets/list_item_home.dart';

import '../../bloc/biodata_state.dart';
import '../add_edit_view/add_edit_data_page_view.dart';

class HomeProviderPageView extends StatelessWidget {
  const HomeProviderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BiodataBloc(),
      child: Scaffold(
        body: BlocBuilder<BiodataBloc, BiodataState>(
          builder: (context, state) {
            final bloc = context.read<BiodataBloc>();
            if (state is BiodataInitialState) {
              bloc.add(GetBiodata());
              return const Center(child: CircularProgressIndicator());
              // return const ListItemHome();
            } else if (state is BiodataLoadingState){
              return const Center(child: CircularProgressIndicator());
            } else if (state is BiodataSuccessState) {
              return const ListItemHome();
            } else {
              return const Center(child: Text('Data tidak ditemukan'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditDataPageView(null),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
