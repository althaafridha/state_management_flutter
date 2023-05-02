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

  void refresh(){
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
    _dataList.isNotEmpty ? _isLoading = false : _isLoading = true;
    notifyListeners();
  }
}
