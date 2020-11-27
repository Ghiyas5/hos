import 'package:flutter/material.dart';
import 'package:hos/purchase_report/purchase_detaillist.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
  home: PurchaseQuickReport(),
));

class PurchaseQuickReport extends StatefulWidget {
  @override
  _PurchaseQuickReportState createState() => _PurchaseQuickReportState();
}

class _PurchaseQuickReportState extends State<PurchaseQuickReport> {
  String val,vall,p_code,c_code,d_from,d_to,item_cod,cust_cod;
  int selectItem_index,selectCust_index;
  String day_id;
  Map itemdata;
  List itemlist = List();
  List cust_list = List();
  List<DropdownMenuItem> _serviceItems = [];

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull('http://192.168.10.50:8081/api/Account/Purchase'),
        headers: {'Accept': 'application/json'} );
    Map<String, dynamic> map = json.decode(response.body);
    setState(() {
      itemlist = map['item'];
      cust_list = map['supplier'];
    });

  }

  @override
  void initState() {
    super.initState();
    getData();

    _serviceItems.add(DropdownMenuItem(
      key: Key("0"),
      child: Text("Today report"),
      value: "0",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("1"),
      child: Text("1 week report"),
      value: "1",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("2"),
      child: Text("2 week report"),
      value: "2",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("3"),
      child: Text("3 week report"),
      value: "3",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("4"),
      child: Text("4 week report"),
      value: "4",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("5"),
      child: Text("5 week report"),
      value: "5",
    ));
    _serviceItems.add(DropdownMenuItem(
      key: Key("6"),
      child: Text("6 week report"),
      value: "6",
    ));
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(child: Text('Quick Action',style: TextStyle(color: Colors.green),),),
              SearchableDropdown(
                dialogBox: true,
                isExpanded: true,

                onChanged: (String value) {
                  _serviceItems.map((e){
                    if(e == value){
                      setState(() {
                        day_id = value;
                        selectItem_index = _serviceItems.indexOf(e);

                      });
                    }

                  });
                  Toast.show( value, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  DateTime today = new DateTime.now();
                  DateFormat formatter = DateFormat('yyyy-MM-dd');
                  String formatteddateNow = formatter.format(today);
                  DateTime datefrom = today.subtract(new Duration(days: 7*(int.parse(value))));
                  String formatteddateFrom = formatter.format(datefrom);
                  Toast.show( formatteddateFrom, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                  d_from = formatteddateNow;
                  d_to = formatteddateFrom;
                },

                value: day_id,
                //required: false,
                hint: Text('Today Report'),
                items: _serviceItems,
              ),

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
              SizedBox(height: 20,),
              SizedBox(child: Text('Supplier',style: TextStyle(color: Colors.green),),),
              SearchableDropdown(

                isExpanded: true,
                isCaseSensitiveSearch: false,
                searchHint: new Text(
                  'Select Supplier ',
                  style: new TextStyle(fontSize: 20),
                ),
                value: vall,
                onChanged: (String value) {
                  cust_list.map((e){
                    if(e['suP_NAME'] == value){
                      setState(() {
                        vall = value;

                      });
                    }
                  });
                  cust_cod = value;
                  Toast.show(  cust_cod, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                },
                // required: false,
                hint:Text('Choose Supplier'),
                items: cust_list.map((list) {
                  return new DropdownMenuItem(
                    child:  SizedBox(
                        width: 250,
                        child: Text(list['suP_NAME'])),
                    value: list['suP_CODE'].toString(),
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

                        Toast.show("Please Select Week!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                      }
                      else if(d_from != null && d_to != null &&
                          item_cod == null && cust_cod == null){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Purchase_Detail_Lisr(dateFrom: d_from,
                          dateTo: d_to,
                          itemCode:  " ",
                          custCode: " ",)));
                      }
                      else if(d_from != null && d_to != null
                          && item_cod != null && cust_cod != null){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Purchase_Detail_Lisr(dateFrom: d_from,
                          dateTo: d_to,
                          itemCode: item_cod,
                          custCode: cust_cod,)));

                      }
                      else if(d_from != null && d_to != null &&
                          item_cod != null && cust_cod == null){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Purchase_Detail_Lisr(dateFrom: d_from,
                          dateTo: d_to,
                          itemCode: item_cod,
                          custCode: " ",)));
                      }
                      else if(d_from != null && d_to != null &&
                          item_cod == null && cust_cod != null){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Purchase_Detail_Lisr(dateFrom: d_from,
                          dateTo: d_to,
                          itemCode:  " ",
                          custCode: cust_cod,)));
                      }

                    },
                    child: Text('Generate Report',style: TextStyle(color: Colors.green),),
                  ),
                ),
              ),

            ]),
      ),
    );
  }
}
