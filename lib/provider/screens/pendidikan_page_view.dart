import 'package:flutter/material.dart';
import 'package:latihan_state_management/provider/providers/add_edit_provider.dart';
import 'package:provider/provider.dart';

class PendidikanPageView extends StatefulWidget {
  const PendidikanPageView({Key? key}) : super(key: key);

  @override
  State<PendidikanPageView> createState() => _PendidikanPageViewState();
}

class _PendidikanPageViewState extends State<PendidikanPageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddEditProvider>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pendidikan Terakhir",
                  style: TextStyle(fontSize: 16, color: Colors.black,),
                ),
                const SizedBox(height: 5),
                FutureBuilder<List<String>>(
                  future: value.getPendidikanList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('Terjadi kesalahan'));
                    } else {
                      return DropdownButtonFormField<String>(
                        value: value.pendidikanController,
                        items: snapshot.data?.map((pendidikan) {
                          return DropdownMenuItem<String>(
                            value: pendidikan,
                            child: Text(pendidikan),
                          );
                        }).toList(),
                        onChanged: value.valueList,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
