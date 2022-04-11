import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_url.dart';

Future<dynamic> callApi(String urii, String method,
    {Map<String, String>? header, Map<String, dynamic>? queryParams, Map<String, dynamic>? bodyParams}) async {
  try {
    var fullUri = Uri(
        scheme: ApiUrl.scheme,
        host: ApiUrl.host,
        path: urii,        
        queryParameters: queryParams);
    late http.Response response;

    switch (method) {
      case "get":
        response = await http.get(fullUri, headers: header);
        break;
      case "put":
        response = await http.put(Uri.parse(urii), headers: header, body: bodyParams);
        break;
      case "post":
        response = await http.post(fullUri, headers: header, body: bodyParams);
        break;
      case "delete":
        response = await http.delete(fullUri, headers: header, body: bodyParams);
        break;
    }

    final statusCode = response.statusCode;
    final String body = response.body;

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Error request: $statusCode");
    }
    var jsonData = jsonDecode(body);
    return jsonData;
  } on Exception catch (ex) {
    throw Exception(ex.toString());
  }
}
