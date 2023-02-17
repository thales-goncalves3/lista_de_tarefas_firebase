import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

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
                    FirebaseAuth auth = FirebaseAuth.instance;
                    FirebaseFirestore db = FirebaseFirestore.instance;

                    final task = {
                      "title": title.text,
                      "description": description.text,
                      "finished": false,
                    };

                    db.collection(auth.currentUser!.uid.toString()).add(task);
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
