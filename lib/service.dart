import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'dates_model.dart';

class ApiService {
  Future<DatePrediction?> fetchDataFromApi(File file) async {
    if (!file.existsSync()) {
      print('Error: File does not exist');
      return null;
    }
    final Uri url = Uri.parse("http://192.168.100.4:8000/predict");

   // final Uri url = Uri.parse("http://10.0.2.2:8000/predict/");

    try {
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', file.path))
        ..headers.addAll({'Accept': 'application/json'});

      var streamedResponse = await request.send().timeout(Duration(minutes:20));

      Fluttertoast.showToast(msg:'Response status: ${streamedResponse.statusCode}');

      if (streamedResponse.statusCode == 200) {
        final responseBody = await streamedResponse.stream.bytesToString();
        Fluttertoast.showToast(msg:'Response body: $responseBody');

        if (responseBody.isEmpty) {
          Fluttertoast.showToast(msg:'Error: Empty response from API');
          return null;
        }

        final jsonData = json.decode(responseBody);
        return DatePrediction.fromJson(jsonData);
      } else {
        Fluttertoast.showToast(msg:'Error: API returned status code ${streamedResponse.statusCode}');
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg:'Unexpected error: $e');
      return null;
    }
  }
}
