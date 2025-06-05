
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_8/b_home/all_show_favorit.dart';
import 'package:flutter_application_8/b_home/all_show_near.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/4_1detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


   bool search_location=false;
   
   Map<String,bool> tags={
    "ホテル 周辺":false,
    "観光地 周辺":false,
    "駅 周辺":false,
    "商店街 周辺":false,
   };

   List<String> tags_pushed=[];

   Map<String,Map> fls ={};
   
   List<String> true_value = [

   ];

   void tags_tap_add(key_tags){
    tags[key_tags]=true;
    tags_pushed.add(key_tags);
    
   }

   void tags_tap_delete(key_tags){
     tags[key_tags]=false;
     tags_pushed.remove(key_tags);
   }

   bool taptap=false;

  


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,

      home: CupertinoPageScaffold(child: 
      Scaffold(
        
          backgroundColor: Colors.white,


          appBar: AppBar(
            title: Text("resort farming",style: GoogleFonts.playball(fontSize: 65.sp),),
            backgroundColor: Colors.white,
            shadowColor: Colors.blueGrey[200],
            elevation: 20,

            actions: [IconButton(onPressed: (){
              showDialog(context: context, builder: (context){
                return Dialog(
                  insetPadding: EdgeInsets.all(20),
                  child: Container(height: 600,width: 500,
                  child: Column(children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("お知らせ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45.sp),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(child: SingleChildScrollView(child: Column(children: [

                        Card(child: Container(height: 100,decoration: BoxDecoration(color: Colors.amberAccent,borderRadius: BorderRadius.circular(10)),),)
                      
                    
                      
                      ],),)),
                    )

                  ],),)
                  
                );

              });


            }, icon: Icon(Icons.mail))],
          ),


          body: 
        
              Container( color: Colors.blueGrey[50],
                  child: SingleChildScrollView(
                    child: Column(children: [ 
                  

                      SizedBox(height: 52.h,),
                  
                  
                      //ヘッダー1   
                        Card(elevation: 10,
                          child: SizedBox(height:250.h,child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          
                               Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  SizedBox(height: 20.h,),
                                  Align(alignment: Alignment.centerLeft,child: Text("場所で絞り込む:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.sp),)),
                          
                                  Row(children: [
                                    Icon(Icons.location_on_outlined,size: 60.sp,),
                          
                                    SizedBox(width: 400.w,child: search_location?Text("",overflow: TextOverflow.ellipsis,):Text("検索して場所を入力",style: TextStyle(fontSize:40.sp ),))
                          
                                  ],)
                                    
                                ],),
                              ),
                              
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(child: InkWell(borderRadius: BorderRadius.circular(10),onTap: (){},child: Container(height: 140.h,width: 140.w,child: Icon(Icons.search),),),),
                            )
                          
                          ],                
                          ),),
                      ),
                      //
                  
                    
                  
                  
                      //ヘッダー2 簡易しぼりこみ 
                      Container(height:240.h,child: 
                      
                          Column(
                            children: [
                              SizedBox(height: 40.h,),

                              Container(height: 160.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tags.length,
                                  itemBuilder: (context,index){
                                    String key_tags=tags.keys.elementAt(index);
                                    bool value_tags=tags.values.elementAt(index);
                                    return searchtile(
                                    onPressed: (){ setState(() {
                                      value_tags?tags_tap_delete(key_tags):tags_tap_add(key_tags);
                                      taptap?taptap=false:taptap=true;
                                    });}, 
                                    title: key_tags,
                                    tag_ontap: value_tags,
                                    );

                                  }
                                  ),
                              ),

                              SizedBox(height: 40.h,),

                            ],
                          ),  

                      ),
                      //
                  
                  
                  
                      //body 
                      Padding(
                        padding: const EdgeInsets.only(top:8,bottom: 8),
                        child: Card(elevation: 10,
                          child: SizedBox(height: 920.h,child: Column(children: [
                          
                          tag(onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>AllShow()));
                          },
                          title: "近くのスポット",
                          ),

                          SizedBox(height: 30.h,),
                          //290
                           SizedBox(height:660.h,width: double.infinity,child: 
                                      
                                StreamBuilder(
                                  stream: FirebaseFirestore
                                  .instance
                                  .collection("field")
                                  .orderBy("id")
                                  .snapshots(),                  
                                
                                builder: (context,snapshot){
                                  if(!snapshot.hasData){
                                    return CircularProgressIndicator();
                                  }   

                                  snapshot.data!.docs.forEach((e){
                                      Map data =  e.data()["target"];
                                      //tureだけ抽出
                                      data.forEach((key,value){
                                        if(value){
                                          switch(key){
                                            case "near_hotel":{true_value.add("ホテル 周辺");break;}
                                            case "near_resort":{true_value.add("観光地 周辺");break;}
                                            case "near_station":{true_value.add("駅 周辺");break;}
                                            case "near_shop":{true_value.add("商店街 周辺");break;}
                                          }
                                          }
                                     });
                                     //tag_pushedにlistの内容が一つでも含まれていれば登録
                                     if(tags_pushed.any((value)=>true_value.contains(value))){
                                       fls.putIfAbsent(e.data()["location"], ()=>e.data());
                                     }
                                     //そうでなければ削除
                                     else{
                                      fls.remove(e.data()["location"]);
                                     }
                                     true_value.clear();                                  
                                  });
                                  //何もボタンが押されていなければ通常生成,ボタンが何か押されていれば生成 
                                  return tags_pushed.isEmpty
                                  ?
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context,index){
                                    DocumentSnapshot data = snapshot.data!.docs[index];
                                    String name = data["location"];
                                    String cost =data["money"];
                                    Map images=data["images"];
                                    String location ="あとから入れます";
                                    return  bodycam(name: name, cost: cost, location: location,images: images,);                                                                                                                                                                 
                                  })
                                  : 
                                    ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: fls.length,
                                    itemBuilder:(context, index) {
                                    Map a = fls.values.elementAt(index); 
                                    String location = "あとから入れます";
                                    return bodycam(name: a["location"], cost: a["money"], location: location, images: a["images"]);                        
                                    },
                                    );
                          
                                })
                              ),
                               
                          ],),
                          ),
                        ),
                      ),
                      //body
                  

                      
    
                      //フッダー   人気のスポット 
                      Padding(
                        padding: const EdgeInsets.only(top:8,bottom: 8),
                        child: Card( elevation: 10,
                          child: SizedBox(height: 500.h,child: Column(children: [
                          
                          tag(title: "人気のスポット", onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>all_show_favorit()));
                          }), 

                          SizedBox(height: 30.h,),
                          
                          SizedBox(height: 260.h,
                          child: StreamBuilder(
                            stream: FirebaseFirestore
                            .instance
                            .collection("field")
                            .snapshots(), 
                          
                            builder: (context,snapshot){
                              if(!snapshot.hasData){
                                return CircularProgressIndicator();
                              }
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,Index){
                                
                                DocumentSnapshot data =snapshot.data!.docs[Index];
                                String name =data["location"];
                                String cost=data["money"];
                                Map images=data["images"];
                                String location ="後で決めます";
                                   
                                return popular(name: name, cost: cost, location: location,images: images,);
                              });
                            }
                            )
                          )
                          
                          ],),),
                        ),
                      ),
                      //フッダー

             
                    ],),
                  ),
                ),
              ),
               
      ),
    );
  }
}







