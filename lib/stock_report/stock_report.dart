import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:hos/stock_report/stock_detail_list.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
  home: StockReport(),
));

class StockReport extends StatefulWidget {
  @override
  _StockReportState createState() => _StockReportState();
}

class _StockReportState extends State<StockReport> {
  String val,vall,p_code,c_code,d_from,d_to,item_cod,cust_cod;
  int selectItem_index,selectCust_index;
  String day_id;
  Map itemdata;
  List itemlist = List();

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull('http://192.168.10.50:8081/api/Account/Sale'),
        headers: {'Accept': 'application/json'} );
    Map<String, dynamic> map = json.decode(response.body);
    setState(() {
      itemlist = map['item'];

    });

  }

  @override
  void initState() {
    super.initState();
    getData();

  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(
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
            SizedBox(height: 25,),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      SizedBox(child: Text('Product',style: TextStyle(color: Colors.green),),),
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
                      SizedBox(height: 40,),
                      Center(
                        child: Container(
                          width: 250,
                          height: 50,
                          child:   OutlineButton(
                            borderSide: BorderSide(color: Colors.green),
                            onPressed: () {
                               if(
                                  item_cod == null){
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context)=>StockDetailList(
                                  itemCode:  " ",
                                   )));
                              }
                               else  if(
                               item_cod != null){
                                 Navigator.push(context, MaterialPageRoute(builder:
                                     (context)=>StockDetailList(
                                   itemCode:  item_cod,
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
    );
  }
}
