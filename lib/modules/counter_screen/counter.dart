import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_screen/cubit/cubit.dart';
import 'package:todo_app/modules/counter_screen/cubit/states.dart';


class counterApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)=> counterCubit(),
    child: BlocConsumer<counterCubit , counterStates>(
      listener: (context ,state){},
      builder: (context , state) {
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'counter App',
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  child: Icon(
                    Icons.add,

                  ),

                  onPressed:(){
                    counterCubit.get(context).plus();
                  },
                ),
                Text("${counterCubit.get(context).counter}"),
                FloatingActionButton(
                  child: Icon(
                    Icons.remove,
                  ),
                  onPressed:(){
                    counterCubit.get(context).minus();

                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
  }

}