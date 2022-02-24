import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoretutorial/screens/update_screen.dart';
import 'package:flutter/material.dart';

class RetrieveData extends StatefulWidget {
  const RetrieveData({Key? key}) : super(key: key);

  @override
  _RetrieveDataState createState() => _RetrieveDataState();
}

class _RetrieveDataState extends State<RetrieveData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Tasks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot task =
                      (snapshot.data! as QuerySnapshot).docs[index];
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${task['data']}',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection("Tasks")
                                                      .where("data",
                                                          isEqualTo:
                                                              task['data'])
                                                      .get()
                                                      .then((snapshot) =>
                                                          snapshot.docs.first
                                                              .reference
                                                              .delete());
                                                },
                                                child: Icon(Icons.delete)),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new UpdateScreen(
                                                                  data: task[
                                                                      'data'])));
                                                },
                                                child: Icon(Icons.update))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
