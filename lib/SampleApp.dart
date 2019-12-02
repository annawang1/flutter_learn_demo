import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

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

  loadData() async {
    String dataURL = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.get(dataURL);
    setState(() {
      print("#########" + response.body);
      _widgets = json.decode(response.body);
      print("#########" + _widgets.length.toString());
    });
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
            child: Text("Row $position ${_widgets[position]["title"]}"),
          );
        });
  }
}
