import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userID;

  DatabaseService(this.userID);

  final CollectionReference userToDos =
      FirebaseFirestore.instance.collection('userToDos');

  Stream<DocumentSnapshot<Object?>> getTodos() {
    return userToDos.doc('4t01k2PUvrhGU1BmCDBR').snapshots();
  }

  Future setTodo(String item, bool value) async {
    return await userToDos
        .doc('4t01k2PUvrhGU1BmCDBR')
        .set({item: value}, SetOptions(merge: true));
  }
  Future deleteTodo(String key) async {
    return await userToDos.doc('4t01k2PUvrhGU1BmCDBR').update({
      key: FieldValue.delete(),
    });
  }

  Future deleteAllTodos(key) async {

  }

  Future checkIfUserExists() async {
    if ((await userToDos.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
  }
}

