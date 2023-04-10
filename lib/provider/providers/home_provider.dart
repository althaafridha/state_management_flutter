import 'package:flutter/material.dart';
import 'package:latihan_state_management/models/biodata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider extends ChangeNotifier {
  List<BiodataModel> _dataList = [];
  List<BiodataModel> get dataList => _dataList;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  HomeProvider() {
    _showLoading();
    getDataList();
  }

  void getDataList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('tes').get();
    _dataList = snapshot.docs.map((doc) {
      List<String> listPekerjaan = []; // tambahan kode
      List<dynamic> namaPekerjaanList =
          doc.get('nama_pekerjaan'); // tambahan kode
      for (var pekerjaan in namaPekerjaanList) {
        // tambahan kode
        listPekerjaan.add(pekerjaan.toString()); // tambahan kode
      } // tambahan kode
      BiodataModel biodata = BiodataModel.fromFirestore(doc);
      biodata.listPekerjaan = listPekerjaan; // tambahan kode
      return biodata;
    }).toList();

    _isLoading = false;
    notifyListeners();
  }

  void _showLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    _isLoading = false;
    notifyListeners();
  }

  showAlertDialog(BuildContext context, id) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        deleteData(id);
        notifyListeners();
        _isLoading = true;
        _showLoading();
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Data"),
      content: const Text("Are you sure want to delete this data?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteData(String id) async {
    await FirebaseFirestore.instance.collection('tes').doc(id).delete();
    notifyListeners();
    _showLoading();
    getDataList();
  }
}
