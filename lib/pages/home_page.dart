import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/widgets/created_tasks.dart';

import '../widgets/finished_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Welcome! ${_auth.currentUser!.email.toString()}"),
              bottom: const TabBar(
                  tabs: [Tab(text: "Criadas"), Tab(text: "Finalizadas")]),
            ),
            body: const TabBarView(children: [CreatedTasks(), FinishedTasks()]),
          )),
    );
  }
}
