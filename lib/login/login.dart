import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flippo_navigation/flippo_navigation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hos/controler/login_controller.dart';
import 'package:hos/ip_config.dart';
import 'package:dio/dio.dart';
import '../dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() => runApp(MaterialApp(

  home: login(),
));
class login extends StatefulWidget {



  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> with TickerProviderStateMixin  {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _sKey = GlobalKey<ScaffoldState>();
  String  port,ip;


  @override
  void initState() {
    getFromSP();
  }
  // AnimationController controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   controller =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  // }

  final Dio _dio = Dio();

    Future<bool> loginWithCredentials(email,password) async{
      try{
            showLoaderDialog(context);
        Response response = await _dio.post('http://'+ip+':'+port+'/api/account/login?email=$email&password=$password');
        if(response.data == 'success'){
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ));
          return true;
        } else {
          return false;
        }
      } catch(error){
        printError(info: error.toString());
        return null;
      }
    }



  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    FocusNode myFocusNode = new FocusNode();
    return  Scaffold(
      key: _sKey,
      // controller: controller,
      // mask:  Scaffold(
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
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
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          child:  Text('Login Credentials',
                            style: TextStyle(color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            ),

                          ),

                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.person_add,
                            size: 35,
                            color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                            // emailField,
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller:  emailTextController,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
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
                                    validator: (value) =>
                                    value.trim().isEmpty ? 'Email required' : null,
                                  ),
                                  SizedBox(height: 25.0),
                                  TextFormField(
                                    controller:  passwordTextController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
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
                                    validator: (value) =>
                                    value.trim().isEmpty ? 'Password required' : null,
                                    style: GoogleFonts.exo2(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () => {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ip_config())),
                                      },
                                      child: SizedBox(
                                        child: Text('IP Configure', style: TextStyle(color: Colors.green, fontSize: 18),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      AnimatedButton(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width*0.4,
                                        color: Colors.green,
                                        onPressed: () {
                                          if(ip.isEmpty && port.isEmpty){
                                            _sKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Go to IP Configure") ));
                                          }
                                          else if (_formKey.currentState.validate()) {

                                             loginWithCredentials(emailTextController.text,passwordTextController.text);

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

      drawer:Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: const Radius.circular(0.0),bottomRight: const Radius.circular(90.0)),
          color: Colors.white,
        ),

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Image.asset("assets/images/hos_logo.png",
                    width: 70,
                    height: 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('HOS',
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),

                ],
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                //  image: DecorationImage(
                //      fit: BoxFit.fill,
                //     image: AssetImage('assets/images/cover.jpg')
                // )
              ),
            ),
            ListTile(

              leading: Icon(Icons.input,
                color: Colors.green,
              ),
              title: Text('Configure',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ip_config())),
              },
            ),

          ],
        ),
      ),

    );
  }
  Future<void> getFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    port = prefs.getString("port");
    ip = prefs.getString("ip_address");
    print('ip'+ ip + port);

//
    _sKey.currentState.showSnackBar(new SnackBar(content: new Text(ip+'or'+port) ));

  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}


