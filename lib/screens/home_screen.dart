import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoretutorial/screens/retrieve_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _taskController = new TextEditingController();
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
                      Navigator.pop(context);
                    },
                    child: Text("okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Crud"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _taskController,
                    decoration: InputDecoration(hintText: "Enter Task"),
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      String message = "Task added successfully";
                      Map<String, dynamic> data = {
                        "data": _taskController.text
                      };
                      FirebaseFirestore.instance
                          .collection("Tasks")
                          .add(data)
                          .then((value) => _showSuccessfulMessage(message));
                    },
                    child: Text("Submit")),
                SizedBox(
                  height: 13,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new RetrieveData()));
                    },
                    child: Text("View Task"))
              ],
            ),
          )),
    );
  }
}
