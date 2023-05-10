import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/biodata_model.dart';

class BiodataRepository {
  Future<List<BiodataModel>> getDataList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('tes').get();
    List<BiodataModel> dataList = snapshot.docs.map((doc) {
      List<String> listPekerjaan = [];
      List<dynamic> namaPekerjaanList = doc.get('nama_pekerjaan');
      for (var pekerjaan in namaPekerjaanList) {
        listPekerjaan.add(pekerjaan.toString());
      }
      BiodataModel biodata = BiodataModel.fromFirestore(doc);
      biodata.listPekerjaan = listPekerjaan;
      return biodata;
    }).toList();
    return dataList;
  }

  Future<void> deleteData(String id) async {
    await FirebaseFirestore.instance.collection('tes').doc(id).delete();
  }
}
