import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class DeleteAllDialog extends StatefulWidget {
  final void Function(String txt) deleteAll;
  DeleteAllDialog(this.deleteAll, {super.key});

  @override
  _DeleteAllDialogState createState() => _DeleteAllDialogState();
}

class _DeleteAllDialogState extends State<DeleteAllDialog> {
  DatabaseService? database;
  final GlobalKey<FormState> formKey = GlobalKey();

  void yes() {
  database?.deleteAllTodos;

  }
  void no() {
  Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
      SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Wirklich ALLE ToDos löschen?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () { FirebaseFirestore.instance.collection('userToDos').doc("4t01k2PUvrhGU1BmCDBS").delete();
                                  Navigator.pop(context);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.limeAccent,
                  shadowColor: Colors.teal,
                ),
                child: const Text(
                  'Ja, ich will!',
                  style: TextStyle(color: Colors.white),
                ),
              ), ElevatedButton(
                onPressed: no,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.limeAccent,
                  shadowColor: Colors.teal,
                ),
                child: const Text(
                  'Nicht löschen!',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}