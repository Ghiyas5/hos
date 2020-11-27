import 'package:flutter/material.dart';
import 'package:hos/sale_report//custom_report.dart';
import 'package:hos/sale_report//quick_report.dart';


void main() => runApp(MaterialApp(
  home: SalesReport(),
));

class SalesReport extends StatefulWidget {
  @override
  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Sales Report',
        style: TextStyle(
           color: Colors.white,
           fontSize: 22,
           fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                 children: <Widget>[
                 SizedBox(height: 30,),
                   _Bar(onPressed: onPressed, selected: selected,),
                   SizedBox(height: 30,),

                   Container(
                     height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: selected == 0?QuickReport():CustomReport(),
                   ),
            ],
        )

            ),

          ],
        ),
      ),
    );
  }
 void onPressed(int index) {
   setState(() {
     selected = selected == index ? null : index;
   });
 }
}
class _Bar extends StatelessWidget {
  const _Bar({
    Key key,
    this.onPressed,
    this.selected,
  }) : super(key: key);

  final void Function(int selectedIndex) onPressed;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Flexible(flex:1,child: _button("Quick Report", 0)),
            Flexible(flex:1,child: __button("Custom Report", 1)),

          ],
        ),
      ),
    );
  }

  Widget _button(String text, int index) {
    return GestureDetector(
      onTap: () => onPressed(index),
      child: Container(
        decoration: BoxDecoration(
          color: selected == index ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.only(topLeft: const Radius.circular(40.0),bottomLeft: const Radius.circular(40.0)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
          color: Colors.white),),
        ),
      ),
    );
  }

  Widget __button(String text, int index) {
    return GestureDetector(
      onTap: () => onPressed(index),
      child: Container(
        decoration: BoxDecoration(
          color: selected == index ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.only(topRight: const Radius.circular(40.0),bottomRight: const Radius.circular(40.0)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                color: Colors.white),),
        ),
      ),
    );
  }
}

