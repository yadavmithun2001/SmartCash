
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:smart_cash/Config/api.dart';
import 'package:smart_cash/Config/config.dart';
import 'package:smart_cash/Models/user_model.dart' as userModel;
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

Future<List<userModel.User>> getallusers() async{
  String url = MyConfig.appApiUrl+API.login;
  var response = await http.get(Uri.parse(url));
  List<userModel.User> users = [];
  if(response.statusCode == 200){
    var list = json.decode(response.body);
    for(var value in list){
      users.add(userModel.User.fromJson(value));
    }
  }
  return users;
}

Future<void> logout() async {
  currentUser.value = new userModel.User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<String> register(String email,String password) async {
  String message = '';
  final String url = MyConfig.appApiUrl+API.register;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        'email':email,'password':password,
      }
  );
  if (response.statusCode == 200) {
    if(json.decode(response.body)['Result'].toString()=='Success'){
      toast('Account Created Successfully');
      message = json.decode(response.body)['Result'].toString();
    }else{
      toast('This email id is already registered');
      message = json.decode(response.body)['Result'].toString();
    }
  } else {
    throw new Exception(response.body);
  }
  return message;
}

Future<String> updateuserdetails(String id,String name,String profilepic,String displayname,String location,String currency,String phonenumber) async {
  String message = '';
  final String url = MyConfig.appApiUrl+API.userdetails;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
      body: {
        'id':id,'name':name,'gallery':profilepic,'displayname':displayname,'location':location,'currency':currency,'mobilenumber':phonenumber
      }
  );

  if (response.statusCode == 200) {
    if(json.decode(response.body)['Result'].toString()=='Success'){
      toast('User Updated Successfully');
      message = json.decode(response.body)['Result'].toString();
    }else{
      toast('Something went wrong');
      message = json.decode(response.body)['Result'].toString();
    }
  } else {
    throw new Exception(response.body);
  }
  return message;
}

void setCurrentUser(jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
}



Future<void> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_user')) {
    currentUser.value = userModel.User.fromJson(json.decode(await prefs.get('current_user').toString()));
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
}


Future<String> getprivacypolicy() async{
  String message = '';
  String url = MyConfig.appApiUrl+API.privacy_policy;
  var response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    message = json.decode(response.body)[0]['privacy_policy'].toString();
  }
  return message;
}

Future<String> aboutsmartcash() async{
  String message = '';
  String url = MyConfig.appApiUrl+API.about_smartcash;
  var response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    message = json.decode(response.body)[0]['about_smartcash'].toString();
  }
  return message;
}

Future<String> postaddressdetails(String id,String delivary_address,String privatekey,String hex_address) async {
  String message = '';
  final String url = MyConfig.appApiUrl+API.addressdetails;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
      body: {
        'id':id,'delivery_address' : delivary_address,'private_key' : privatekey,'hex_address' : hex_address
      }
  );
  if (response.statusCode == 200) {
    if(json.decode(response.body)['Result'].toString()=='Success'){
      toast('User Updated Successfully');
      message = json.decode(response.body)['Result'].toString();
    }else{
      toast('Something went wrong');
      message = json.decode(response.body)['Result'].toString();
    }
  } else {
    throw new Exception(response.body);
  }
  return message;
}


