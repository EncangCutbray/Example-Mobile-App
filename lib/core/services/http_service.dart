// ignore_for_file: unused_import

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class HttpService {
  String token;
  String devBeApi;

  HttpService({
    this.token =
        'X5ckXwVzY5729zwlYomzgZfcLCQRJtDCyPByDfglvy2VDVpGyBfJ9FT9tvi4C3Xh',
    this.devBeApi = 'https://devbe.bahaso.com/api',
  });

  Future<http.Response> httpGet(String endPoint) async {

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Authorization": token
    };

    final url = Uri.parse('$devBeApi$endPoint');
    return await http.get(url, headers: headers);

  }

  static httpPost() {}
}
