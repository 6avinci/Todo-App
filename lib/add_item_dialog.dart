import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  final void Function(String txt) addItem;
  const AddItemDialog(this.addItem, {super.key});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late String item;

  void save() {
    if (formKey.currentState!.validate()) {
      widget.addItem(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onChanged: (String txt) => item = txt,
                onFieldSubmitted: (String txt) => save(),
                validator: (v) {
                  if (v!.startsWith(" ") || v.isEmpty) {
                    return 'Bitte Aufgabe eintragen!';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.limeAccent,
                  shadowColor: Colors.teal,
                ),
                child: const Text(
                  'Auf die Liste',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}