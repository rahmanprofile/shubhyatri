import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestController {

  static Future getRequest(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        return data;
      } else {
        return "failed to load data";
      }
    } catch (exp) {
      return exp.toString();
    }
  }

}
