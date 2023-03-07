import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/database_controller.dart';
import 'package:lista_tarefas_firebase/pages/login_page.dart';
import 'package:lista_tarefas_firebase/widgets/created_tasks.dart';

import '../controllers/auth_controller.dart';
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
        home: StreamBuilder<QuerySnapshot>(
          stream: DatabaseController.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Não foi possivel buscar o usuario"),
              );
            } else {
              return DefaultTabController(
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
                      title: Text(
                          "Welcome, ${snapshot.data!.docs[0]["username"]}!"),
                      bottom: const TabBar(tabs: [
                        Tab(text: "Criadas"),
                        Tab(text: "Finalizadas")
                      ]),
                    ),
                    body: const TabBarView(
                        children: [CreatedTasks(), FinishedTasks()]),
                  ));
            }
          },
        ));
  }
}