class tag extends StatelessWidget {
  const tag({super.key,required this.title,required this.onTap});

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return    
            SizedBox(height: 150.h,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title,style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: onTap, child: Text("全て表示",style: TextStyle(fontSize: 40.sp),)),
                )
              ],));

  }
}



class popular extends StatefulWidget {
  const popular({super.key,required this.name,required this.cost,required this.location,required this.images});

  final String name;
  final String cost;
  final String location;
  final Map images;

  @override
  State<popular> createState() => _popularState();
}

class _popularState extends State<popular> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: ((context,index){
        return
                      Padding(
                        padding: const EdgeInsets.only(right: 2,left: 2),
                        child: Card(elevation: 10,child: SizedBox(width: 780.w,child: Row(children: [
                        
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(height: 200.h,width: 200.w,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: NetworkImage("${widget.images["field_image"]}"),fit: BoxFit.fill)),),
                        ),
                        
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 3,top: 4.0),
                          child: Container(width: 494.w,child:Text(widget.name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 40.sp),),),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(width: 494.w,child: Row(
                            children: [
                            Icon(Icons.location_on_outlined,size: 50.sp,),
                            SizedBox(width: 442.w,child: Text(widget.location,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 40.sp),),),
                          ],),),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 3,top: 4.0),
                          child: SizedBox(width: 494.w,child:Text("${widget.cost}円/月々",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 40.sp),),),
                        ),
                         
                        ],)
                                            
                        
                                            
                        
                                          ],),),),
                      );

      }), 
      
      openBuilder: ((context,index){
        return   detail_page(location: widget.location,name: widget.name,cost: widget.cost,images: widget.images);
      })
      );




  }
}
        


class searchtile extends StatefulWidget {
  const searchtile({super.key,required this.onPressed,required this.title,required this.tag_ontap});

final Function() onPressed;
final  String title;
final  bool  tag_ontap;

  @override
  State<searchtile> createState() => _searchtileState();
}



class _searchtileState extends State<searchtile> {
  @override
  Widget build(BuildContext context) {
    return 

        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(elevation: 5,
            child: SizedBox(width: 340.w,
              child: ElevatedButton(
                      child: Text(widget.title,style: TextStyle(fontSize: 40.sp,color: widget.tag_ontap?Colors.white:Colors.purpleAccent[900]),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.tag_ontap?Colors.purple[900]:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: widget.onPressed,
                      ),
            ),
          ),
        );

    
  }
}



class bodycam extends StatefulWidget {
  const bodycam({super.key,required this.name,required this.cost,required this.location,required this.images});

   final String name;
   final String cost;
   final String location;
   final Map images;
   
  @override
  State<bodycam> createState() => _bodycamState();
}

class _bodycamState extends State<bodycam> {
   
    
  @override
  Widget build(BuildContext context) {
    return           //660.h,660.w

          OpenContainer(
              closedBuilder: ( (context,index){

              return  
                                                                                                        
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                            child: Card(elevation: 10,child: SizedBox(height: 660.h,width: 660.w,child: Column(children: [
                            
                                  Container(
                                    height: 468.h,
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
                            
                                         ],),),),
                          );
                          }), 
                          
                          openBuilder: ((context,Index){
                            return  detail_page(location: widget.location,cost: widget.cost,name: widget.name,images: widget.images,);
                          })
                        );
   
  }
}