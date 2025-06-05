import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/4_1detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favorite_pageState();
}

class _favorite_pageState extends State<favorite> {
  
  String? user_email= FirebaseAuth.instance.currentUser!.email;
  bool is_null=false;
  
  
  @override
  Widget build(BuildContext context) {
     return CupertinoPageScaffold(child: Scaffold(
      backgroundColor: Colors.white,
      body: 
      
      Container(
        child: StreamBuilder(
          stream: FirebaseFirestore
          .instance
          .collection("favorite")
          .doc(user_email)
          .collection("my_collection")
          .snapshots(),
        
          builder: (context,snapshot){
            if(!snapshot.hasData){return Center(child: CircularProgressIndicator());}

            if(snapshot.data!.docs.length==0){
                is_null=true;
            }

            return is_null
            ?Center(child: Padding(
              padding: const EdgeInsets.only(right:30.0,left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 500.h,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/favorite.png"))),),
                  Container(child: Text("保存するとここに追加されます",style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold),),)
                ],
              ),
            ))    
            : GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                ), 
              itemBuilder: (context,index){
              QueryDocumentSnapshot favorite_data=snapshot.data!.docs[index];
                String name=favorite_data["name"];
                String location=favorite_data["location"];
                String cost=favorite_data["cost"];
                Map images=favorite_data["images"];
                return Favorite_card(name: name, cost: cost, location: location,images: images,);
              }
              );

          }
          ),
      )

        

     ));

  }
}




class Favorite_card extends StatefulWidget {
  const Favorite_card({super.key,required this.name,required this.cost,required this.location,required this.images});

   final String name;
   final String cost;
   final String location;
   final Map images;

  @override
  State<Favorite_card> createState() => _Favorite_card();
}

class _Favorite_card extends State<Favorite_card> {
   
    
  @override
  Widget build(BuildContext context) {
    return           //660.h,660.w

          OpenContainer(
              closedBuilder: ( (context,index){

              return  
                                                                                                        
                           Card(elevation: 10,child: SizedBox(height: 660.h,width: 660.w,child: Column(children: [
                            
                                  Container(
                                    height: 340.h,
                                    decoration:  BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("${widget.images["field_image"]}"),
                                        fit: BoxFit.fill),
                                        borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                          color: Colors.cyan,
                                          boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 10,offset: Offset(0, 2),)]
                                          ),
                                          ), 
                            
                                          Padding(
                                             padding: const EdgeInsets.only(left: 5.0),
                                              child: Row(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 3,top: 0),
                                                  child: Container(width: 494.w,child:Text(widget.name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 39.sp),),),
                                                ),
                                                
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Container(width: 494.w,child: Row(
                                                    children: [
                                                    Icon(Icons.location_on_outlined,size: 50.sp,),
                                                    SizedBox(width: 442.w,child: Text(widget.location,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 39.sp),),),
                                                  ],),),
                                                ),
                                                
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 3,top: 0),
                                                  child: SizedBox(width: 494.w,child:Text("${widget.cost}円/月々",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 39.sp),),),
                                                ),
                                                
                                                ],),
                                    
                                              ],
                                            ),
                                          ),                        
                            
                                         ],),),);
                        
                          }), 
                          
                          openBuilder: ((context,Index){
                            return  detail_page(location: widget.location,cost: widget.cost,name: widget.name,images: widget.images,);
                          })
                        );
   
  }
}