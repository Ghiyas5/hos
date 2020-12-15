import 'package:flutter/material.dart';
import 'package:hos/sale_report/sale_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

class Detail_List extends StatefulWidget {
  final String dateFrom,dateTo,itemCode,custCode;

  Detail_List({@required this.dateFrom,@required this.dateTo, this.itemCode, this.custCode});

  @override
  _Detail_ListState createState() => _Detail_ListState();
}

class _Detail_ListState extends State<Detail_List> {
  String date_f, date_to, item_cod, cust_cod;
  List detail = List()  ;
  List<SalesData> temp = List();
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
    await http.get('http://192.168.10.50:8081/api/Account/SalesSummeryReports?customer=$cust_cod&Fromdate=$date_f&ToDate=$date_to&ItemCode=$item_cod&CurrentPage=1&PageSize=100');
    if (response.statusCode == 200) {
      Map jsonData = json.decode(response.body) ;
      Map jsonDat = jsonData['sale'] ;
      List as = jsonDat['saleReport'];
     // detail  = jsonDat['saleReport'];
      if(as.isEmpty){
        Toast.show( 'Data Not Found.', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else{
        for(int i = 0; i<as.length; i++){
          detail.add(as[i]);

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
    item_cod = widget.itemCode;
    cust_cod = widget.custCode;
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
              flex: 1,
              child: Container(
                height: orientation == Orientation.portrait?size.height*0.14:size.height*0.28,
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
                          itemCount: detail.length,
                          itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(

                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              flex: 1,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(flex:1,child: SizedBox(child: Text('Date'),)),
                                                  SizedBox(width: 25,),
                                                  Flexible(flex:1,child: SizedBox(child: Text((detail[index]['gdN_DATE']),style: TextStyle(color: Colors.green),))),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(width: 20,),
                                            Flexible(
                                              flex: 1,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(flex:1,child: SizedBox(child: Text('Customer'),)),
                                                  SizedBox(width: 20,),
                                                  Expanded(flex:1,child: SizedBox(child: Text((detail[index]['cuS_Name']), overflow: TextOverflow.clip,maxLines: 3,))),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:  MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(flex:1,child: SizedBox(child: Text('Invoice No'),)),
                                                  SizedBox(width: 20,),
                                                  Flexible(flex:1,child: SizedBox(child: Text((detail[index]['gdN_CODE'])))),
                                                ],
                                              ),
                                            ),
                                            //  SizedBox(width: 20,),
                                            Flexible(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:  MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(flex:1,child: SizedBox(child: Text('Amount'))),
                                                  SizedBox(width: 30,),
                                                  Flexible(flex:1,child: SizedBox(child: Text((detail[index]['grand_Total']),style: TextStyle(color: Colors.amber,)))),
                                                  SizedBox(width: 0,),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                    ,
                                    // child: Text((detail[index]['gdN_DATE']), style: TextStyle(fontSize: 22.0),),
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

class SalesData{
  sale  sallist;
  List<saleGrandTotal> grandlist;

  SalesData(this.sallist, this.grandlist);

  SalesData.fromJson(Map<String, dynamic> json) {


    if (json['saleGrandTotal'] != null) {
      grandlist = new List<saleGrandTotal>();
      json['saleGrandTotal'].forEach((v) {
        grandlist.add(new saleGrandTotal.fromJson(v));
      });
    }

     sallist = json['sallist'] != null ? new sale.fromJson(json['sallist']) : null;

  }
}
class sale {
  List<saleReport>  salelist;
  pagination paginatlist;



  sale({this.salelist,this.paginatlist});

  sale.fromJson(Map<String, dynamic> json) {
    if (json['saleReport'] != null) {
      salelist = new List<saleReport>();
      json['saleReport'].forEach((v) {
        salelist.add(new saleReport.fromJson(v));
      });
    }

    paginatlist = json['ad'] != null ? new pagination.fromJson(json['paginatlist']) : null;

  }
}
class pagination{
  String currentPage,count,pageSize,totalPages,indexOne,indexTwo,showPrevious,showFirsr,showLast;

  pagination({
      this.currentPage, this.count, this.pageSize, this.totalPages, this.indexOne, this.indexTwo, this.showPrevious, this.showFirsr, this.showLast});

  pagination.fromJson(Map<String, dynamic> json){
    currentPage = json['currentPage'];
    count = json['count'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    indexOne = json['indexOne'];
    indexTwo = json['indexTwo'];
    showPrevious = json['showPrevious'];
    showFirsr = json['showFirsr'];
    showLast = json['showLast'];
  }


}
class saleReport{
  String gdN_DATE,gdN_CUS_CODE,cuS_Name,gdN_ITEM_CODE,iteM_Name,gdN_CODE,grand_Total;

  saleReport({this.gdN_DATE, this.gdN_CUS_CODE, this.cuS_Name,
      this.gdN_ITEM_CODE, this.iteM_Name, this.gdN_CODE, this.grand_Total});

  saleReport.fromJson(Map<String, dynamic> json){
    gdN_DATE = json['gdN_DATE'];
    gdN_CUS_CODE = json['gdN_CUS_CODE'];
    cuS_Name = json['cuS_Name'];
    gdN_ITEM_CODE = json['gdN_ITEM_CODE'];
    iteM_Name = json['iteM_Name'];
    gdN_CODE = json['gdN_CODE'];
    grand_Total = json['grand_Total'];
  }
}
class saleGrandTotal{
  String grandtotal;

  saleGrandTotal({this.grandtotal});

  saleGrandTotal.fromJson(Map<String, dynamic> json){
    grandtotal = json['grandtotal'];
  }
}
