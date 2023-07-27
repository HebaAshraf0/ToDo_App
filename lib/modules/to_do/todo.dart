import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks.dart';
import 'package:todo_app/modules/done_tasks/done_tasks.dart';
import 'package:todo_app/modules/new_tasks/new_tasks.dart';
import 'package:todo_app/shared/component/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../shared/component/constants.dart';

class ToDoScreen extends StatelessWidget {



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   createDB();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context , AppStates state){
          if (state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context , AppStates state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(

              centerTitle: true,
              backgroundColor: Colors.pinkAccent[100],
              title: Text('ToDo App'),
            ),
            body: cubit.Screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pinkAccent[100],
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if(formKey.currentState!.validate())
                  {
                    cubit.InsertToDtabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    cubit.changeBottomSheetState(isShow: false);
                    // InsertToDtabase(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text
                    //
                    // ).then((value) {
                    //
                    //   isBottomSheetShown = false;
                    // });


                  }

                } else {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.grey[200],
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                            [
                              defaultFormField(
                                controller:titleController ,
                                type:TextInputType.text,
                                validate:(String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'title must not be empty';
                                  }
                                },
                                label: 'task title',
                                prefix:Icons.title ,
                                onTap: (){},
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                controller:timeController ,
                                type:TextInputType.datetime,
                                validate:(String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'time must not be empty';
                                  }
                                },
                                label: 'task time',
                                prefix:Icons.watch_later_outlined ,
                                // isClickable: false,
                                onTap: ()  {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),

                                  ).then((value) {
                                    timeController.text = value!.format(context).toString() ;
                                    print(value!.format(context));
                                  });
                                },

                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                controller:dateController ,
                                type:TextInputType.datetime,
                                validate:(String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'date must not be empty';
                                  }
                                },
                                label: 'task date',
                                prefix:Icons.calendar_today ,
                                // isClickable: false,

                                onTap: ()  {
                                  showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-07-30'),
                                  ).then((value) {
                                    dateController.text = value.toString() ;
                                    print(value);

                                  });
                                },

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  cubit.changeBottomSheetState(isShow: true);
                }
              },
              child: Icon(
                Icons.add,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.pinkAccent[200],
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
               cubit.changeIndex(index);

              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                  ),
                  label: 'Archived',
                )
              ],
            ),
          );
        },

      ),
    );
  }


}

