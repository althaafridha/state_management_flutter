import 'package:cloud_firestore/cloud_firestore.dart';

class BiodataModel {
  String id;
  String nama;
  String nomorHp;
  String alamat;
  String pendidikan;
  List<String> listPekerjaan;
  List<dynamic> listNamaKerja;
  List<dynamic> listTahunKerja;

  BiodataModel({
    required this.id,
    required this.nama,
    required this.nomorHp,
    required this.alamat,
    required this.pendidikan,
    required this.listPekerjaan,
    required this.listNamaKerja,
    required this.listTahunKerja,
  });

  factory BiodataModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BiodataModel(
      id: doc.id,
      nama: data['nama'],
      nomorHp: data['nomor_hp'],
      alamat: data['alamat'],
      pendidikan: data['pendidikan'],
      listPekerjaan: [],
      listNamaKerja: [],
      listTahunKerja: [],
    );
  }
}
