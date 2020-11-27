
import 'package:flutter/material.dart';
import 'package:hos/model/sale_item_model.dart';
import 'package:hos/sale_report/detaillist.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';



class MyApps extends StatefulWidget {
  State createState() => new MyAppState();
  final String dateFrom,dateTo,itemCode,custCode;

  MyApps({@required this.dateFrom,@required this.dateTo, this.itemCode, this.custCode});
}

class MyAppState extends State<MyApps> {
  String  port,ip;
  String date_f, date_to, item_cod, cust_cod;
  var detailList = [];
  List  temp;
  List<SalesData> detail = List() ;
  SalesData salesData;
  String acv;

  Future<void> getFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    port = prefs.getString("port");
    ip = prefs.getString("ip_address");
    print('ip'+ ip + port);


  }

  Future<String> getData() async {
    var respons = await http.get(
        Uri.encodeFull('http://192.168.10.50:8081/api/Account/SalesInvoiceDailyGraph?supplier=&Fromdate=2020-01-01&ToDate=2020-09-25'),
        headers: {'Accept': 'application/json'});

    Map jsonData = json.decode(respons.body);
   // Map<String, dynamic> map = json.decode(response.body);
    //print(jsonData['saleDailydTotal']);

      temp = jsonData['saleDailydTotal'];



    for (int i=0; i< temp.length; i++) {
        salesData = SalesData(stat_Day: temp[i]['stat_Day'].toString(),
          grandtotal: temp[i]['grandtotal'].toString());
          detail.add(salesData);
        Toast.show( detail[i].grandtotal, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    }

    // for(int i = 0; i<detail.length;i++){
    //
    // }
    //
    //   print(detail);


  }




    @override
    void initState() {
    super.initState();
    getFromSP();
      date_f = widget.dateFrom;
      date_to = widget.dateTo;
      item_cod = widget.itemCode;
      cust_cod = widget.custCode;
    getData();


    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
         child: Stack(

           children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20.0),),

                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        child: Text('Detail Report',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=>Detail_List(dateFrom: date_f,
                            dateTo: date_to,
                            itemCode: item_cod,
                            custCode: cust_cod,)));

                        },
                      ),
                    ),
                  ),
                ),

             Align(
               alignment: Alignment.center,

               child: Text('abc'),
             )


           ],

         ),

        ),
        );

    }

}
class SalesData {

   String stat_Day;
   String grandtotal;

  SalesData({this.stat_Day, this.grandtotal});


  SalesData.fromJson(Map<String, dynamic> json) {
    stat_Day = json['stat_Day'];
    grandtotal = json['grandtotal'];

  }


}