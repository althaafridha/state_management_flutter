import 'package:flutter/material.dart';
import 'package:latihan_state_management/provider/screens/biodata_page_view.dart';
import 'package:latihan_state_management/provider/screens/pekerjaan_page_view.dart';
import 'package:latihan_state_management/provider/screens/pendidikan_page_view.dart';
import 'package:provider/provider.dart';

import '../providers/add_edit_provider.dart';

class AddEditDataPageView extends StatefulWidget {
  final String? id;

  const AddEditDataPageView(this.id);

  @override
  State<AddEditDataPageView> createState() => _AddEditDataPageViewState();
}

class _AddEditDataPageViewState extends State<AddEditDataPageView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEditProvider(widget.id),
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Form Data"),
            ),
            body: Column(
              children: [
                TabBar(
                  onTap: (value) => setState(() => _currentIndex = value),
                  labelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey[400], fontWeight: FontWeight.w400),
                  tabs: const [
                    Tab(
                      text: "Biodata",
                      height: 60,
                    ),
                    Tab(
                      text: "Pendidikan",
                      height: 60,
                    ),
                    Tab(
                      text: "Pekerjaan",
                      height: 60,
                    ),
                  ],
                ),
                Expanded(
                  child: IndexedStack(index: _currentIndex, children: [
                    const BiodataPageView(),
                    const PendidikanPageView(),
                    PekerjaanPageView(id: widget.id ?? "")
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
