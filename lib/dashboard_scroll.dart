import 'package:flutter/material.dart';
import 'package:hos/outstanding_report/outingstang_report.dart';
import 'expense_report/expense_report.dart';
import 'file:///E:/ERS_Projects/hos/lib/sale_report/sales_report.dart';
import 'package:hos/purchase_report/purchase_report.dart';
import 'package:hos/stock_report/stock_report.dart';

class scroll extends StatefulWidget {
  @override
  _scrollState createState() => _scrollState();
}

class _scrollState extends State<scroll> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
        child:Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),

                  child: InkWell(
                    onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalesReport(),
                        ));},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Image.asset('assets/images/Sales-report.png',height: 60,width: 60,),
                          SizedBox(height: 10,),
                          Text('Sales', style: TextStyle(fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width:   50,
                  height:  20,
                ),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: InkWell(
                    onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseSalesReport(),
                        ));},
                    child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Image.asset('assets/images/onlineshopping.png',height: 60,width: 60,),
                        SizedBox(height: 10,),
                        Text('Purchase', style: TextStyle(fontSize: 15,),),
                      ],
                    ),
                  ),
                  ),

                ),
              ],
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: InkWell(
                    onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockReport(),
                        ));},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Image.asset('assets/images/blue_stock.png',height: 60,width: 60,),
                          SizedBox(height: 10,),
                          Text('Stock', style: TextStyle(fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width:   50,
                  height:  20,
                ),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: InkWell(
                    onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseReport(),));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Image.asset('assets/images/budget.png',height: 60,width: 60,),
                          SizedBox(height: 10,),
                          Text('Expences', style: TextStyle(fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),

                ),
              ],
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: InkWell(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => OutstandingReport(),));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Image.asset('assets/images/ledger.png',height: 60,width: 60,),
                          SizedBox(height: 10,),
                          Text('Outstandings', style: TextStyle(fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width:   50,
                  height:  20,
                ),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),

                  child: InkWell(
                    onTap: (){},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Image.asset('assets/images/accounting.png',height: 60,width: 60,),
                          SizedBox(height: 10,),
                          Text('Dashboard', style: TextStyle(fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
            ),
          ],
        ),

      ),
    );
  }
}
