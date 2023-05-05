import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/biodata_model.dart';

class AddEditProvider extends ChangeNotifier {
  bool isAddBio = true;

  AddEditProvider(id) {
    if (id != null) {
      isAddBio = false;
      notifyListeners();
      getDataById(id!);
      namaController.text = dataModel.nama;
      nomorHpController.text = dataModel.nomorHp;
      alamatController.text = dataModel.alamat;
      listPekerjaan = dataModel.listPekerjaan;
      listNamaKerja = listNamaKerja;
      listTahunKerja = listNamaKerja;
    } else {
      isAddBio = true;
      notifyListeners();
      namaController.text = '';
      nomorHpController.text = '';
      alamatController.text = '';
      listPekerjaan = [];
    }
    getPendidikanList();
  }

  BiodataModel? data;
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController namaPekerjaanController = TextEditingController();
  TextEditingController tahunMasukController = TextEditingController();
  String? pendidikanController;

  final List<BiodataModel> _dataList = [];
  BiodataModel dataModel = BiodataModel(
    id: '',
    nama: '',
    nomorHp: '',
    alamat: '',
    pendidikan: '',
    listPekerjaan: [],
    listNamaKerja: [],
    listTahunKerja: [],
  );
  List<String> listPekerjaan = [];
  List<dynamic> listNamaKerja = [];
  List<dynamic> listTahunKerja = [];

  Future<void> savePekerjaan(int index) async {
    final namaPekerjaan = namaPekerjaanController.text;
    final tahunMasuk = tahunMasukController.text;

    // update data to firestore
    final docRef =
        FirebaseFirestore.instance.collection('tes').doc(_dataList[index].id);
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data() ?? {};

    final List<dynamic> listPekerjaan = data['list_pekerjaan'] ?? [];
    listPekerjaan.add({
      'nama_pekerjaan': namaPekerjaan,
      'tahun': tahunMasuk,
    });

    await docRef.update({'list_pekerjaan': listPekerjaan});

    notifyListeners();
  }

  void deleteData(int index) async {
    final firestoreInstance = FirebaseFirestore.instance;

    listNamaKerja.removeAt(index);
    listTahunKerja.removeAt(index);
    listPekerjaan.removeAt(index);

    if (index >= 0 && index < listPekerjaan.length) {
      final id = _dataList[index].id;

      try {
        await firestoreInstance.collection('tes').doc(id).update({
          'nama_perjaan': FieldValue.arrayRemove([namaPekerjaanController]),
          'tahun_kerja': FieldValue.arrayRemove([tahunMasukController])
        });
      notifyListeners();
      } catch (e) {
        print('Error deleting data: $e');
      }
    } else {
      print('Invalid index: $index');
    }
  }

  Future<void> saveBiodata() async {
    if (listPekerjaan.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('tes').add({
          'nama': namaController.text,
          'nomor_hp': nomorHpController.text,
          'alamat': alamatController.text,
          'pendidikan': pendidikanController,
          'nama_pekerjaan': listNamaKerja,
          'tahun_kerja': listTahunKerja,
        });
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> updateBiodata(id) async {
    if (listPekerjaan.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('tes').doc(id).update({
          'nama': namaController.text,
          'nomor_hp': nomorHpController.text,
          'alamat': alamatController.text,
          'pendidikan': pendidikanController,
          'nama_pekerjaan': listNamaKerja,
          'tahun_kerja': listTahunKerja,
        });
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<String>> getPendidikanList() async {
    final uri = Uri.parse(ApiConfig.pendidikan);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      return jsonData
          .where((pendidikan) => pendidikan['pendidikan'] != null)
          .map<String>((pendidikan) => pendidikan['pendidikan'] as String)
          .toList();
    } else {
      throw Exception('Failed to load pendidikan list');
    }
  }

  valueList(String? newValue) {
    notifyListeners();
    pendidikanController = newValue;
    notifyListeners();
  }

  void submitForm() {
    listNamaKerja.add(namaPekerjaanController.text);
    listTahunKerja.add(tahunMasukController.text);
    listPekerjaan.add(
        '${namaPekerjaanController.text} (${tahunMasukController.text} tahun)');
    notifyListeners();

    namaPekerjaanController.clear();
    tahunMasukController.clear();
    notifyListeners();
  }

  void getDataById(String id) async {
    await FirebaseFirestore.instance
        .collection('tes')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        dataModel = BiodataModel.fromFirestore(documentSnapshot);
        namaController.text = dataModel.nama;
        nomorHpController.text = dataModel.nomorHp;
        alamatController.text = dataModel.alamat;
        pendidikanController = dataModel.pendidikan;
        listPekerjaan = dataModel.listPekerjaan;
        listNamaKerja = documentSnapshot.get('nama_pekerjaan');
        listTahunKerja = documentSnapshot.get('tahun_kerja');
        notifyListeners();
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void deletePekerjaan(int index) {
    listPekerjaan.removeAt(index);
    listNamaKerja.removeAt(index);
    listTahunKerja.removeAt(index);
    notifyListeners();
  }
}
