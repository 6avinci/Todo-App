import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ToDoItem extends StatelessWidget {
  final String title;
  final bool done;
  final Function remove;
  final Function toggleDone;
  const ToDoItem(this.title, this.done, this.remove, this.toggleDone, {super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            leading: Checkbox(
              value: done,
              onChanged: (value) => toggleDone(),
              activeColor: Colors.greenAccent,
              checkColor: Colors.limeAccent,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: done ? Colors.teal : Colors.black54,
                decoration: done
                    ? TextDecoration.lineThrough
                    : TextDecoration.underline,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () => remove(),
            ),
            onTap: () {
              Navigator.push<Widget>(
                  context,
                  MaterialPageRoute<Widget>(
                      builder: (BuildContext context) =>
                          DetailScreen(title, done)));
            }));
  }
}