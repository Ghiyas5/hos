import 'package:flutter/material.dart';
import 'package:hos/expense_report/empense_detaillist.dart';
import 'package:hos/model/sale_item_model.dart';
import 'package:hos/sale_report//detaillist.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:hos/sendvalesmodel/custreportvalue.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';



void main() => runApp(MaterialApp(
  home: ExpenseReport(),
));

class ExpenseReport extends StatefulWidget {
  @override
  _ExpenseReportState createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  final _ssKey = GlobalKey<ScaffoldState>();
  var abc;
  String d_from,d_to;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _ssKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(topLeft: const Radius.circular(0.0),bottomLeft: const Radius.circular(100.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            child:  Text('Stock Report',
                              style: TextStyle(color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),

                            ),

                          ),
                        ),

                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(height: 35,),
              Flexible(
                flex: 4,
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _fromDate(context),
                              child: Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child:Column(
                                  children: <Widget>[

                                    SizedBox(
                                      child: Text('Start Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white),),
                                    ),
                                    Center(
                                      child: Text(
                                        "${selectedFromDate.toLocal()}".split(' ')[0],
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: () =>_toDate(context),
                              child: Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child:Column(
                                  children: <Widget>[
                                    SizedBox(
                                      child: Text('End Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white),),
                                    ),
                                    Center(
                                      child: Text(
                                        "${selectedToDate.toLocal()}".split(' ')[0],
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40,),
                        Center(
                          child: Container(
                            width: 250,
                            height: 50,
                            child:   OutlineButton(
                              borderSide: BorderSide(color: Colors.green),
                              onPressed: () {
                                if(d_from != null && d_to != null){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context)=>ExpensesDetailList(
                                        dateFrom: d_from,
                                        dateTo: d_to,
                                    )));

                                }
                                else if(d_from == null && d_to == null){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context)=>ExpensesDetailList(dateFrom: " ",
                                    dateTo: " ",
                                     )));
                                }
                              },
                              child: Text('Generate Report',style: TextStyle(color: Colors.green),),
                            ),
                          ),


                        ),

                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _fromDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),

    );

    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedFromDate);
        d_from=  formattedDate;
      });
    Toast.show( d_from, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
  _toDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedToDate);
        d_to = formattedDate;
      });
    Toast.show( d_to, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

}