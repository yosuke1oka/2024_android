

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class ChatPage extends StatefulWidget {
  ChatPage({super.key,required this.collection_id });

  final String collection_id;

  @override
  _ChatPageState createState() =>  _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  String? email= FirebaseAuth.instance.currentUser!.email;
 
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      
        appBar:  AppBar(
          title:  Text("通知用チャット君"),
          elevation: 20,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          centerTitle: true,
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search)),IconButton(onPressed: (){}, icon: Icon(Icons.format_list_bulleted_outlined))],
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),      
        ),

        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              //チャット部分
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ChatApp")
                      .doc(email)
                      .collection(widget.collection_id)
                      .orderBy("time", descending: true)
                      .snapshots(),

                  builder: (context, snapshot) {

                    if (!snapshot.hasData){
                      Center(child: CircularProgressIndicator(),);
                      }
                  
                    return  widget.collection_id.isEmpty
                    ?Center(child: CircularProgressIndicator(),)
                    :ListView.builder(
                      padding:  EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) {
                        DocumentSnapshot data =  snapshot.data!.docs[index];

                        bool isSelfText = false;
                        if (data['email'] == email) {
                          isSelfText = true;
                        }

                        return isSelfText
                            ? _SelfText(data['sent_text'])
                            : _OtherText(data['sent_text']);
                      },
                      itemCount: snapshot.data!.docs.length,
                    );

                  },
                ),
              ),

              
              //送信部分
              Divider(height: 1.0),

              Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                     Flexible(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                        child:  TextField(
                          controller: _controller,
                          // onSubmitted: _handleSubmit,
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),hintText: "メッセージを送信"),
                        ),
                        ),
                      )
                    ),
                     Container(
                      child:  IconButton(icon: Icon(Icons.send),
                          onPressed: () {
                            _handleSubmit(_controller.text);
                          }),
                    ),
                  ],
                ),
              ),

              
            ],
          ),
        ));
  }

  //自分のメッセージの場合
  Widget _SelfText(String message,) {
    return 
        Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [


        SizedBox(width: 150,),

        Container(child: 
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0,bottom: 2),
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              color: Colors.green
            ),

            child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message,style: TextStyle(fontSize: 17),),
            ),

          ),
          ),
        ),
        )
        

      ]);
  }
  
  //他の人の場合
  Widget _OtherText(String message) {
    return Row(

      children: <Widget>[

        Container(child: 
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0,bottom: 2),
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),topRight:Radius.circular(20)),
              color: (message!="")  ? Colors.grey:null
            ),

            child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message,style: TextStyle(fontSize: 17),),
            ),

          ),
          ),
        ),
        ),

        SizedBox(width: 150,)

      
      ],

      );
  }

  
  
  //登録
  _handleSubmit(String message) {
    _controller.clear();
    if(message!=""){
      FirebaseFirestore
      .instance
      .collection("ChatApp")
      .doc(email)
      .collection(widget.collection_id)
      .add({
        "email":email,
        "sent_text":message,
        "time":DateTime.now(),
      });
    }
    return;
  }
}