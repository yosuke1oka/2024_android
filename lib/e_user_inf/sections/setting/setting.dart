import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Scaffold(

      appBar: AppBar(
        title: Text("設定"),
        centerTitle: true,
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        
      ),
    
    ));
  }
}