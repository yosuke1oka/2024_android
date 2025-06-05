import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      
      
      CupertinoPageScaffold(child: Scaffold(

        body: 
      
      
      NestedScrollView(
        

      headerSliverBuilder: (BuildContext context,bool innerBoxisScrolled){

      return<Widget>[
                SliverAppBar(
                backgroundColor:Colors.blueGrey[50] ,
                pinned: true,   
                expandedHeight: 700,
                //下の線
                bottom: AppBar(
                toolbarHeight: 30,
                automaticallyImplyLeading: false,
                shadowColor: Colors.white,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Container(height: 5,width: 100,color: Colors.grey,),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30)),)
                ),

                //背景
                flexibleSpace: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(34.39159189,136.9040060),
                    initialZoom: 10,
                    maxZoom: 18,
                    minZoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' ,
 
                    )
                ])
 
            ),
             
      ];       
      },//ヘッダー部分

      body:
      Container()
      ),





      )),

    );
  }
}