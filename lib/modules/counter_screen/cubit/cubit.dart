import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_screen/cubit/states.dart';

class counterCubit extends Cubit<counterStates>
{
  counterCubit() : super(counterInitialState());
  static counterCubit get(context)=> BlocProvider.of(context);
  int counter =1 ;
  void minus (){
    counter--;
    emit(counterMinusChangeState());
  }

  void plus (){
    counter++;
    emit(counterPlusChangeState());
  }
}