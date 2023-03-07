import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/pages/login_page.dart';
import 'package:lista_tarefas_firebase/widgets/created_tasks.dart';

import '../controllers/auth_controller.dart';

import '../controllers/database_controller.dart';
import '../widgets/finished_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        AuthController.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      }),
                      icon: const Icon(Icons.exit_to_app)),
                ],
                title: const Text("Welcome, !"),
                bottom: const TabBar(
                    tabs: [Tab(text: "Criadas"), Tab(text: "Finalizadas")]),
              ),
              body:
                  const TabBarView(children: [CreatedTasks(), FinishedTasks()]),
            )));
  }
}
