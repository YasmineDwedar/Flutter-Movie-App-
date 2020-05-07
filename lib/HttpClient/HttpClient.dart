// Reposible form taking url api and return response body
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HttpClient {
  Future<dynamic> get(String url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // decodes string into iterable json object 'jsonResponse'
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);
      return jsonResponse;
    } else {
      return Future.error(Error());
    }
  }
}
