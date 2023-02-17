import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FinishedTasks extends StatefulWidget {
  const FinishedTasks({super.key});

  @override
  State<FinishedTasks> createState() => _FinishedTasksState();
}

class _FinishedTasksState extends State<FinishedTasks> {
  Stream<QuerySnapshot> _getData() {
    return FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _getData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            return data["finished"] == true
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(data['title']),
                                subtitle: Text(data["finished"].toString()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Checkbox(
                                    value: false,
                                    onChanged: null,
                                  ),
                                  Icon(Icons.delete_outline_outlined),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: null,
                  );
          }).toList(),
        );
      },
    ));
  }
}
