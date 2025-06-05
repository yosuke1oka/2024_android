import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/a_login/1_login_page.dart';
import 'package:flutter_application_8/a_login/2_signup_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class HOMEapp extends StatefulWidget {
  const HOMEapp({super.key});

  @override
  State<HOMEapp> createState() => _HOMEappState();
}

class _HOMEappState extends State<HOMEapp> {


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(child: Scaffold(

    body:
    

      NestedScrollView(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
            physics: const NeverScrollableScrollPhysics(),
            dragDevices: {}, // no drag devices
      ),      
      headerSliverBuilder: (BuildContext context,bool innerBoxisScrolled){

      return<Widget>[

                SliverAppBar(
                pinned: true,   
                toolbarHeight: 1600.h,
                //下の線
                bottom: AppBar(
                title: Container(height: 10.h,width: 200.w,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),),
                centerTitle: true,
                toolbarHeight: 60.h,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30)),)
                ),
                flexibleSpace:Container(height: double.infinity,width: double.infinity,decoration: BoxDecoration(image:DecorationImage(image: AssetImage("images/home.png"),fit: BoxFit.fill)),child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:100.0,left: 20),
                    child: Text("resort\nfarming",style: GoogleFonts.playball(fontSize: 40,color: Colors.black)),
                  )
                ],),)
              )         
      ];       
      },//ヘッダー部分

      body:      
       Column(children: [
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Let's Start",style: GoogleFonts.playball(fontSize: 35),),
        ),


        Container(
        height: 160.h,
        child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1800.h,
              width: 800.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (context)=>login_page());
                },
                child: Center(child: Text("login",style: TextStyle(fontWeight: FontWeight.bold),)),

              ),
            ),
          ),
                              
      ),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("アカウントをお持ちでない方はこちら"),
          TextButton(onPressed: (){

            showModalBottomSheet(context: context,
             builder: (BuildContext context)=>signup_page()
             );
            
            }, child: Text("sing up",))
        ],)
        
      ],),)
      
      ),

    

      ));
      }

  }
