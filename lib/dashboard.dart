import 'package:flutter/material.dart';
import 'package:flippo_navigation/flippo_navigation.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:hos/dashboard_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MaterialApp(
  home: Dashboard(),
));

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin{

  // Future<void> getFromSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   port = prefs.getString("port");
  //   ip = prefs.getString("ip_address");
  //   print('ip'+ ip + port);
  //
  //
  //   _sKey.currentState.showSnackBar(new SnackBar(content: new Text(ip+'or'+port) ));
  //
  // }


  var title = [
    "Sales",
    "Purchase",
    "Stock",
    "Expences",
    "Outstanding",
    "Dashboard",
  ];
  var img = [
    "assets/images/Sales-report.png",
    "assets/images/onlineshopping.png",
    "assets/images/blue_stock.png",
    "assets/images/budget.png",
    "assets/images/accounting.png",
    "assets/images/ideas_icon.png",
  ];
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
       color:Colors.white;

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // controller: controller,

      // mask:  Scaffold(
      //   backgroundColor: Colors.white,
      // ),
      body:  SafeArea(
        child: Column(
          children: <Widget>[


            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 6.0,
                dotIncreasedColor: Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 0.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: [
                  Image(
                    image: CachedNetworkImageProvider('https://hos.com.pk/MobileApp/1.png'),
                    fit: BoxFit.fill,
                  ),
                  Image(
                    image: CachedNetworkImageProvider('https://hos.com.pk/MobileApp/2.png'),
                    fit: BoxFit.fill,
                  ),
                  Image(
                    image: CachedNetworkImageProvider('https://hos.com.pk/MobileApp/3.png'),
                    fit: BoxFit.fill,
                  ),
                  Image(
                    image: CachedNetworkImageProvider('https://hos.com.pk/MobileApp/4.png'),
                    fit: BoxFit.fill,
                  ),
                ],
                // images: [
                //   NetworkImage('https://hos.com.pk/MobileApp/3.png'),
                //   NetworkImage('https://hos.com.pk/MobileApp/2.png'),
                //   NetworkImage('https://hos.com.pk/MobileApp/1.png'),
                //   NetworkImage('https://hos.com.pk/MobileApp/4.png')
                //   // ExactAssetImage("assets/images/LaunchImage.jpg"),
                // ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),

           scroll(),



          ],
        ),
      ),

      drawer:  Container(
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
              title: Text('Welcome',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user,
                color: Colors.green,
              ),
              title: Text('Profile',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard())),
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                color: Colors.green,
              ),
              title: Text('Settings',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color,
                color: Colors.green,
              ),
              title: Text('Feedback',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,
                color: Colors.green,
              ),
              title: Text('Logout',
                style: TextStyle(color: Colors.green,),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
