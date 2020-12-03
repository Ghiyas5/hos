import 'package:hos/outstanding_report/PayableDetaillist.dart';
import 'package:hos/outstanding_report/outstanding_detaillist.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

class OutstandingReport extends StatefulWidget {
  @override
  _OutstandingReportState createState() => _OutstandingReportState();
}

class _OutstandingReportState extends State<OutstandingReport> {
  List detail = List()  ;
  List temp = List();
  Map<String,double> map2 = {};
  // SalesData salesData;
  var isLoading = false;
  String  port,ip;
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  Future<void> getFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    port = prefs.getString("port");
    ip = prefs.getString("ip_address");
    print('ip'+ ip + port);

  }
  _fetchData() async {

    setState(() {
      isLoading = true;
    });
    // 182.176.127.47:8082

    final response =
    await http.get('http://192.168.10.50:8081/api/account/LedgerBalance');
    if (response.statusCode == 200) {
      Map jsonData = json.decode(response.body) ;
      List az = jsonData['payableTotal'] ;
      List as = jsonData['receivableTotal'];

      map2 = Map.from( jsonData['payableTotal']);
      // as.forEach((customer) => map2[customer.name]);
      // print(map2);
      Toast.show(  map2.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      if(az.isEmpty){
        Toast.show( 'Data Not Found.', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else{
        for(int i = 0; i<az.length; i++){
          detail.add(as[i]);

        }
      }

      if(as.isEmpty){
        Toast.show( 'Data Not Found.', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else{
        for(int i = 0; i<as.length; i++){
          temp.add(as[i]);

        }
      }

      //  for (final name in jsonDat.length) {
      //    final value = jsonDat[name];
      //    print('$name,$value'); // prints entries like "AED,3.672940"
      //  }

      setState(() {

        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  void initState() {
    super.initState();
    getFromSP();
    // Toast.show( date_to+date_f+item_cod+cust_cod, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    _fetchData();


  }


  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: orientation == Orientation.portrait?size.height*0.13:size.height*0.26,
                  width:  size.width,
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
                            child:  Text('Detail Report',
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => PayableDetaillist(),));
                            },
                            child: Container(

                              height: orientation == Orientation.portrait?size.height*0.07:size.height*0.14,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(topLeft: const Radius.circular(50.0),bottomLeft: const Radius.circular(0.0)),
                              ),
                              child:  Center(
                                child: Text('Payable Report',
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox( child: Text('|',
                          style: TextStyle(color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),

                        ),),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){ Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OutstandingDetailList(),));
                            },
                            child: Container(
                              height: orientation == Orientation.portrait?size.height*0.07:size.height*0.14,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(topRight: const Radius.circular(50.0),bottomLeft: const Radius.circular(0.0)),
                              ),
                              child:  Center(
                                child: Text('Receiveable Report',
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
