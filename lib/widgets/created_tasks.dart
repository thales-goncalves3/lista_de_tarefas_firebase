import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/pages/create_task_page.dart';

class CreatedTasks extends StatefulWidget {
  const CreatedTasks({super.key});

  @override
  State<CreatedTasks> createState() => _CreatedTasksState();
}

class _CreatedTasksState extends State<CreatedTasks> {
  Stream<QuerySnapshot> _getData() {
    return FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateTask(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _getData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            var newList = snapshot.data!.docs
                .where((element) => element["finished"] == false)
                .toList();

            List<bool> checked =
                List.generate(newList.length, (element) => false);

            return ListView.builder(
              itemCount: newList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(newList[index]["title"]),
                              subtitle: Text(newList[index]["description"]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: checked[index],
                                  onChanged: (value) {
                                    
                                    setState(() {
                                      if (checked[index]) {
                                        checked[index] = false;
                                      } else {
                                        checked[index] = true;
                                      }
                                    });
                                  },
                                ),
                                const Icon(Icons.delete_outline_outlined),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
