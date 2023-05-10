import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management/bloc/biodata_bloc.dart';
import 'package:latihan_state_management/bloc/biodata_event.dart';
import 'package:latihan_state_management/bloc/biodata_state.dart';
import 'package:latihan_state_management/cubit/data_bloc.dart';
import 'package:latihan_state_management/cubit/data_state.dart';
import 'package:latihan_state_management/models/biodata_model.dart';
import 'package:latihan_state_management/widgets/alert_dialog.dart';

import '../screens/add_edit_view/add_edit_data_page_view.dart';

class ListItemHome extends StatelessWidget {
  const ListItemHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BiodataBloc, BiodataState>(
      builder: (context, state) {
        if (state is BiodataSuccessState) {
          return ListView.builder(
            itemCount: state.dataList.length,
            itemBuilder: (context, index) {
              BiodataModel data = state.dataList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditDataPageView(data.id),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data.nomorHp,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data.alamat,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Pendidikan Terakhir : ${data.pendidikan}",
                              maxLines: 1,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Pekerjaan : ${data.listPekerjaan.join(", ")}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      BlocConsumer<BiodataBloc, BiodataState>(
                        listener: (context, state) {
                          if (state is ItemDeleted) {
                            context.read<BiodataBloc>().add(GetBiodata());
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              showAlertDialog(context, data.id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Data tidak ditemukan'));
        }
      },
    );
  }
}

