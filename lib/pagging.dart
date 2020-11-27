
import 'package:flutter/material.dart';

void main() => runApp(new MyAppss());

class MyAppss extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int present = 0;
  int perPage = 15;

  final originalItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();


  @override
  void initState() {
    super.initState();
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: (present <= originalItems.length) ? items.length + 1 : items.length,
        itemBuilder: (context, index) {
          return (index == items.length ) ?
          Container(
            color: Colors.greenAccent,
            child: FlatButton(
              child: Text("Load More"),
              onPressed: () {
                setState(() {
                  if((present + perPage )> originalItems.length) {
                    items.addAll(
                        originalItems.getRange(present, originalItems.length));
                  } else {
                    items.addAll(
                        originalItems.getRange(present, present + perPage));
                  }
                  present = present + perPage;
                });
              },
            ),
          )
              :
          ListTile(
            title: Text('${items[index]}'),
          );
        },
      ),
    );
  }
}
