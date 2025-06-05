import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/4_1detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllShow extends StatefulWidget {
  const AllShow({super.key});

  @override
  State<AllShow> createState() => _AllShowState();
}

class _AllShowState extends State<AllShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("近くのスポット"),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        ),

      body: Container(
        child:StreamBuilder(
        
         stream: FirebaseFirestore
         .instance
         .collection("field")
         .snapshots(),
        
         builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }

          //-------------------------------------
          //本当だったら自分の位置情報から近くの場所をフィルタリングする
          //-------------------------------------
          
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,index){
            QueryDocumentSnapshot  data =snapshot.data!.docs[index];
            Map images=data["images"];
            String name=data["location"];
            String location="あとから入れます";
            String cost=data["money"];
              return make_card(images: images,name: name,location: location,cost: cost);
            }
            );
         }

        ) 
      ,)
    );

  }
}

Widget make_card({required Map images,required String name,required String location,required String cost}){

  return OpenContainer(
    closedBuilder: ((context,index){
      return
      Card(child: Column(children: [
        Container(
          height: 340.h,
          decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(image: NetworkImage("${images["field_image"]}"),fit: BoxFit.fill),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
              )
            ),
          ),

        Align(alignment: Alignment.centerLeft,child: Text(name,style:TextStyle(fontSize: 40.sp) ,)),
        Align(alignment: Alignment.centerLeft,child: Text(location,style: TextStyle(fontSize: 40.sp),)),
        Align(alignment: Alignment.centerLeft,child: Text("${cost}円/月々",style: TextStyle(fontSize: 40.sp),)),
      ],),  
      );
    }),
    openBuilder: ((context,index){
      return detail_page(location: location, cost: cost, name: name, images: images);
    })
    );
}