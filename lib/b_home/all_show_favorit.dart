import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/4_1detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class all_show_favorit extends StatefulWidget {
  const all_show_favorit({super.key});

  @override
  State<all_show_favorit> createState() => _all_show_favoritState();
}

class _all_show_favoritState extends State<all_show_favorit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("人気のスポット",),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
      ),

      body: Container(child: StreamBuilder(

        stream: FirebaseFirestore
        .instance
        .collection("field")
        .snapshots(),

         builder:(context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
        
        //------------------------
        //本来ならここで人気水準の高いものをフィルタリング
        //------------------------

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
            QueryDocumentSnapshot  data =snapshot.data!.docs[index];
            Map images=data["images"];
            String name=data["location"];
            String location="あとから入れます";
            String cost=data["money"];            
            return make_card(images: images, name: name, location: location, cost: cost);
            }
            );
         }

         ),
        ),

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

        Align(alignment: Alignment.centerLeft,child: Text(name,style: TextStyle(fontSize: 40.sp),)),
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