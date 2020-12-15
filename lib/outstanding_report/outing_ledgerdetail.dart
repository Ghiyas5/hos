import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:graphview/GraphView.dart';

import '../pdfview.dart';


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
  String ac;
  final pdf = pw.Document();
  final _sKey = GlobalKey<ScaffoldState>();

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
          bal = detail[i].balance == ''?'null':detail[i].balance;
          crd = detail[i].ldG_CREDIT== ''?'null':detail[i].ldG_CREDIT;
          deb = detail[i].ldG_DEBIT== ''?'null':detail[i].ldG_DEBIT;
           ac = bal;
         // Toast.show(  bal, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

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
    getFromSP();
    ac_no = widget.acc_no;
    _fetchData();
    super.initState();


     //Toast.show(  '$bal', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    // final Node node1 = Node(SizedBox(child: Text('Rs: $ac',style: TextStyle(color: Colors.amber),),));
    // final Node node2 = Node(getNodeText());
    // final Node node3 = Node(getNodeText());
    //
    // graph.addEdge(node1, node2);
    // graph.addEdge(node1, node3);
    //
    // builder
    //   ..siblingSeparation = (70)
    //   ..levelSeparation = (20)
    //   ..subtreeSeparation = (20)
    //   ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  // Widget getNodeText() {
  //
  //   return Container(
  //     child: Column(
  //       children: [
  //         SizedBox(child: Text('Net Balance',style: TextStyle(color: Colors.black),)),
  //         SizedBox(height: 5,),
  //         SizedBox(child: Text('$bal',style: TextStyle(color: Colors.amber),),),
  //       ],
  //     ),
  //   );
  //   // return Container(
  //   //     padding: EdgeInsets.all(16),
  //   //     decoration: BoxDecoration(
  //   //       borderRadius: BorderRadius.circular(4),
  //   //       boxShadow: [
  //   //         BoxShadow(color: Colors.blue[100], spreadRadius: 1),
  //   //       ],
  //   //     ),
  //   //     child: Text('abc'));
  // }
  // final Graph graph = Graph();
  // BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  writeonpdf(){
    pdf.addPage(
      pw.MultiPage(
        //pageFormat: PdfPageFormat.a5,
        //margin: pw.EdgeInsets.all(32),
        build: (pw.Context context){
          return<pw.Widget>[

            pw. Flexible(

              flex: 1,   //orientation == Orientation.portrait?1:3,
              child: pw.Container(
                height: 100 ,// orientation == Orientation.portrait?size.height*0.14:size.height*0.28,
                width:   20,
                decoration: pw.BoxDecoration(
                  color: PdfColors.green,
                 // borderRadius: pw.BorderRadius.only(topLeft: const Radius.circular(0.0),bottomLeft: const Radius.circular(100.0)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: <pw.Widget>[
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12.0),
                      child: pw.SizedBox(
                        child:  pw.Text('Ledger Report',
                          style: pw.TextStyle(color: PdfColors.white,
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                          ),

                        ),

                      ),
                    ),

                  ],
                ),

              ),
            ),
          ];
        },
      )
    );
  }
  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
    Toast.show( 'Data Save.', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

  }


  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
         key: _sKey,
      body: Column(
        children: [
          Flexible(

            flex:  orientation == Orientation.portrait?1:3,
            child: Container(
              height: orientation == Orientation.portrait?size.height*0.14:size.height*0.28,
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


              // GraphView(
              //
              //   graph: graph,
              //   algorithm: BuchheimWalkerAlgorithm(builder,null),
              // ),

              SizedBox(height: 15,),
              SizedBox(child: Text('Net Balance',style: TextStyle(color: Colors.black),)),
              SizedBox(height: 5,),
              SizedBox(child: Text('Rs: $bal',style: TextStyle(color: Colors.amber),),),

              SizedBox(child: Text('______________|______________',style: TextStyle(color: Colors.black,fontSize: orientation == Orientation.portrait?14:26,),),),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: orientation == Orientation.portrait?14:20,width:orientation == Orientation.portrait?1:2,child: Container(decoration: BoxDecoration(color: Colors.black),),),
                  SizedBox(height: orientation == Orientation.portrait?14:20,width:orientation == Orientation.portrait?1:2,child: Container(decoration: BoxDecoration(color: Colors.black),),),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(child: Text('Debit',style: TextStyle(color: Colors.black),)),
                  SizedBox(child: Text('Credit',style: TextStyle(color: Colors.black),)),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [

                  SizedBox(child: Text('Rs: $deb',style: TextStyle(color: Colors.green),)),
                  SizedBox(child: Text('Rs: $crd',style: TextStyle(color: Colors.red),)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              Flexible(

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
                    return Container(
                      height: orientation == Orientation.portrait?size.height*0.15:size.height*0.30,

                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['date']==''?'null':temp[index]['date']),style: TextStyle(color: Colors.amber),)))),
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['chQ_NO']==''?'null':temp[index]['chQ_NO']),overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(color: Colors.black,),)))),
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['debit']== ''?'null':temp[index]['debit']), style: TextStyle(color: Colors.green),)))),
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['credit']== ''?'null':temp[index]['credit']), style: TextStyle(color: Colors.red),)))),
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['balance']== ''?'null':temp[index]['balance']), style: TextStyle(color: Colors.orange),)))),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text('Vch Code', style: TextStyle(color: Colors.black),)))),
                                Flexible(flex:2,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['voucheR_CODE']== ''?'null':temp[index]['voucheR_CODE']), style: TextStyle(color: Colors.grey),)))),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(flex:1,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text('Remarks', style: TextStyle(color: Colors.black),)))),
                                Flexible(flex:2,child: SizedBox(child: FittedBox(fit:BoxFit.fitWidth,child: Text((temp[index]['vcH_NARR']== ''?'null':temp[index]['vcH_NARR']), style: TextStyle(color: Colors.grey),)))),

                              ],
                            )

                          ],
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

          FloatingActionButton(

            onPressed: ()async{
              writeonpdf();
              await savePdf();

              Directory documentDirectory = await getApplicationDocumentsDirectory();

              String documentPath = documentDirectory.path;

              String fullPath = "$documentPath/example.pdf";

              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(path: fullPath,)
              ));

            },
            child: Icon(Icons.save),
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
