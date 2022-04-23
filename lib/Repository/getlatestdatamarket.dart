import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_cash/Models/privacy_model.dart' as coinModel;


Future<String> getlatestmarketdata() async {
  String message='';
  String url = 'https://investing-cryptocurrency-markets.p.rapidapi.com/coins/list';
  var response = await http.get(
      Uri.parse(url),
    headers: {
      "X-RapidAPI-Key" : "f1bc4a0e31mshf880ebd63d1e7a4p1f13c9jsn594aae8a8560"
    }
  );
  List<coinModel.Privacy> coins = [];
  if(response.statusCode == 200){
    var data1 = json.decode(response.body)['data'][0]['screen_data']['crypto_data'];
    message = data1.toString();
  }
  return message;

}