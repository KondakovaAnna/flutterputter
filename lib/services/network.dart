import 'package:http/http.dart' as http;
var URL = Uri.parse("http://127.0.0.1:5000/");

void test() async{
  print(URL.port);
  var response = await http.post(
      URL, body: {'name': 'doodle', 'color': 'blue'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}