import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/b_home/2_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class signup_page extends StatefulWidget {
  const signup_page({super.key});

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  String email="";
  String password="";
  String name="";
 
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
          child: Text("登録して始めましょう!!",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),),
        ),

        SizedBox(height: 50.h,),

        Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 3),
          child: Container(
            height: 160.h,
            child: TextField(
              decoration: InputDecoration(
                labelText: "ニックネーム",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10))
                  ),
                  onChanged: (value) {
                    name=value;
                  },
                ),
              ),
        ),


        SizedBox(height: 40.h,),

        Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 3),
          child: Container(
            height: 160.h,
            child: TextField(
              decoration: InputDecoration(
                labelText: "メールアドレス",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10))
                  ),
                  onChanged: (value) {
                    email=value;
                  },
                ),
              ),
        ),

        SizedBox(height: 40.h,),

        Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 40),
          child: Container(
            height: 160.h,
            child: TextField(
              decoration: InputDecoration(
                labelText: "パスワード",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10))
                  ),
                  onChanged: (value) {
                    password=value;
                  },
                  obscureText: true,
                ),
              ),
        ),

        SizedBox(height: 50.h,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
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
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>apphome()));
                      FirebaseFirestore.instance.collection("user_name").doc(email).collection("this_name").add({"name":name});

                      } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                      } catch (e) {
                      print(e);
                      }

                    },
                    child: Center(child: Text("sign up",style: TextStyle(fontWeight: FontWeight.bold),)),
                  )

                ),
              ),

          ),
        ),

        ]));


    
  }

}