import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/tab_tree/route.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/tab_tree/schedule.dart';
import 'package:flutter_application_8/e_user_inf/sections/field/tab_tree/water.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class my_field_sectionState extends StatefulWidget {
  const my_field_sectionState({super.key,required this.name,required this.location,required this.section});
  final String name;
  final String location;
  final String section;
  @override
  State<my_field_sectionState> createState() => _my_field_sectionStateState();
}


class _my_field_sectionStateState extends State<my_field_sectionState> {

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController1;
  late ChartSeriesController _chartSeriesController2;
  late ChartSeriesController _chartSeriesController3;
  late ChartSeriesController _chartSeriesController4;

  void updateDataSource(Timer timer) {
    //10分毎にデータをとってくる
    //追加する時はdatetime.nowで追加 10分待って発火させてるから
    //firebsefirestorでwhreの最新のデータを持ってきて追加させるだけ

    chartData.add(LiveData(DateTime.now(), Random().nextInt(30), Random().nextInt(100), Random().nextInt(100), Random().nextInt(1500)));
    chartData.removeAt(0);

    _chartSeriesController1.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    _chartSeriesController2.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    _chartSeriesController3.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    _chartSeriesController4.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[ 
      LiveData(DateTime.now().subtract(Duration(minutes: 2)), 
      Random().nextInt(30), Random().nextInt(100), Random().nextInt(100), Random().nextInt(1500)),
      LiveData(DateTime.now().subtract(Duration(minutes: 1)), Random().nextInt(30), Random().nextInt(100), Random().nextInt(100), Random().nextInt(1500)),
      LiveData(DateTime.now(), Random().nextInt(30), Random().nextInt(100), Random().nextInt(100), Random().nextInt(1500)),
      
    ];
  }

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(minutes: 1), updateDataSource);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


 
  @override
  Widget build(BuildContext context){

    return CupertinoPageScaffold(child: Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("${widget.name}_${widget.section}"),
        shadowColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios))
        ),
      
      body: 
        Column(children: [
            Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(height: 800.h,child:

                    SfCartesianChart(

                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.minutes,
                      interval: 1,
                      dateFormat: DateFormat('yyyy-MM-dd HH:mm'),
                    ),

                    primaryYAxis: NumericAxis(isVisible: false,),

                    legend: Legend(isVisible: true),
                    tooltipBehavior:TooltipBehavior(enable: true),
                    

                    axes: const [
                            NumericAxis(
                              name: 'yAxis1',
                              opposedPosition: true,
                              title: AxisTitle(text: '温度(°C)',textStyle: TextStyle(fontSize: 12)),
                            ),

                            NumericAxis(
                              name: 'yAxis2',
                              opposedPosition: true,
                              title: AxisTitle(text: '湿度&土壌水分(%)',textStyle: TextStyle(fontSize: 12)),
                            ),

                            NumericAxis(
                              name: 'yaxis3',
                              title: AxisTitle(text: "照度(lx)",textStyle: TextStyle(fontSize: 12)),
                            )

                    ],

                      series: <LineSeries<LiveData, DateTime>>[

                      LineSeries<LiveData, DateTime>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController1= controller;
                        },
                        dataSource: chartData,
                        color: Colors.green,
                        xValueMapper: (LiveData sales, _) => sales.x,
                        yValueMapper: (LiveData sales, _) => sales.y1,
                        yAxisName: "yAxis1",
                        name: "温度(℃)",
                        
                      ),

                      LineSeries<LiveData, DateTime>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController2 = controller;
                        },
                        dataSource: chartData,
                        color: Colors.red,
                        xValueMapper: (LiveData sales, _) => sales.x,
                        yValueMapper: (LiveData sales, _) => sales.y2,
                        yAxisName: "yAxis2",
                        name: "湿度(%)",
                      ),


                      LineSeries<LiveData, DateTime>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController3 = controller;
                        },
                        dataSource: chartData,
                        color: Colors.blue,
                        xValueMapper: (LiveData sales, _) => sales.x,
                        yValueMapper: (LiveData sales, _) => sales.y3,
                        yAxisName: "yAxis2",
                        name: "土壌水分(%)",
                      ),


                      LineSeries<LiveData, DateTime>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController4 = controller;
                        },
                        dataSource: chartData,
                        color: Colors.purple,
                        xValueMapper: (LiveData sales, _) => sales.x,
                        yValueMapper: (LiveData sales, _) => sales.y4,
                        yAxisName: "yaxis3",
                        name: "照度(lx)",
                      ),


                    ],              
                )
            
          
              )
            ),
          ),


        //センサー値のグラフ化

          //日記的なのを追加 チャット表示
          Flexible(
            child:  DefaultTabController(
            length: 3, 
            child:  Column(children: [
          const TabBar(
                tabs: [
                Tab(text: "収穫予定",icon: Icon(Icons.calendar_month_rounded),),
                Tab(text: "水やり",icon: Icon(Icons.waterfall_chart_rounded),),
                Tab(text: "経路",icon: Icon(Icons.commute_sharp),),
              ]),

              Flexible(child: TabBarView(children: [
                Schedule(name: widget.name,section: widget.section,),
                Water(),
                route()      
              ])
             )
          
            ],)
            )
        )


           ])
       ),

  ); 
 }

 }
  


