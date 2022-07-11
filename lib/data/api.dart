import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pakokku_pagoda/ob/pagoda_ob.dart';
import 'package:pakokku_pagoda/utils/constant.dart';

class Api {
  static Future<List<PagodaOb>> getData() async {
    var response = await http.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<PagodaOb> pagodaList = [];
      data.map((pList) => {pagodaList.add(PagodaOb.fromJson(pList))}).toList();
      return pagodaList;
    } else {
      return [];
    }
  }
}
