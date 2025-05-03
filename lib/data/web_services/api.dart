import 'package:dio/dio.dart';

import '../../constants/string.dart';
import '../models/characters.dart';

class Api {

Dio? dio;
  Api() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(
        seconds: 20,
      ),
      receiveTimeout: Duration(seconds:5),
    );
  dio = Dio(options);


  }

  Future<List<dynamic>> getAllCharacters() async {
   try {
      Response? response = await dio?.get('/character/');
     //  print(response?.data.toString());
     // print(response?.data.runtimeType);
      return response?.data["results"];
    }catch(e){
     print(e.toString());
     return [];
   }
  }
// Future<List<dynamic>> getAllCharacters() async {
//   try {
//     Response? response = await dio?.get('/character');
//      print(response?.data.toString());
//     return [];
//   }catch(e){
//     print(e.toString());
//     return [];
//   }
// }
}



