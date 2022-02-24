import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoretutorial/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String data;
  UpdateScreen({required this.data});
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _textController = new TextEditingController();

  void _showSuccessfulMessage(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("From StartupProjects"),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new HomeScreen()));
                    },
                    child: Text("okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(hintText: "Enter Updated Task"),
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  String message = "data updated successfully";
                  FirebaseFirestore.instance
                      .collection("Tasks")
                      .where("data", isEqualTo: widget.data)
                      .get()
                      .then(
                        (snapshot) => snapshot.docs.first.reference
                            .update({"data": _textController.text}),
                      );
                  _showSuccessfulMessage(message);
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
