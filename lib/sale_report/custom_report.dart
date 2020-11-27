import 'package:flutter/material.dart';
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
  home: CustomReport(),
));
class CustomReport extends StatefulWidget {
  @override
  _CustomReportState createState() => _CustomReportState();
}

class _CustomReportState extends State<CustomReport> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  final _ssKey = GlobalKey<ScaffoldState>();
  var abc;
  String val,vall,p_code,c_code,d_from,d_to,item_cod,cust_cod;
  int selectItem_index,selectCust_index;
  Map itemdata;
  List itemlist = List();
  List cust_list = List();
  List namelist = List();

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull('http://192.168.10.50:8081/api/Account/Sale'),
        headers: {'Accept': 'application/json'} );
    Map<String, dynamic> map = json.decode(response.body);
    setState(() {
      itemlist = map['item'];
      cust_list = map['customer'];
    });

  }

  @override
  void initState() {
    super.initState();
    getData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _ssKey,
      body: Container(
        padding: EdgeInsets.all(15.0),
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
                SizedBox(height: 20,),
                SizedBox(child: Text(
                  'Product', style: TextStyle(color: Colors.green),),),

                SearchableDropdown(
                  isExpanded: true,
                  isCaseSensitiveSearch: false,
                  searchHint: new Text(
                    'Select Product ',
                    style: new TextStyle(fontSize: 20),
                  ),
                  value: val,
                  onChanged: (String value) {

                    itemlist.map((e){
                      if(e['iteM_NAME'] == value){
                        setState(() {
                          val = value;
                          selectItem_index = itemlist.indexOf(e);
                        });
                      }
                    });

                    print(val);
                    item_cod = value;
                    Toast.show( item_cod, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  },
                 // required: false,
                  hint:Text('Choose Product'),
                  items: itemlist.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['iteM_NAME']),
                      value: item['iteM_CODE'].toString(),
                    );
                  }).toList(),

                ),
                SizedBox(height: 20,),
                SizedBox(child: Text(
                  'Customer', style: TextStyle(color: Colors.green),),),
                SearchableDropdown(

                  isExpanded: true,
                  isCaseSensitiveSearch: false,
                  searchHint: new Text(
                    'Select Customer ',
                    style: new TextStyle(fontSize: 20),
                  ),
                  value: vall,
                  onChanged: (String value) {
                    cust_list.map((e){
                      if(e['cuS_NAME'] == value){
                        setState(() {
                          vall = value;

                        });
                      }
                    });
                    cust_cod = value;
                    Toast.show(  cust_cod, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  },
                  // required: false,
                  hint:Text('Choose Customer'),
                  items: cust_list.map((list) {
                    return new DropdownMenuItem(
                      child:  SizedBox(
                        width: 250,
                          child: Text(list['cuS_NAME'])),
                      value: list['cuS_CODE'].toString(),
                    );
                  }).toList(),

                ),
                SizedBox(height: 40,),
                Center(
                  child: Container(
                    width: 250,
                    height: 50,
                    child:   OutlineButton(
                      borderSide: BorderSide(color: Colors.green),
                       onPressed: () {

                         if(d_from == null && d_to == null &&
                             item_cod == null && cust_cod == null){

                           Toast.show("Please select Date from & Date to!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                         }
                         else if(d_from != null && d_to != null
                             && item_cod != null && cust_cod != null){
                           Navigator.push(context, MaterialPageRoute(builder:
                               (context)=>Detail_List(dateFrom: d_from,
                             dateTo: d_to,
                             itemCode: item_cod,
                             custCode: cust_cod,)));

                         }
                         else if(d_from != null && d_to != null &&
                             item_cod != null && cust_cod == null){
                           Navigator.push(context, MaterialPageRoute(builder:
                               (context)=>Detail_List(dateFrom: d_from,
                             dateTo: d_to,
                             itemCode: item_cod,
                             custCode: " ",)));
                         }

                         else if(d_from != null && d_to != null &&
                             item_cod == null && cust_cod != null){
                           Navigator.push(context, MaterialPageRoute(builder:
                               (context)=>Detail_List(dateFrom: d_from,
                             dateTo: d_to,
                             itemCode:  " ",
                             custCode: cust_cod,)));
                         }
                         else if(d_from != null && d_to != null &&
                             item_cod == null && cust_cod == null){
                           Navigator.push(context, MaterialPageRoute(builder:
                               (context)=>Detail_List(dateFrom: d_from,
                             dateTo:  d_to,
                             itemCode:  " ",
                             custCode: " ",)));

                         }

                       },
                      child: Text('Generate Report',style: TextStyle(color: Colors.green),),
                    ),
                  ),


                ),

              ]),
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

  runsn() {
    _ssKey.currentState.showSnackBar(new SnackBar(content: new Text(val) ));
  }
}
