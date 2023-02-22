import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/controllers/firebase_controller.dart';
import 'package:lista_tarefas_firebase/firebase_options.dart';
import 'package:lista_tarefas_firebase/pages/home_page.dart';

import 'package:lista_tarefas_firebase/pages/login_page.dart';
import 'package:lista_tarefas_firebase/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controller = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.list,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: controller.getUser() == null ? const LoginPage() : const HomePage(),
    );
  }
}
