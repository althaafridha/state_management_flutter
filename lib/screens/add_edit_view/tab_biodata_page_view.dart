import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_edit_provider.dart';

class BiodataPageView extends StatefulWidget {
  const BiodataPageView({super.key});

  @override
  State<BiodataPageView> createState() => _BiodataPageViewState();
}

class _BiodataPageViewState extends State<BiodataPageView> {

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AddEditProvider>(
        builder: (context, provider, child) {
          return Form(
            key: _key,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama", style: TextStyle(fontSize: 16, color: Colors.black,),),
                    const SizedBox(height: 5),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: provider.namaController,
                      // onChanged: (value) => context.read<AddEditProvider>().setNama(value),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("No Hp", style: TextStyle(fontSize: 16, color: Colors.black,),),
                    const SizedBox(height: 5),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: provider.nomorHpController,
                      // onChanged: (value) => context.read<AddEditProvider>().setNomorHp(value),
                      maxLength: 12,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text("Alamat", style: TextStyle(fontSize: 16, color: Colors.black,)),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: provider.alamatController,
                      // onChanged: (value) => context.read<AddEditProvider>().setAlamat(value),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
