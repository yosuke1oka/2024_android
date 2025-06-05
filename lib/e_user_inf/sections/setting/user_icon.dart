import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close)),),
      body: Column(
        children: [
          SizedBox(height: 100.h,),

          Center(
            child: Container(
              height: 450.h,
              width: 450.w,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("images/a.png"),
                  fit: BoxFit.fill,
                  )
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
            
                  IconButton(onPressed: (){}, icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 30,
                        color: Colors.white,
                        )
                      )
                    )
            
                ],),
              ),
          ),

          SizedBox(height: 150.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            SizedBox(width: 80.w,),

            Card(
              child: Container(
                width: 500.w,
                child: Text(
                  textAlign: TextAlign.center,
                  "2166s",
                  style: TextStyle(
                  fontSize: 50.sp,
                  overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.draw_rounded,size: 80.sp,))



          ],)

          
          
        




      ],)
    );
  }
}