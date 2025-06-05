import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/tab_tree/d_chat/6_mainchat.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key,required this.name,required this.section});

  final String name;
  final String section;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    //カレンダー
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [

          Card(elevation: 20,child: Container(height: 700.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage("images/ca.png"),fit: BoxFit.fill)),),),
          
          SizedBox(height: 40.h,),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Card(
              elevation: 20,
              child:InkWell(
                onTap: (){},
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200.h,
                  width: 490.w,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Icon(Icons.edit_calendar_rounded),Text("予定を決める")],),              
                ),
              ),
            ),

            Card(
              elevation: 20,
              child:InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChatPage(collection_id: "${widget.name}_${widget.section}")));
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200.h,
                  width: 490.w,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Icon(Icons.chat),Text("chatで尋ねる")],),
                ),
              ),
            ),

          ])
          
        ],),
      ),
    );
  }
}