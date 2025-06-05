import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class route extends StatefulWidget {
  const route({super.key});

  @override
  State<route> createState() => _routeState();
}

class _routeState extends State<route> {
  @override
  Widget build(BuildContext context) {
    //経路案内
    return SingleChildScrollView(child: Column(children: [

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(alignment: Alignment.centerLeft,child: Text("経路案内",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),)),
      ),
      
      Card(child: Container(height: 800.h,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage("images/map.png"),fit: BoxFit.fill),),),))







    ],),);
  }
}