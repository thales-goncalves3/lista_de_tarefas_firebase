import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/firebase_controller.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final controller = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Title",
                          hintText: "Title"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: description,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Description",
                          hintText: "Description"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.createTask(title.text, description.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Create"),
                  )),
            ],
          )),
    );
  }
}
