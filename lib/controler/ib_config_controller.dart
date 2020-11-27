import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hos/http/request.dart';
import 'package:hos/http/url.dart';
import 'package:hos/login/login.dart';
import 'package:hos/model/sale_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  Ip_Config_Controller extends GetxController{
  var itemlist = List<item>().obs;


  @override
  void onInit() {

    super.onInit();
  }

  void _apiGetProduct() async {
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));

    Request request = Request(url: urlUserList, body: null);
    request.get().then((value) {
      item userListModel =
      item.fromJson(json.decode(value.body));
      itemlist.value = userListModel.iteM_NAME as List<item>;

    }).catchError((onError) {
      print(onError);
    });
  }

}