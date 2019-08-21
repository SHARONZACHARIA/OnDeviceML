import 'package:flutter/material.dart';
import 'decodejson.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  static const platform = const MethodChannel('ondeviceML');

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController texts = new TextEditingController();
  List<int> inp = List();
  bool offensive = false;
  Color offensive_color = Colors.black;

  @override
  Widget build(BuildContext context) {
 
  // Here we initialize the class to convert text to amtrix in dart

    Tokenize ondevice = Tokenize(1000, 'assets/devive_json.json');

    return new MaterialApp(
      theme: ThemeData(
        primaryColor:Colors.purple
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text Classification"),
        ),
        body: Center(
          child: Container(
            child: Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (text) {
                    if(text=="")
                    {
                      offensive_color = Colors.black;
                      setState(() {
                        
                      });
                    }
                    },
                    style: TextStyle(color: offensive_color,fontSize:18),
                    maxLines: 12,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: texts,
                  ),
                ),
                Container(
                  width: 150,
                  
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.purple,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // CircularProgressIndicator(
                        //   valueColor:AlwaysStoppedAnimation<Color>(Colors.green),
                        //   backgroundColor:Colors.white,
                        // ),
                        Icon(Icons.text_fields),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Analyse Text"),
                      ],
                    ),
                    onPressed: () {
                      ondevice.getTokenized(texts.text).then((value) {
                        inp = value;
                        print(inp);
                      }).then((_) {
                        _getPredictData().then((data) {
                          setState(() {});
                        });
                      });
                    },
                  ),
                ),
               
              ],
            )),
          ),
        ),
      ),
    );
  }

  // method that communicate with java code through platform specific channel

  Future<void> _getPredictData() async {
    try {
      final String result =
          await Home.platform.invokeMethod('predictData', {"arg": inp});
      if (result == "1") {
        offensive_color = Colors.red;
      } else
        offensive_color = Colors.green;
    
    } on PlatformException catch (e) {
     
      print(e.message);
    }
  }
}
