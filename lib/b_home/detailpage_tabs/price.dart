import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';


class Price extends StatefulWidget {
  const Price({super.key,required this.cost,required this.name,required this.location,required this.images});

  final String location;
  final String name;
  final String cost;
  final Map images;

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  Map<String,Map>  filter_map= {};
  String doc_id="";
  Set<String> mkRadio_button={"a","b","c"};
  String select_Radio="a";
  
  Future<void> set_doc()async{
      await
      FirebaseFirestore
      .instance
      .collection("field")
      .where("location",isEqualTo: "${widget.name}")
      .get()
      .then(
        (snapshot){
          snapshot.docs.forEach((e){
              setState(() {
                doc_id=e.id;                
              });
          });
        }
      );
  }

  void purchase(){
  //課金処理を実装

  //DB保存
  String? email=FirebaseAuth.instance.currentUser!.email;
  FirebaseFirestore.instance.collection("purchase").doc(email).collection("my_purchase").add(
    {
      "name":widget.name,
      "location":widget.location,
      "cost":widget.cost,
      "section":select_Radio,
      "images":widget.images
    }
  );
  //販売数書き換え
  FirebaseFirestore
  .instance
  .collection("field")
  .where("location",isEqualTo: widget.name)
  .get()  
  .then(
    (snapshot)=>{
      snapshot.docs.forEach((e){
          FirebaseFirestore
          .instance
          .collection("field")
          .doc(e.reference.id)
          .update({
          "sell_field.${select_Radio}":false
          });
      })
    }
  );
  //完了表示
  QuickAlert.show(
    context: context, 
    showConfirmBtn: false,
    type: QuickAlertType.success,
    text: '購入が完了しました.'
    );
  }


  void error(){

   QuickAlert.show(
   context: context,
   showConfirmBtn: false, 
   type: QuickAlertType.error,
   text: "完売してします"
   );

  }






  @override
  void initState(){
      super.initState();     
      set_doc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: 
    Scaffold(
      backgroundColor: Colors.white,
      body:  doc_id.isEmpty
       ?Center(child: CircularProgressIndicator())
       :SingleChildScrollView(
        child: Column(children: [
          
          //区画部分
          Column(children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.centerLeft,child: Text("区画",style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),)),
            ),

            Container(height: 600.h,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/field.png"),fit: BoxFit.contain)),),
            
            
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerLeft,child: Text("選択してください:",style: TextStyle(fontWeight: FontWeight.bold),)),
                ),


                //ボタン状態管理 
                Container(width: 500.w,height: 60.h,
                  child: Center(
                    child: StreamBuilder(
                      stream: FirebaseFirestore
                      .instance
                      .collection("field")
                      .doc("${doc_id}")
                      .snapshots(),
                    
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return CircularProgressIndicator();
                        }
                        //売られた区画を削除
                        snapshot.data!.data()!["sell_field"].forEach((key,value){
                           if(!value){
                            mkRadio_button.remove(key);
                           }
                           else{
                            mkRadio_button.add(key);
                           }
                        });
                    
                        return mkRadio_button.isEmpty
                        ?Center(child: Text("完売しました"))
                        :ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mkRadio_button.length,
                        itemBuilder: (context,index){
                          return  Row(children: [
                            Radio(
                            value: mkRadio_button.elementAt(index),
                             groupValue:  select_Radio, 
                             onChanged: (value){
                              setState(() {
                                select_Radio=value.toString();
                              });
                             }),
                             Text(mkRadio_button.elementAt(index))
                          ],);
                    
                        });
                      }
                    ),
                  ),)
                //ボタン状態管理            

              ],),
          ],),
          //区画部分

          Divider(height: 1,),
          
          //購入表示部分
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20,left: 8,right: 8),
              child: Text("購入可能区画:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45.sp),),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("全て購入可能です",style: TextStyle(fontSize:45.sp,fontWeight: FontWeight.bold),),
            )

          ],),
          //購入表示部分

          Divider(height: 1,),

          SizedBox(height: 140.h,),

          //購入部分
          Column(
              children: [
            
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("お支払い金額(合計)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.sp),),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.cost}円/月々",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.sp)),
                  )
                
                
                ],),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                height: 150.h,width: double.infinity.w,
                child: ElevatedButton(
                child: Text('購入する',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 45.sp),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  mkRadio_button.isEmpty?error():purchase();
                },
              ),
            ),
          ),
        ),

        ],),//購入部分


      ],),),//全体の

   ),); 
  }
}














Widget purschase_button(Function() onTap, String text){

return
Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
  style: ElevatedButton.styleFrom(   
  elevation: 10,  
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: onTap, 
  child: Text(text,style: TextStyle(color: Colors.black),)),
);

}


Widget purschase_text(String  key,String value,){

return

    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(alignment: Alignment.centerLeft,child: Text(key,style: TextStyle(fontSize: 50.sp),)),
        ),
        
          
        SizedBox(width: 600.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.centerRight,child: Text(value,style: TextStyle(fontSize: 50.sp),overflow: TextOverflow.ellipsis,)),
          ),
        ),
            
         
      ]);
}

    










