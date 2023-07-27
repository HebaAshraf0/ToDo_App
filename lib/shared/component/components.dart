import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultFormField
(
{
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  //  Function onChanged ,
  // Function? onSubmitted,
  Function? validate,
   required String label,
   required IconData prefix, required  Function() onTap,
  bool isClickable = true,



})
=> TextFormField(
controller: controller,
keyboardType:type ,
obscureText:isPassword ,
onTap: onTap,
// onTap:onTap() ,
// onChanged:onChanged() ,
// onFieldSubmitted: onSubmitted(),
validator: (value) {

return validate!(value);
},
decoration: InputDecoration(
labelText:label ,
enabled: isClickable,
prefixIcon: Icon(
    prefix,

),
border: OutlineInputBorder(),

)
,
);

Widget biuldTasksItem(Map model , context)
=>Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  children: [

  CircleAvatar(

  radius: 40.0,

    backgroundColor: Colors.pinkAccent[100],

  child: Text(

  '${model['time']}',

    style: TextStyle(

      color: Colors.white,

    ),

  ),



  ),

  SizedBox(

  width: 20.0,

  ),

  Expanded(

    child:   Column(



    mainAxisSize: MainAxisSize.min,







    children: [



    Text(



      '${model['title']}',



    style: TextStyle(



    fontSize: 18.0,



    fontWeight: FontWeight.bold,



    ),



    ),



    Text(



      '${model['date']}',



    style: TextStyle(



    color: Colors.grey,



    ),



    ),



    ],



    ),

  ),

    SizedBox(

      width: 20.0,

    ),

    IconButton(onPressed:()

    {

      AppCubit.get(context).UpdateData(status: 'Done', id: model['id']);

    },

        icon: Icon(

          Icons.done_outline_outlined,

          color: Colors.green,

        ),

    ),

    IconButton(onPressed:()

    {

      AppCubit.get(context).UpdateData(status: 'Archived', id: model['id']);

    },

        icon: Icon(

          Icons.archive

        ),

    ),



  ],

  ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).DeleteData(id: model['id']);

  },
);