class LiveData {
  LiveData(this.x, this.y1,this.y2,this.y3,this.y4);
  final DateTime x;
  final num y1;
  final num y2;
  final num y3;
  final num y4;
}




        // Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          
        //   Card(
        //     elevation: 20,
        //     child:  Container(
        //       height: 245.h,
        //       width: 245.w,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10)
        //         ),
        //         child: const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        //           Icon(Icons.thermostat),
        //           Text("温度:26℃")
        //         ],),
        //       ),
        //   ),
    
        //   Card(
        //     elevation: 20,
        //     child:  Container(
        //       height: 245.h,
        //       width: 245.w,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10)
        //         ),
        //         child: const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        //           Icon(Icons.water_drop),
        //           Text("湿度:67%")
    
        //         ],),
        //       ),
        //   ),
    
        //   Card(
        //     elevation: 20,
        //     child:  Container(
        //       height: 245.h,
        //       width: 245.w,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10)
        //         ),
        //         child: const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        //           Icon(Icons.health_and_safety_sharp),
        //           Text("快適度:快適")
        //         ],),
        //       ),
        //   ),
          
                
        // ],)

    // Scaffold(

    // body:SingleChildScrollView(   child:Column(children: [
    //   SizedBox(height: 30,),

    //   Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: Card(
    //     color: Colors.white,
    //     shadowColor: Colors.black,
    //     elevation: 20,
    //     child: Container(height: 400,width: double.infinity, child: Column(
    //         mainAxisAlignment:  MainAxisAlignment.spaceAround,
    //         children: [
    //       //ここを映像に変換//

    //       Padding(
    //         padding: const EdgeInsets.all(10.0),
    //           child: Card(
    //             shadowColor: Colors.black,
    //             elevation: 20,
    //             child: Container(
    //               height: 200,
    //               decoration: BoxDecoration(  
    //               borderRadius: BorderRadius.circular(10)
    //               ),
    //               child: PodVideoPlayer(controller: controller),
    //             ),
    //            ),          
    //       ),


    //       //ここまでを映像に変換//
    //       const Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [

    //           Card(shadowColor: Colors.black,elevation: 20,child:SizedBox(height: 120,width: 120,child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Icon(Icons.thermostat),
    //           ), Text("温度:26°C"), ],),) ,),

    //           Card(shadowColor: Colors.black,elevation: 20,child: SizedBox(height: 120,width: 120,child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Icon(Icons.opacity),
    //           ),const Text("湿度:40%")],)),),

    //           Card(shadowColor: Colors.black,elevation: 20,child:SizedBox(height: 120,width: 120,child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Icon(Icons.ac_unit),
    //           ),Text("快適度:快適")],)),),

      
    //     ],),])),
    //   ),),

    //   SizedBox(height: 20),

    
    //   Container(
    //     height: 100,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //     children: [

    //     Card(elevation: 20,
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(10),
    //       onTap: () {
    //       },
    //       child: const SizedBox(height: 80,width: 130,child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,          
    //         children: [
    //         Icon(Icons.water_drop),
    //         Text("散水する")
    //       ],),),
    //     ),
    //   ),


    //     SizedBox(width: 50,),

    //     Card(elevation: 20,
    //         child: InkWell(
    //           borderRadius: BorderRadius.circular(10),
    //           onTap: () {},
    //           child: const SizedBox(height: 80,width: 130,child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,          
    //             children: [
    //             Icon(Icons.notifications_none),
    //             Text("通知する")
    //           ],),),
    //         ),
    //       ),
        
                
    //   ],),),

    //   Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Align(alignment: Alignment.centerLeft,child: Text("位置情報",style: TextStyle(fontSize: 20),),),
    //   ),


    //   Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Card(
    //       elevation: 20,
    //       shadowColor: Colors.black,
    //       child: Container(
    //       height: 300,
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage("images/map.png"),
    //           fit: BoxFit.fill
    //           ),
    //           borderRadius: BorderRadius.circular(10)
    //           ),
    //       ),


    //       ),
    //   ),


        
    // ],),)

    // );

