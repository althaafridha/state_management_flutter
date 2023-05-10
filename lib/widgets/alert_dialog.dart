import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latihan_state_management/cubit/data_bloc.dart';

showAlertDialog(BuildContext context, id) {
  final cubit = DataBloc();
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      cubit.deleteData(id);
      Navigator.pushNamed(context, '/provider');
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
}
