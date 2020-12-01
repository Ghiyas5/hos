import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';


class ExpensesDetailList extends StatefulWidget {
  final String dateFrom,dateTo;

  ExpensesDetailList({this.dateFrom, this.dateTo});

  @override
  _ExpensesDetailListState createState() => _ExpensesDetailListState();
}

class _ExpensesDetailListState extends State<ExpensesDetailList> {
  String date_f, date_to;
  List detail = List()  ;
  List temp = List();
  // SalesData salesData;
  var isLoading = false;
  String  port,ip;

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
    await http.get('http://192.168.10.50:8081/api/Account/Expenses?Fromdate=$date_f&ToDate=$date_to');
    if (response.statusCode == 200) {
      Map jsonData = json.decode(response.body) ;
       List az = jsonData['expenseTotal'] ;
      List as = jsonData['expenseReport'];
      Toast.show(  as.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

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
    date_f = widget.dateFrom;
    date_to = widget.dateTo;

    // Toast.show( date_to+date_f+item_cod+cust_cod, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    _fetchData();


  }


  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        children: [
          Flexible(

            child: Container(
              height: 120,
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
          SizedBox(height:100, width:size.width,child: Text(detail.toString()),),
          Flexible(
            flex: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                  itemCount: temp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: orientation == Orientation.portrait?size.height*0.15:size.height*0.30,

                        width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(

                                 // mainAxisAlignment: MainAxisAlignment.start,
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(flex:1,child: SizedBox(child: Text((temp[index]['vcH_DCOA_CODE']),style: TextStyle(color: Colors.black),))),
                                          Flexible(flex:1,child: SizedBox(child: Text((temp[index]['acC_COA_DESC']),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.green),))),
                                         // SizedBox(width: 25,),
                                          Flexible(flex:1,child: SizedBox(child: Text((temp[index]['total']),style: TextStyle(color: Colors.amber),))),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(width: 20,),

                                  ],
                                ),
                                // Row(
                                //
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: <Widget>[
                                //     Flexible(
                                //       flex: 1,
                                //       child: Row(
                                //         children: <Widget>[
                                //           Flexible(flex:2,child: SizedBox(child: Text('Opening Qty'),)),
                                //           SizedBox(width: 25,),
                                //           Flexible(flex:1,child: SizedBox(child: Text((detail[index]['opN_QTY']),style: TextStyle(color: Colors.black),))),
                                //         ],
                                //       ),
                                //     ),
                                //     // SizedBox(width: 20,),
                                //     Flexible(
                                //       flex: 1,
                                //       child: Row(
                                //         children: <Widget>[
                                //           Flexible(flex:1,child: SizedBox(child: Text('Close Qty'),)),
                                //           SizedBox(width: 20,),
                                //           Expanded(flex:1,child: SizedBox(child: Text((detail[index]['closing_QTY']),style: TextStyle(color: Colors.black)))),
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // Row(
                                //
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: <Widget>[
                                //     Flexible(
                                //       flex: 1,
                                //       child: Row(
                                //         mainAxisAlignment:  MainAxisAlignment.start,
                                //         children: <Widget>[
                                //           Flexible(flex:1,child: SizedBox(child: Text('Location'),)),
                                //           SizedBox(width: 20,),
                                //           Flexible(flex:1,child: SizedBox(child: Text((detail[index]['loC_NAME']),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.green,)))),
                                //         ],
                                //       ),
                                //     ),
                                //     //  SizedBox(width: 20,),
                                //     Flexible(
                                //       flex: 1,
                                //       child: Row(
                                //         mainAxisAlignment:  MainAxisAlignment.start,
                                //         children: <Widget>[
                                //           Flexible(flex:2,child: SizedBox(child: Text('Product Unit'))),
                                //           SizedBox(width: 30,),
                                //           Flexible(flex:1,child: SizedBox(child: Text((detail[index]['iteM_BASE_UNIT']),style: TextStyle(color: Colors.amber,)))),
                                //           SizedBox(width: 0,),
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // )
                              ],
                            )
                            ,
                            // child: Text((detail[index]['gdN_DATE']), style: TextStyle(fontSize: 22.0),),
                          ),
                        ),
                      ),
                    );


                    // return ListTile(
                    //   contentPadding: EdgeInsets.all(10.0),
                    //   title: new Text(detail[index]['stat_Day']),
                    //
                    // );
                  }),
            ),
          ),
        ],
      ),


    );
  }
}
