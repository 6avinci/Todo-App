import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add_item_dialog.dart';
import 'to_do_item.dart';
import 'database.dart';
import 'deleteAll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  runApp(const MaterialApp(home: ToDo()));
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DatabaseService? database;
  late User user;

  void addItem(String key) {
    database?.setTodo(key, false);
    Navigator.pop(context);
  }

  void deleteItem(String key) {
    database?.deleteTodo(key);
  }

  void deleteAllItems(String key) {
    database?.deleteAllTodos(key);
    Navigator.pop(context);
  }

  void toggleDone(String key, bool value) {
    database?.setTodo(key, !value);
  }

  void newEntry() {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AddItemDialog(addItem);
        });
  }
  void deleteAll() {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return DeleteAllDialog(deleteAllItems);
        });
  }

  Future<void> connectToFirebase() async {
    await Firebase.initializeApp();
    final FirebaseAuth authenticate = FirebaseAuth.instance;
    UserCredential result = await authenticate.signInAnonymously();
    user = result.user!;
    database = DatabaseService(user.uid);

    if (!(await database?.checkIfUserExists())) {} else {database?.setTodo('ToDos werden hier gezeigt!', false);}
  }

  @override
  void initState() {
    super.initState();
    connectToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          scrollDirection: Axis.vertical,
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'To-Do App!',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Times New Roman",
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = const Color.fromRGBO(150, 255, 20, 100),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'To-Do App!',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Times New Roman",
                        color: Colors.grey[175],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.lightGreen,
              ),
              body: FutureBuilder(
                  future: connectToFirebase(),
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // When stream exists, use Streambilder to wait for data
                  return StreamBuilder<DocumentSnapshot>(
                    stream: database?.getTodos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        // resolve stream... Stream<DocumentSnapshot> -> DocumentSnapshot -> Map<String, bool>
                      //  Map<String, dynamic> items = snapshot.data!.data() as Map<String, dynamic>;
                          Map items = {};
                          items = snapshot.data!.data() as Map<String, dynamic>;
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, i) {
                              String key = items.keys.elementAt(i);
                              return ToDoItem(
                                key,
                                items[key],
                                () => deleteItem(key),
                                () => toggleDone(key, items[key]),
                              );
                            });
                      }
                    },
                  );
                }
              }),
              floatingActionButton:
                  Wrap(direction: Axis.horizontal, children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                  child: FloatingActionButton(
                    onPressed: newEntry,
                    tooltip: "Neues ToDo hinzufügen",
                    backgroundColor: const Color.fromRGBO(35, 152, 25, 100),
                    child: const Icon(Icons.data_saver_on),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                  child: FloatingActionButton(
                    onPressed: deleteAll,
                    tooltip: "Lösche alle deine gespeicherten ToDo's",
                    backgroundColor: const Color.fromRGBO(35, 152, 25, 100),
                    child: const Icon(Icons.phonelink_erase_rounded),
                  ),
                )
              ]),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          ],
        ));
  }
}
