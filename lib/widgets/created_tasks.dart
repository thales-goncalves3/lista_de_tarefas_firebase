import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/database_controller.dart';

import 'package:lista_tarefas_firebase/pages/create_task_page.dart';

import '../controllers/auth_controller.dart';

class CreatedTasks extends StatefulWidget {
  const CreatedTasks({super.key});

  @override
  State<CreatedTasks> createState() => _CreatedTasksState();
}

class _CreatedTasksState extends State<CreatedTasks> {
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
          stream: DatabaseController.getData(),
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
                                    DatabaseController.updateTask(
                                        newList[index].id, {'finished': true});
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Delete Task"),
                                            content: const Text(
                                                "Are you sure you want delete the task?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    DatabaseController
                                                        .deleteTask(
                                                            newList[index].id);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("YES")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("CANCEL"))
                                            ],
                                          );
                                        },
                                      );
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
