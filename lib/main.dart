import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/to_do/todo.dart';
import 'package:todo_app/shared/bloc%20observer.dart';

import 'modules/counter_screen/counter.dart';


void main()   {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: ToDoScreen(),
    );
  }
}

