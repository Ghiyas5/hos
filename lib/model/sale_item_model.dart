class SaleReport{
List<item> list_item;
List<customer> list_cust;

SaleReport({this.list_item, this.list_cust});
SaleReport.fromJson(Map<String,dynamic> json){
  if (json['list_item'] != null) {
    list_item = new List<item>();
    json['list_item'].forEach((v) {
      list_item.add(new item.fromJson(v));
    });
  }

  if (json['list_cust'] != null) {
    list_cust = new List<customer>();
    json['list_cust'].forEach((v) {
      list_cust.add(new customer.fromJson(v));
    });
  }
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> list = new Map<String, dynamic>();
  if (this.list_item != null) {
    list['list_item'] = this.list_item.map((v) => v.toJson()).toList();
  }
  if (this.list_cust != null) {
    list['list_cust'] = this.list_cust.map((v) => v.toJson()).toList();
  }
  
  return list;
}
}


class item{

  String iteM_CODE,iteM_NAME;

  item({this.iteM_CODE, this.iteM_NAME});

  item.fromJson(Map<String, dynamic> json) {
    iteM_CODE = json['iteM_CODE'];
    iteM_NAME = json['iteM_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> list_item = new Map<String, dynamic>();
    list_item['iteM_CODE'] = this.iteM_CODE;
    list_item['iteM_NAME'] = this.iteM_NAME;
    return list_item;
  }


}


class customer{

  String cuS_CODE,cuS_NAME;

  customer({this.cuS_CODE, this.cuS_NAME});

  customer.fromJson(Map<String, dynamic> json) {
    cuS_CODE = json['cuS_CODE'];
    cuS_NAME = json['cuS_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> list_cust = new Map<String, dynamic>();
    list_cust['cuS_CODE'] = this.cuS_CODE;
    list_cust['cuS_NAME'] = this.cuS_NAME;
    return list_cust;
  }
}