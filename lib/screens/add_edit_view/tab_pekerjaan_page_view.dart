import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_edit_provider.dart';

class PekerjaanPageView extends StatefulWidget {
  final String id;
  const PekerjaanPageView({super.key, required this.id});

  @override
  State<PekerjaanPageView> createState() => _PekerjaanPageViewState();
}

class _PekerjaanPageViewState extends State<PekerjaanPageView> {
  int initialYear = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer<AddEditProvider>(builder: (context, provider, child) {
        return widget.id.isNotEmpty
            ? ListView.builder(
                itemCount: provider.listNamaKerja.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          provider.listNamaKerja[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${provider.listTahunKerja[index]} tahun)",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            provider.deleteData(index);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                })
            : ListView.builder(
                itemCount: provider.listPekerjaan.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          provider.listPekerjaan[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => provider.deletePekerjaan(index),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                });
      }),
      bottomNavigationBar:
          Consumer<AddEditProvider>(builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Pekerjaan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: value.namaPekerjaanController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Lama (Tahun)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            controller: value.tahunMasukController
                              ..text = initialYear.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              initialYear--;
                            });
                            initialYear <= 1
                                ? initialYear = 1
                                : initialYear = initialYear;
                          },
                          height: 50,
                          color: Colors.white,
                          child: const Text(
                            '-',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              initialYear++;
                            });
                          },
                          height: 50,
                          color: Colors.white,
                          child: const Text(
                            '+',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          value.submitForm();
                        },
                        height: 50,
                        color: Colors.blue,
                        child: const Text(
                          'Tambah',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                height: 60,
                onPressed: () {
                  value.isAddBio == true
                      ? value.saveBiodata()
                      : value.updateBiodata(widget.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.isAddBio == true
                          ? "Data berhasil disimpan"
                          : "Data berhasil diupdate"),
                    ),
                  );
                  Navigator.pushReplacementNamed(context, '/provider/home');
                },
                color: Colors.blue,
                minWidth: double.infinity,
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
