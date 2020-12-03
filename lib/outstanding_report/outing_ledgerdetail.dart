import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

class OutingstandingLedger extends StatefulWidget {
  String acc_no;


  OutingstandingLedger({this.acc_no});

  @override
  _OutingstandingLedgerState createState() => _OutingstandingLedgerState();
}

class _OutingstandingLedgerState extends State<OutingstandingLedger> {
  String ac_no;
  List<NetBalance> detail = List()  ;
  String bal = null; String crd = null; String deb = null;
  NetBalance netBalance;
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
    await http.get('http://192.168.10.50:8081/api/account/Ledger?Acc_Code=$ac_no');
    if (response.statusCode == 200) {
      Map jsonData = json.decode(response.body) ;
      List az = jsonData['netBalance'] ;
      List as = jsonData['ledgerBalance'];
     // Toast.show(  as.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      if(az.isEmpty){
        Toast.show( 'Data Not Found.', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else{
        for(int i = 0; i<az.length; i++){
          netBalance = NetBalance(ldG_CREDIT: az[i]['ldG_CREDIT'].toString(),
              ldG_DEBIT: az[i]['ldG_DEBIT'].toString(),balance: az[i]['balance'].toString());
          detail.add(netBalance);
          bal = detail[i].balance;
          crd = detail[i].ldG_CREDIT;
          deb = detail[i].ldG_DEBIT;

          Toast.show(  detail[i].ldG_CREDIT, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

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
    ac_no = widget.acc_no;

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
                        child:  Text('Ledger Report',
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

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              SizedBox(child: Text('Net Balance',style: TextStyle(color: Colors.black),)),
              SizedBox(height: 5,),
              SizedBox(child: Text(bal,style: TextStyle(color: Colors.amber),),),

              SizedBox(child: Text('_____________|_____________',style: TextStyle(color: Colors.black),),),
              SizedBox(height: 20,child: Container(decoration: BoxDecoration(color: Colors.black),),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SizedBox(child: Text(deb,style: TextStyle(color: Colors.green),),),
                  //SizedBox(child: Text(crd,style: TextStyle(color: Colors.red),),),
                ],
              ),

            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Date'),style: TextStyle(color: Colors.black),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Chq No'),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.black,),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Debit'), style: TextStyle(color: Colors.black),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Credit'), style: TextStyle(color: Colors.black),)))),
                    Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text(('Balance'), style: TextStyle(color: Colors.black),)))),
                    // SizedBox(width: 25,),


                  ],
                ),
              ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['date']),style: TextStyle(color: Colors.amber),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['chQ_NO']==''?'null':temp[index]['chQ_NO']),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.black,),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['debit']), style: TextStyle(color: Colors.green),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['credit']), style: TextStyle(color: Colors.red),)))),
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['balance']), style: TextStyle(color: Colors.orange),)))),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text('Vch Code', style: TextStyle(color: Colors.black),)))),
                                  Flexible(flex:2,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['voucheR_CODE']), style: TextStyle(color: Colors.grey),)))),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text('Remarks', style: TextStyle(color: Colors.black),)))),
                                  Flexible(flex:2,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['vcH_NARR']), style: TextStyle(color: Colors.grey),)))),

                                ],
                              )

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
class NetBalance{
  String ldG_DEBIT,ldG_CREDIT,balance;

  NetBalance({this.ldG_DEBIT, this.ldG_CREDIT, this.balance});

  factory NetBalance.fromJson(Map<String,dynamic> json){
    return NetBalance(
      ldG_DEBIT : json['ldG_DEBIT'],
      ldG_CREDIT : json['ldG_CREDIT'],
      balance : json['balance'],
    );
  }
}
