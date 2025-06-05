import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/my_field_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myfield extends StatefulWidget {
  const myfield({super.key,});

  @override
  State<myfield> createState() => _myfieldState();
}


class _myfieldState extends State<myfield> {
  bool is_empty=false;

  @override
  Widget build(BuildContext context) {
    
    String? user = FirebaseAuth.instance.currentUser!.email;

    //購入DBからモデル構築して押されたら各項目の設定に飛ぶ
    return Container(
    child: StreamBuilder(
      stream: FirebaseFirestore
      .instance
      .collection("purchase")
      .doc(user)
      .collection("my_purchase")
      .snapshots(),

      builder: (context,snapshot){

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.data!.docs.length==0){  
            is_empty=true;
        }

        return is_empty
        ?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 500.h,width: 500.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/field.jpg"),fit: BoxFit.cover)),),
            Text("購入するとここに追加されます",style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold),)
          ],
        )

        :ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index){
          QueryDocumentSnapshot data= snapshot.data!.docs[index];
          String this_filed_image=data["images.field_image"];
          String name =data["name"];
          String location =data["location"];
          String section =data["section"]; 

          return 

          Card(
            child:InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>my_field_sectionState(name: name,location: location,section: section,)));
              },
              child: Container(
                height: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 250.h,width: 250.w,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: NetworkImage(this_filed_image),fit: BoxFit.fill)),),
                    ),

                    Flexible(child: Container(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(name,textAlign: TextAlign.start,style: TextStyle(fontSize: 40.sp),),
                      ),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Icon(Icons.location_on_outlined,size: 60.sp,),

                      Text(location,textAlign: TextAlign.start,style: TextStyle(fontSize: 40.sp),)
                      ],),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text("区画: ${section}",textAlign: TextAlign.start,style: TextStyle(fontSize: 40.sp),),
                      ),
                      
                    ],),)),
                    
    
                  ],),
                ),
            ) 
          );
        });

      }
    ),
  );
      
}

}





