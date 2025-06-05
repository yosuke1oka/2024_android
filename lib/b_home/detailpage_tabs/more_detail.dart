import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreDetail extends StatefulWidget {
  const MoreDetail({
    super.key,
    required this.location,
    required this.cost,
    required this.name,
    });
    final String location;
    final String cost;
    final String name;
  @override
  State<MoreDetail> createState() => _MoreDetailState();
}

class _MoreDetailState extends State<MoreDetail> {

  @override
  Widget build(BuildContext context) {
    return 
    
    
    SingleChildScrollView(child: Column(children: [


      Column(children: [

       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            SizedBox(width: 700.w,child: Text("${widget.name}",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
          ],),
       ),
       Padding(
         padding: const EdgeInsets.only(bottom:8.0),
         child: Row(children: [
          Icon(Icons.location_on_outlined),
          SizedBox(width: 1000.w,
            child: Text("${widget.location}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 45.sp),
            ),
          )
          ],),
       )

      ],),

      const Divider(height: 1,),


      Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment:Alignment.topLeft,child: Text("その他,禁止事項",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),)),
        ),

          Container(height: 500.h,child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("くわ,トラクター,スコップ含め農作業に必要な道具を取り揃えております。",style: TextStyle(fontSize: 45.sp),),
            ),

            SizedBox(height: 10.sp,),

            Column(children: [

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(alignment: Alignment.centerLeft,child: Text("・路上駐車禁止",style: TextStyle(fontSize: 45.sp),)),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Align(alignment: Alignment.centerLeft,child: Text("・喫煙禁止",style: TextStyle(fontSize: 45.sp),)),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(alignment: Alignment.centerLeft,child: Text("・荒らし禁止",style: TextStyle(fontSize: 45.sp),)),
              ),



            ],)

            



          ],
          ),),

      
      ],),


      Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment: Alignment.topLeft,child: Text("プレビュー",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),)),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [

            cardwidget(),
            cardwidget(),
            cardwidget(),
          

          

          
          ],),
        )



      ],)

      
      
    ],),);










    
    // Scaffold(
    //   body: SingleChildScrollView(
    //   child: Column(children: [

    //    SizedBox(height: 20,),
       
    //    //場所　地名
      
    //    ListTile(
    //     leading: Icon(Icons.location_on_outlined,size: 30,),
    //     title: Text("鳥羽畑",style: TextStyle(fontSize: 20),),
    //     subtitle: Text("${widget.location}",style: TextStyle(fontSize: 20),),
    //    ),
    //    Divider(height: 1,),

    //    Padding(
    //      padding: const EdgeInsets.all(8.0),
    //      child: Align(alignment: Alignment.centerLeft,child: Text("利用できる農具",style: TextStyle(fontSize: 20),)),
    //    ),
        
    //    //データ入力
    //    Container(height: 300,child: Column(children: [

    //     Text("くわ、トラクター、スコップ等々",style: TextStyle(fontSize: 15),)





    //    ],),),
       
    //    Divider(height: 1),

      
    //     Padding(
    //      padding: const EdgeInsets.all(8.0),
    //      child: Align(alignment: Alignment.centerLeft,child: Text("その他,禁止事項",style: TextStyle(fontSize: 20),)),
    //    ),

    //    //データ入力
    //    Container(height: 200,)


    //   ],),)
    // );



  }
}



Widget cardwidget(){
  return

            Card(elevation: 10,child: Container(height: 500.h,width: 800.w,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage("images/k.jpg"),fit: BoxFit.fill)),),);



}