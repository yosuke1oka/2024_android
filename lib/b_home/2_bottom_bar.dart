import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_8/b_home/3_hom.dart';
import 'package:flutter_application_8/c_search/4_serch.dart';
import 'package:flutter_application_8/e_user_inf/6_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class apphome extends StatefulWidget {
  const apphome({super.key});

  @override
  State<apphome> createState() => _apphomeState();
}

class _apphomeState extends State<apphome> {

  // ignore: unused_field
  int  _selectedindex=0;

  final tabs=[
    home(),
    search(),
    User(),
  ];


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        child: Scaffold(
          body: tabs[_selectedindex],


          // ボトムナビバー
          bottomNavigationBar:

       
           Container(
             height: 220.h,
             color: Colors.white.withValues(alpha: 0),
             child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight: Radius.circular(10)),
                    child: BottomNavigationBar(  
                      backgroundColor: Colors.white, 
                      elevation: 10,
                      currentIndex: _selectedindex,
                      onTap: (index){
                        setState(() {
                          _selectedindex=index;
                        });
                      },          
                    items:const <BottomNavigationBarItem>[
                    //HOME画面
                    
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home,size: 25,color: Colors.black,),
                      label: 'Home',
                      tooltip: "ホーム",
                    ),
                    
                    //検索画面
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map_outlined,size: 25,color: Colors.black,),
                      label: 'Map',
                      tooltip: "検索",
                      backgroundColor: Colors.white,
                    ),
                    
                    //個人情報画面
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person,size: 25,color: Colors.black,),
                      label: 'User',
                      tooltip: "ユーザー",
                      backgroundColor: Colors.white,
                    ),
                    
                      ]
                      ),
                  ),
                ),
           ),

          ),
        ),

          
    );    
  }
}