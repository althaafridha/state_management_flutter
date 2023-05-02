import 'package:flutter/material.dart';
import 'package:latihan_state_management/provider/widgets/list_item_home.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import 'add_edit_data_page_view.dart';

class HomeProviderPageView extends StatelessWidget {
  const HomeProviderPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Provider'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )),
          body: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.dataList.isEmpty
                      ? const Center(child: Text('Data Kosong'))
                      : const ListItemHome();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditDataPageView(null))),
            child: const Icon(Icons.add),
          )),
    );
  }
}
