import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

// For Auth on Flutter

String _basicAuth =
    'Basic ' + base64Encode(
      utf8.encode(
        'Mohamed:M.I472001M.I'
        )
        );

Map<String, String> myheaders = {'authorization': _basicAuth};

mixin class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //get conncection
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (err) {
      print("Error Catch $err");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: myheaders,
          // headers: {
          //   "Access-Control-Allow-Origin": "*",
          //   "Access-Control-Allow-Headers": "X-Requested-With",
          //   "Access-Control-Allow-Credentials": 'true',

          //   "Access-Control-Allow-Headers": "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin",
          //   //'Content-Type': "application/json",
          //   //"Content-Type": "application/x-www-form-urlencoded",

          //   //"Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          //   //"Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD"
          // },
          body: data);
      if (response.statusCode == 200) {
        //get conncection
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error status Code is  ${response.statusCode}");
      }
    } catch (err) {
      print("Error Catch $err");
    }
  }

  postRequestWithFile(String url, Map<String, dynamic> data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    request.headers.addAll(myheaders);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest);

    if (myrequest.statusCode == 200) {
      print(jsonEncode(response.body));

      var responsebody = jsonDecode(response.body);
      return responsebody;
    } else {
      print(" Error ${myrequest.statusCode} ");
    }
  }
}
