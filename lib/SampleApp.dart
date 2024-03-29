import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_learn_demo/strings.dart';

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SampleAppWidget(),
    );
  }
}

class SampleAppWidget extends StatefulWidget {
  @override
  State createState() {
    return SampleAppWidgetState();
  }
}

class SampleAppWidgetState extends State<SampleAppWidget> {
  var _widgets = List();

  @override
  void initState() {
    super.initState();

    loadData();
  }

//  loadData() async {
//    String dataURL = 'https://jsonplaceholder.typicode.com/posts';
//    http.Response response = await http.get(dataURL);
//    setState(() {
//      print("#########" + response.body);
//      _widgets = json.decode(response.body);
//      print("#########" + _widgets.length.toString());
//    });
//  }

  loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(sendPort, "https://jsonplaceholder.typicode.com/posts");

    setState(() {
      _widgets = msg;
    });

//
//    String dataURL = 'https://jsonplaceholder.typicode.com/posts';
//    http.Response response = await http.get(dataURL);
//    setState(() {
//      print("#########" + response.body);
//      _widgets = json.decode(response.body);
//      print("#########" + _widgets.length.toString());
//    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for(var msg in receivePort) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceive(SendPort sendPort, msg) {

    ReceivePort response = ReceivePort();
    sendPort.send([msg, response.sendPort]);
    return response.first;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample App'),
      ),
//      body: ListView.builder(
//        itemCount: _widgets.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Padding(
//            padding: EdgeInsets.all(10),
//            child: Text("Row $index ${_widgets[index]["title"]}"),
//          );
//        },
//      ),

      body: getBody(),
    );
  }

  showLoadingDialog() {
    return _widgets.length == 0;
  }

  getBody() {
    return showLoadingDialog() ? getProgressDialog() : getListView();
  }

  getProgressDialog() {
    print("#########" + "getProgressDialog");

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  getListView() {
    print("#########" + "getListView");
    return ListView.builder(
        itemCount: _widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: EdgeInsets.all(10),
//            child: Text("Row $position ${_widgets[position]["title"]}"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Row $position ${_widgets[position]["title"]}"),
                getImages(),
                Text(Strings.welcomeMessage)
              ],
            ),
          );
        });
  }

  getImages() {
    return Center(
      child: Image.asset(
        "images/lake.jpg",
        width: 20,
        height: 20,
      ),
    );
//    return Center(
//      child: Image(image: AssetImage("images/lake.jpg")),
//    );
  }
}
