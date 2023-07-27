import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database dataBase;
  List<Map> NewTasks = [] ;
  List<Map> DoneTasks = [] ;
  List<Map> ArchivedTasks = [] ;

  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  void changeIndex (int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDB() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (dataBase, version) {
        print("dataBase created");
        dataBase
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT , date TEXT , time TEXT , status TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (dataBase) {
        GetFromDatabase(dataBase);
        print("dataBase opened");
      },
    ).then((value) {
      dataBase=value;
      emit(AppCreateDatabaseState());
    });
  }

 InsertToDtabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
     await dataBase.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date , time, status) VALUES("$title","$date","$time","new")')
          .then((value) {

        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        GetFromDatabase(dataBase);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
    });
  }
 void GetFromDatabase(dataBase)
  {
    NewTasks = [];
    DoneTasks = [];
    ArchivedTasks= [];
     dataBase.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element) {
         if (element['status']== 'new')
           NewTasks.add(element);
         else if (element['status']== 'Done')
         DoneTasks.add(element);
         else ArchivedTasks.add(element);
       });
       emit(AppGetDatabaseState());
     });


  }
  void  UpdateData({
    required String status ,
    required int id ,
}) async{
    // Update some record
    dataBase.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id],
   ).then((value) {
     GetFromDatabase(dataBase);
     emit(AppUpdateDatabaseState());
    });
  }
  void  DeleteData({

    required int id ,
  }) async{
    // Update some record
    dataBase.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      GetFromDatabase(dataBase);
      emit(AppDeleteDatabaseState());
    });
  }
  bool isBottomSheetShown = false;
  void changeBottomSheetState ({
    required bool isShow,
}){
    isBottomSheetShown=isShow;
    emit(AppChangeBottomSheetState());

  }
}