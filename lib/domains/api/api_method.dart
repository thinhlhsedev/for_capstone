import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_url.dart';

Future<dynamic> callApi(String uri, String method,
    {Map<String, String>? header, Map<String, dynamic>? queryParams, 
    dynamic bodyParams}) async {
      
  try {
    var fullUri = Uri(
        scheme: ApiUrl.scheme,
        host: ApiUrl.host,
        path: uri,        
        queryParameters: queryParams);
    late http.Response response;

    switch (method) {
      case "get":
        response = await http.get(fullUri, headers: header,);
        break;
      case "put":
        response = await http.put(fullUri, headers: header, body: bodyParams);
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
    switch (method) {
      case "get":
      var jsonData = jsonDecode(body);
      return jsonData;
      default:
      return response.body.toString();
    }    
  } on Exception catch (ex) {
    throw Exception(ex.toString());
  }
}
