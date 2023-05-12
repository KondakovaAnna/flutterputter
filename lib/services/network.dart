/*import 'package:http/http.dart' as http;
var URL = Uri.parse("http://127.0.0.1:5000/");

void test() async{
  print(URL.port);
  var response = await http.post(
      URL, body: {'name': 'doodle', 'color': 'blue'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}*/

import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:myproject/classes/Plant.dart';


class NetworkWorker {
  Future<Plant_with_coordinate> ImageClassification(
      DateTime time, double latitude, double longitude, http.MultipartFile pic) async {
    //здесь должно быть взаимодействие с сервером
    //send image
    var request = http.MultipartRequest("POST", Uri.parse("http://192.168.2.21:80/predict"));
    //var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var resp = json.decode(String.fromCharCodes(responseData));
    //send info
    var plant_id = resp["class_num"];
    //send info
    final information = {
      "plantid": plant_id,
      //"plant_name": json_dc["class_name"],
      "userid": 2,
      "date": "${time.day.toString()}/${time.month.toString().padLeft(2,'0')}/${time.year.toString().padLeft(2,'0')}",
      "longitude": longitude,
      "latitude": latitude
    };
    var response_info = await http.post(
      Uri.parse('http://192.168.2.21:80/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(information),
    );
    var resp_info = jsonDecode(response_info.body);
    print(resp_info);
    var Presp_info = Plant.fromJson(resp_info);
    var res = Plant_with_coordinate.fromPlant(Presp_info, latitude, longitude, time);
    return res;
  }

  Future<List<Plant_with_coordinate>> Start(int user_id) async {
    final user = {
      "userid": user_id
    };
    var response_info = await http.post(
      Uri.parse('http://192.168.2.21:80/histories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    var resp_info = jsonDecode(response_info.body);
    List<Plant_with_coordinate> res = [];
    resp_info.forEach((element) =>
     res.add(Plant_with_coordinate.fromJson(element))
    );
    return res;
  }


}
