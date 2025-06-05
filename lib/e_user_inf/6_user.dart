import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/a_login/0_start.dart';
import 'package:flutter_application_8/e_user_inf/sections/favorit/favorite.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/field.dart';
import 'package:flutter_application_8/e_user_inf/sections/setting/setting.dart';
import 'package:flutter_application_8/e_user_inf/sections/setting/user_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> { 

  String? username=FirebaseAuth.instance.currentUser!.email;
  late String nick_name="";

 Future<void> get_user_nickname()async{
  await
  FirebaseFirestore
  .instance
  .collection("user_name")
  .doc(username)
  .collection("this_name")
  .get()
  .then(
    (snapshot){
      snapshot.docs.forEach((e){
        setState(() {
          nick_name=e.data()["name"];
        });
      });
    }
  );
 }

  @override
  void initState(){
      super.initState();     
      get_user_nickname();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(child: Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        elevation: 20,
        shadowColor: Colors.white,
        //DBの登録ユーザー名
        title: Container(width: 100,child: Text("${username}",style: TextStyle(fontSize: 50.sp),),)
      ),


      endDrawer: Drawer(child: Column(children: [
        SizedBox(height: 280.h,),
        Container(height: 280.h,width: 280.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/a.png"),fit: BoxFit.fill),shape: BoxShape.circle),),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(onTap: () {},leading: Icon(Icons.info),title: Text("定期購入"),),
        )

        ],),),



          body: Column(children: [

            Container(height: 400.h,color: Colors.white10,child: Row(children: [

                  Container(width: 270.w,child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [  
                  
                        OpenContainer(
                          closedColor: Colors.white10,
                          closedElevation: 0,
                          closedBuilder: ((context,_){
                          return 
                           Column(
                              children: [
                              Container(
                                  height: 200.h,
                                  width: 200.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("images/a.png"),
                                      fit: BoxFit.fill
                                      )
                                    )
                                  ),
                              Text(nick_name,style: TextStyle(fontSize: 40.sp),overflow: TextOverflow.ellipsis,)
                              ],);
                          }), 

                          openBuilder: ((context,_){
                            return UserIcon();     
                            }))
                  
                  ],),),
                
               Flexible(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  users_card("設定", (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>settings()));
                  }, Icons.settings),
                  users_card("ログアウト", ()async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context)=>HOMEapp()));
                  }, Icons.logout_rounded)

              ],))

            ],),),

            const Flexible(child: DefaultTabController(length: 2, child: Column(children: [

              TabBar(
                dividerHeight: 1,
                tabs: [
                Tab(icon: Icon(Icons.format_color_fill_rounded),text: "マイ畑",),
                Tab(icon: Icon(Icons.bookmarks_rounded),text: "お気に入り",)
              ]),

              Flexible(child: TabBarView(children: [
                myfield(),
                favorite()
              ]))

            ],))
            )

          ],)

      )),      
    );
  }
}




Widget users_card(String text,Function() onTap,IconData icon){
return 

        Card(elevation: 20,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child:  SizedBox(height: 270.h,width: 270.w,child: Column(
            mainAxisAlignment: MainAxisAlignment.center,          
            children: [
            Icon(icon),
            Text(text)
          ],),),
        ),
      );


}





      // endDrawer:  Drawer(
      //     child:  Column( 
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //       Column( children: [
            
      //       SizedBox(height: 40,),
      //          Padding(
      //            padding: const EdgeInsets.all(20.0),
      //            child: ListTile(
      //           leading: Icon(Icons.settings,size: 40,),
      //           title: Text("設定"),
      //           onTap:() {
      //             },
      //            ),
      //          ),
              
      //       ]),
      //         //logout 
      //         Padding(
      //            padding: const EdgeInsets.all(20),
      //            child: ListTile(
      //           leading: Icon(Icons.logout,size: 40,),
      //           title: Text("ログアウト"),
      //           onTap: () async{
      //             await FirebaseAuth.instance.signOut();
      //             Navigator.push(context,CupertinoPageRoute(builder: (context)=>HOMEapp()));
      //           },
      //            ),
      //          ),    
      //       ],)
      //     ),
