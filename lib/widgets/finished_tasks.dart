import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/database_controller.dart';

class FinishedTasks extends StatefulWidget {
  const FinishedTasks({super.key});

  @override
  State<FinishedTasks> createState() => _FinishedTasksState();
}

class _FinishedTasksState extends State<FinishedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            .where((element) => element["finished"] == true)
            .toList();

        List<bool> checked = List.generate(newList.length, (element) => true);

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
                            newList[index]["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                                    newList[index].id, {'finished': false});
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  DatabaseController.deleteTask(
                                      newList[index].id);
                                },
                                icon:
                                    const Icon(Icons.delete_outline_outlined)),
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
