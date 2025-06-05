import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/a_login/2_signup_page.dart';
import 'package:flutter_application_8/b_home/2_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}
class _login_pageState extends State<login_page> {

  String email="";
  String password="";


  final _passcontroller=TextEditingController();
  final _emailcontroller=TextEditingController();



  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _passcontroller.dispose();
    _emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return 

    Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(height: 10.h,width: 200.w,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("ログインして始めましょう!!",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),),
        ),

        SizedBox(height: 50.h,),
        

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 160.h,
            child: TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: "メールアドレス",
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),    
                ),
              ),
              onChanged: (value) {
                email=_emailcontroller.text;
              },
            ),
          ),
        ),

        SizedBox(height: 40.h,),
        
  
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 160.h,
            // color: Colors.green,
            child: TextField(
              controller: _passcontroller,
              decoration: InputDecoration(
                labelText: "パスワード",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password=_passcontroller.text;
                });
              },
              obscureText: true,
            ),
          ),
        ),

        SizedBox(height: 50.h,),


                  Container(
                  height: 160.h,
                  child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180.h,
                        width: 800.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),

                        child: ElevatedButton(
                          onPressed: () async{

                            try {
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(builder: (context) => apphome()), 
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided for that user.');
                                }
                              }

                          },
                          child: Center(child: Text("login",style: TextStyle(fontWeight: FontWeight.bold),)),

                        ),
                      ),
                    ),
                                        
                ),
              

          Divider(height: 1,),
          
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("アカウントをお持ちでない方はこちら"),
          SizedBox(width: 10),
          TextButton(onPressed: (){ 
            Navigator.pop(context);  
              
            showModalBottomSheet(
            context: context,
            builder: (context) => signup_page(),
            );
          }, child: Text("sign up"))
      
        ]),



    ],)
  ); 

  }
   

}

          


            //次のページで遷移すると子modalの場所で画面遷移する

            // showModalBottomSheet(
            // context: context,
            // builder: (context) => Navigator(
            // onGenerateRoute: (context) => MaterialPageRoute(
            // builder: (context) => signup_page(),
            // ),
            // ),
            // );