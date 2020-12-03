import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

import 'outing_ledgerdetail.dart';

class PayableDetaillist extends StatefulWidget {
  @override
  _PayableDetaillistState createState() => _PayableDetaillistState();
}

class _PayableDetaillistState extends State<PayableDetaillist> {

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
      await http.get('http://192.168.10.50:8081/api/Account/Payable');
      if (response.statusCode == 200) {
        Map jsonData = json.decode(response.body) ;
        List az = jsonData['totalBal'] ;
        List as = jsonData['payableReport'];
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
                        child:  Text('Payable Detail Report',
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
          SizedBox(height: 15,),
          Row(

            // mainAxisAlignment: MainAxisAlignment.start,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Account'),style: TextStyle(color: Colors.amber),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Name'),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.black,),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Balance'), style: TextStyle(color: Colors.green),)))),
                    // SizedBox(width: 25,),


                  ],
                ),
              ),
              // SizedBox(width: 20,),

            ],
          ),
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
                    return GestureDetector(

                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutingstandingLedger(
                        acc_no:  (temp[index]['ldG_AC_CODE']),
                      ),));
                    },
                      child: Container(
                        height: orientation == Orientation.portrait?size.height*0.15:size.height*0.30,

                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['ldG_AC_CODE']),style: TextStyle(color: Colors.amber),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['suP_NAME']),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.black,),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['balance']), style: TextStyle(color: Colors.green),)))),

                                ],
                              ),

                            ],
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
