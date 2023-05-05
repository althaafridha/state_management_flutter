import 'package:flutter/material.dart';
import 'package:latihan_state_management/models/biodata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider extends ChangeNotifier {
  List<BiodataModel> _dataList = [];
  List<BiodataModel> get dataList => _dataList;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  HomeProvider() {
    getDataList();
  }

  void getDataList() async {
    _isLoading = true;
    notifyListeners();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('tes').get();
    _dataList = snapshot.docs.map((doc) {
      List<String> listPekerjaan = []; 
      List<dynamic> namaPekerjaanList =
          doc.get('nama_pekerjaan'); 
      for (var pekerjaan in namaPekerjaanList) {
        listPekerjaan.add(pekerjaan.toString()); 
      } 
      BiodataModel biodata = BiodataModel.fromFirestore(doc);
      biodata.listPekerjaan = listPekerjaan; 
      return biodata;
    }).toList();

    _isLoading = false;
    notifyListeners();
  }
}
