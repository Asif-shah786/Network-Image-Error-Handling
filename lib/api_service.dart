import 'dart:convert';
import 'Football_images.dart';
import 'package:http/http.dart' as http;
String kYourAPIHere = 'kYourApiHere';

class ApiService {
  Future<List<String>> getImages() async {
    try {
      var url = Uri.parse(kYourAPIHere);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<String> images = [];
        for(var i in data){
          images.add(FootballImages.fromJson(i).countryLogo!);
        }
        print(images);
        return images;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
