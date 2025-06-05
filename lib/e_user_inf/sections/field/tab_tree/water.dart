import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pod_player/pod_player.dart';
import 'package:quickalert/quickalert.dart';

class Water extends StatefulWidget {
  const Water({super.key});

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {


  late final PodPlayerController controller;

  @override
  void initState(){
  //ここでネットから動画を取得
  controller=PodPlayerController(playVideoFrom: PlayVideoFrom.asset(
    "images/abc.mp4"
    )
    )..initialise();
    super.initState();
  }

  @override 
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //水やりタイムラプス
    return  SingleChildScrollView(
      child: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(alignment: Alignment.centerLeft,child: Text("今日のタイムラプス",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45.sp),)),
          ),
          
          ],),
        ),
      


        //ここから    
        Padding(
          padding: const EdgeInsets.all(0),
          child:Card(elevation: 20,child: Container(height: 700.h,child: PodVideoPlayer(controller: controller),))
        ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 20,
              child:InkWell(
                onTap: () {
                  //http通信でphpで散水制御
            
                  QuickAlert.show(
                    context: context,
                     type: QuickAlertType.success,
                     showConfirmBtn: false,
                     text: "水やりが完了しました"
                     );
            
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200.h,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Icon(Icons.water_drop),Text("水をやる")],),
                ),
              ),
            ),
          ),   
          

 
      ],),
    );
  }
}