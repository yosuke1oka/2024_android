import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/more_detail.dart';
import 'package:flutter_application_8/b_home/detailpage_tabs/price.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/rendering.dart';


class detail_page extends StatefulWidget {
  const detail_page(
    {
      super.key,
      required this.location,
      required this.cost,
      required this.name,
      required this.images
    });

    final String location;
    final String name;
    final String cost;
    final Map images;

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  //名前 金額 場所 画像アセット  を　email　でdb保存 保存場所で再描画
  //保存アイコンはemail->保存? ブックマーク済み : ブックマーク非表示
  String? user_email= FirebaseAuth.instance.currentUser!.email;  
  bool bookmarked= false;

  @override 
  void initState(){
    is_bookmarked();
    super.initState();
  }

  Future<void> add_bookmark()async{
    //名前 金額 場所 画像アセット  を　email　でdb保存 保存場所で再描画
     FirebaseFirestore.instance.collection("favorite").doc(user_email).collection("my_collection").add({
       "name":widget.name,
       "location":widget.location,
       "cost":widget.cost,
       "images":widget.images,
    });
    bookmarked=true;
  }

  Future<void> delete_bookmark()async{
    //名前 金額　場所　画像アセット　を　email でdbから削除
     FirebaseFirestore.instance
      .collection('favorite')
      .doc(user_email)
      .collection("my_collection")
      .where('name',isEqualTo: widget.name)
      .get()
      .then(
      // 取得したdocIDを使ってドキュメント削除
        (QuerySnapshot snapshot) =>{
          snapshot.docs.forEach((f) {
            FirebaseFirestore.instance
                .collection('favorite')
                .doc(user_email)
                .collection("my_collection")
                .doc(f.reference.id)
                .delete();
          })
        },
      );  
    bookmarked=false;
  }

  Future<void> is_bookmarked()async{
    //現在表示されているページが保存済みか確認 
    FirebaseFirestore.instance
    .collection('favorite')
    .doc(user_email)
    .collection("my_collection")
    .where('name',isEqualTo: widget.name)
    .get()
    .then(
      (QuerySnapshot snapshot) =>{
        snapshot.docs.forEach((f) {
          setState(() {
            bookmarked=true;
          });
        })
      },
    );  
        
  }

  @override
  Widget build(BuildContext context) {
    return  
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  
      CupertinoPageScaffold(child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text("")),
          backgroundColor: Colors.white,
          elevation: 10,
          shadowColor: Colors.white,
          //左_戻るアイコン  
          leading: GestureDetector(child:  Icon(Icons.arrow_back_ios,),
          onTap: (){
            Navigator.pop(context);
          },
          ),
          //右保存アイコン　

          //右🈪アイコン
        actions: [
          IconButton(onPressed: (){
            setState(() {    
            //名前 金額 場所 画像アセット  を　email　でdb保存 保存場所で再描画
            //保存アイコンはemail->保存? ブックマーク済み : ブックマーク非表示
            bookmarked?  delete_bookmark():  add_bookmark();
            });
     
          }, icon: bookmarked? Icon(Icons.bookmark_outlined):Icon(Icons.bookmark_border),),
          EndDrawerButton()
        ],          
        ),


      body: 
      
      Container(color: Colors.white,child: Column(children: [
        
            SizedBox(height: 20.h,),        
            Center(child: Card(elevation: 10,child: Container(height: 700.h,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: NetworkImage("${widget.images["field_image"]}"),fit: BoxFit.fill)),),)),
            SizedBox(height: 20.h,),
        
            Flexible(
                child: DefaultTabController(length: 2,
                  child: Column(children: [
    
                    Container(color: Colors.white,
                      child:const TabBar(tabs: [
                        Tab(icon: Icon(Icons.info_outline_rounded),text: "詳細",),
                        Tab(icon: Icon(Icons.currency_yen_rounded),text:"お支払い",)
                      ]),
                    ),

                    Flexible(child: 
                      TabBarView(children: [
                        new MoreDetail(location: widget.location,cost: widget.cost,name: widget.name,),
                        Price(location: widget.location,cost: widget.cost,name: widget.name,images: widget.images,),
                          
                      ],),
                    ),
                    
                    
                
                
                
                  ],),),
              
            ),

        
          ],),
        ),
      ),),
      
      
      
      );
  }
}





      // DefaultTabController(length: 2, child: 
      // NestedScrollView(
        
      // headerSliverBuilder: (BuildContext context,bool innerBoxisScrolled){
      // return<Widget>[
        
      //           SliverAppBar(
      //           backgroundColor:Colors.blueGrey[50] ,
      //           pinned: true,   
      //           expandedHeight: 500,
      //           //下の線
      //           bottom: AppBar(
      //           toolbarHeight: 30,
      //           automaticallyImplyLeading: false,
      //           shadowColor: Colors.white,
      //           backgroundColor: Colors.white,

      //           centerTitle: true,
      //           title: Container(height: 5,width: 100,color: Colors.grey,),
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(30), topRight: Radius.circular(30)),)
      //           ),
      //           //背景
      //           flexibleSpace: flex()
      //       ),

      //       //タブ
      //        SliverPersistentHeader(
      //         pinned: true,
      //         delegate: _StickyTabBarDelegate(
      //           tabBar: TabBar(
      //             labelColor: Colors.black,
      //             tabs: [Tab(icon:Icon(Icons.info_outline),text: '詳細',),Tab(icon: Icon(Icons.currency_yen), text: 'お支払い',),],
      //           ),
      //         ),
      //       )                
      // ];       
      // },//ヘッダー部分

      // body:
      // TabBarView(
        
      //   children: [
      //     MoreDetail(location: location,),
      //     Price(),
      //   ]),
      // )

      // ),

// //SliverPersistentHeaderDelegateを継承したTabBarを作る //プライベートでこのファイルのみで設定
// class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
//   const _StickyTabBarDelegate({required this.tabBar});

//   final TabBar tabBar;

//   @override
//   double get minExtent => tabBar.preferredSize.height;

//   @override
//   double get maxExtent => tabBar.preferredSize.height;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(
//       color: Colors.white,
//       child: tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
//     return tabBar != oldDelegate.tabBar;
//   }
// }





// Widget flex (){
// return 

//  SingleChildScrollView(child: Column(children: [
//                   Padding(
//                       padding: const EdgeInsets.only(top:20 ,left:8 ,right:8 ,bottom:8 ),
//                       child: Container(
//                         height: 400,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                             image: AssetImage("images/abc.jpg"),
//                             fit: BoxFit.cover),
//                         ),

//                       ),
//                     ),
//                   ],),);


// }