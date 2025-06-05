import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/firebase_options.dart';
import 'package:flutter_application_8/b_home/2_bottom_bar.dart';
import 'package:flutter_application_8/a_login/0_start.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Firebase.apps.length==0){
  await Firebase.initializeApp(
    name: "remortfarming",
    options: DefaultFirebaseOptions.android
  );
  }
  runApp(
    ScreenUtilInit(
      designSize: const Size(1080,2400),
      builder: (BuildContext context,Widget? child) =>const MyApp() ,
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final bool isLogin =FirebaseAuth.instance.currentUser !=null;

     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin?  apphome(): HOMEapp(),
     );
    
  }

}



// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:async';
// import 'dart:math' as math;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);



//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   late List<LiveData> chartData;
//   late ChartSeriesController _chartSeriesController1;
//   late ChartSeriesController _chartSeriesController2;
//   late ChartSeriesController _chartSeriesController3;
//   late ChartSeriesController _chartSeriesController4;

//   int time = 2;
//   void updateDataSource(Timer timer) {
//     chartData.add(LiveData(time++, 160, 130, 140, 180));
//     chartData.removeAt(0);

//     _chartSeriesController1.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);

//     _chartSeriesController2.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);

//     _chartSeriesController3.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);

//     _chartSeriesController4.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//   }

//   List<LiveData> getChartData() {
//     return <LiveData>[
//       LiveData(1, 0,0,0,0),
//       LiveData(2, 0,0,0,0),
//     ];
//   }




//   @override
//   void initState() {
//     chartData = getChartData();
//     Timer.periodic(const Duration(seconds: 1), updateDataSource);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(

//           body: 
//           
//           SfCartesianChart(

//           primaryXAxis:const NumericAxis(
//               majorGridLines: const MajorGridLines(width: 0),
//               edgeLabelPlacement: EdgeLabelPlacement.shift,
//               interval: 3,
//               title: AxisTitle(text: 'Time (seconds)')),

//           primaryYAxis: NumericAxis(isVisible: false,),

//           axes: const [
//                    NumericAxis(
//                     name: 'yAxis1',
//                     opposedPosition: true,
//                     title: AxisTitle(text: '温度(°C)',textStyle: TextStyle(fontSize: 14)),
//                   ),

//                   NumericAxis(
//                     name: 'yAxis2',
//                     opposedPosition: true,
//                     title: AxisTitle(text: '湿度&土壌水分(%)',textStyle: TextStyle(fontSize: 14)),
//                   ),

//                   NumericAxis(
//                     name: 'yaxis3',
//                     title: AxisTitle(text: "照度(lx)",textStyle: TextStyle(fontSize: 14)),
//                   )

//           ],

//           series: <LineSeries<LiveData, int>>[

//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController1= controller;
//             },
//             dataSource: chartData,
//             color: Colors.green,
//             xValueMapper: (LiveData sales, _) => sales.x,
//             yValueMapper: (LiveData sales, _) => sales.y1,
//             yAxisName: "yAxis1",
//           ),

//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController2 = controller;
//             },
//             dataSource: chartData,
//             color: Colors.red,
//             xValueMapper: (LiveData sales, _) => sales.x,
//             yValueMapper: (LiveData sales, _) => sales.y2,
//             yAxisName: "yAxis2",
//           ),


//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController3 = controller;
//             },
//             dataSource: chartData,
//             color: Colors.blue,
//             xValueMapper: (LiveData sales, _) => sales.x,
//             yValueMapper: (LiveData sales, _) => sales.y3,
//             yAxisName: "yAxis2",
//           ),


//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController4 = controller;
//             },
//             dataSource: chartData,
//             color: Colors.purple,
//             xValueMapper: (LiveData sales, _) => sales.x,
//             yValueMapper: (LiveData sales, _) => sales.y4,
//             yAxisName: "yaxis3",
//           ),


//         ],
                    
                    
//     )
// ));

//   }
// }



// class LiveData {
//   LiveData(this.x, this.y1,this.y2,this.y3,this.y4);
//   final int x;
//   final num y1;
//   final num y2;
//   final num y3;
//   final num y4;
// }

