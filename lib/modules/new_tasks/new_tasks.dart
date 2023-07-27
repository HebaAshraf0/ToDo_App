import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/component/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../../shared/component/constants.dart';


class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var tasks = AppCubit.get(context).NewTasks;
        return ListView.separated(itemBuilder: (context,index) => biuldTasksItem(tasks[index] , context),
          separatorBuilder: (context,index) =>Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],

          ),
          itemCount: tasks.length,);
      },
    );

  }
}
