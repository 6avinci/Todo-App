import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.title, this.done, {super.key});
  final String title;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: done ? Colors.green : Colors.red,
        appBar: AppBar(
          title: const Text('Details'),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Text(
                          done
                              ? 'Das hast du schon erledigt:'
                              : 'Das musst du noch machen:',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ))),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          title,
                          style: GoogleFonts.staatliches(
                              textStyle: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  letterSpacing: 2)),
                        ))),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          String message;
                          if (done) {
                            message = 'Ich habe "$title" erledigt!';
                          } else {
                            message = 'Das muss noch erledigt werden: $title';
                          }
                          Share.share(message);
                        },
                        icon: const Icon(Icons.share, color: Colors.white),
                      ),
                      IconButton(
                        iconSize: 60,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                            done
                                ? Icons.thumb_up_alt_outlined
                                : Icons.thumb_down_alt_outlined,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
