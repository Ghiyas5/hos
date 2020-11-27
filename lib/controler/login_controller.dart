import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hos/http/request.dart';
import 'package:hos/http/url.dart';
import 'package:http/http.dart' as http;
import '../dashboard.dart';



class LoginController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  BuildContext context;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  void apiLogin() async {
    //  Request request = Request(url: urlLogin, body: {
    //    'email': emailTextController.text,
    //    'password': passwordTextController.text
    //  });
    //  request.post().then((value) {
    //    Navigator.push(
    //        context,
    //        MaterialPageRoute(
    //          builder: (context) => Dashboard(),
    //        ));
    //
    //  }).catchError((onError) {});
    // }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));
  }
}
