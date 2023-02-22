import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/firebase_controller.dart';
import 'package:lista_tarefas_firebase/widgets/created_tasks.dart';

import '../widgets/finished_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (() {
                      controller.signOut();
                      Navigator.of(context).pushNamed("/login_page");
                    }),
                    icon: const Icon(Icons.exit_to_app)),
              ],
              title: Text("Welcome, ${controller.getEmail()}!"),
              bottom: const TabBar(
                  tabs: [Tab(text: "Criadas"), Tab(text: "Finalizadas")]),
            ),
            body: const TabBarView(children: [CreatedTasks(), FinishedTasks()]),
          )),
    );
  }
}
