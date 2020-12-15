import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:get/get.dart';
import 'package:hos/controler/ib_config_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'login/login.dart';


void main() => runApp(MaterialApp(
  home: ip_config(),
));

class ip_config extends StatefulWidget {
  @override
  _ip_configState createState() => _ip_configState();
}

class _ip_configState extends State<ip_config>  with TickerProviderStateMixin{
  TextEditingController  ip_TextController = TextEditingController();
  TextEditingController port_TextController = TextEditingController();
  final formkey = GlobalKey <FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getFromSP();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      key: _scaffoldKey,

      body:SingleChildScrollView(
        child:  Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
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
                          child:  Text('Configuration',
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
              SizedBox(height: 10.0),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 100.0,
                              child: Image.asset(
                                "assets/images/hos_logo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  child: Text('HOUSE OF SOLUTIONS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text('A DIGITAL HUT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 45.0),
                            Form(
                              key: formkey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: ip_TextController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      labelText: 'IP Address',
                                      labelStyle: TextStyle(
                                        color:  Colors.green,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      ),
                                      border:  OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      ),
                                    ),
                                    validator: (value)=>value.trim().isEmpty? 'IP Address Require':null,
                                  ),
                                  SizedBox(height: 25.0),
                                  TextFormField(
                                    controller: port_TextController,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      labelText: 'Port #',
                                      labelStyle: TextStyle(
                                        color:  Colors.green,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      ),
                                      border:  OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      ),
                                    ),
                                    validator: (value)=> value.isEmpty? "Port # Required" : null,
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      AnimatedButton(
                                        child: Text(
                                          'Configure',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        width: 130,
                                        color: Colors.green,
                                        onPressed: () async {
                                          if(formkey.currentState.validate()){

                                            saveToSP();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => login(),
                                                ));

                                          }
                                        },
                                        enabled: true,
                                        shadowDegree: ShadowDegree.light,
                                        duration: 400,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            // emailField,

                            SizedBox(
                              height: 25.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> saveToSP() async {
    String ip_address = ip_TextController.text;
    String port = port_TextController.text;
    print('ip'+ ip_address + port);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip_address', ip_address);
    prefs.setString('port', port);

  }
  Future<void> getFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String port = prefs.getString("port");
   String  ip = prefs.getString("ip_address");
    print('ip'+ ip + port);

    ip_TextController.text = ip;
    port_TextController.text = port;



  }
}







