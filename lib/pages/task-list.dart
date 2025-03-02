import 'package:flutter/material.dart';
import 'package:flutter_qlnv/states/task-list.dart';

class MyTaskListPage extends StatefulWidget {
  const MyTaskListPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => MyTaskListPageState();
}
