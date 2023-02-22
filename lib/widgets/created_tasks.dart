import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/firebase_controller.dart';
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

  final controller = FirebaseController();

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
              return const Center(child: CircularProgressIndicator());
            }

            final newList = snapshot.data!.docs
                .where((element) => element["finished"] == false)
                .toList();

            List<bool> checked =
                List.generate(newList.length, (element) => false);

            if (newList.isEmpty) return const Center(child: Text("No tasks"));

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
                              title: Text(
                                newList[index]["title"].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                    controller.updateTask(
                                        newList[index].id, {'finished': true});
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.deleteTask(newList[index].id);
                                    },
                                    icon: const Icon(
                                        Icons.delete_outline_outlined)),
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
