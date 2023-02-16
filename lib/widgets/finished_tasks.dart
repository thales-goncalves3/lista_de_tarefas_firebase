import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FinishedTasks extends StatefulWidget {
  const FinishedTasks({super.key});

  @override
  State<FinishedTasks> createState() => _FinishedTasksState();
}

class _FinishedTasksState extends State<FinishedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),
    );
  }
}
