import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:smart_cash/ui/login.dart';
import 'package:smart_cash/ui/register.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:smart_cash/Models/user_model.dart' as userModel;
import 'package:smart_cash/Repository/getlatestdatamarket.dart' as market;
import 'package:smart_cash/Repository/user_repository.dart' as respo;

import '../Repository/user_repository.dart';
import '../constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    respo.getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      currentUser.value = userModel.User.fromJson(json.decode(prefs.get('current_user').toString()));

      Timer(Duration(seconds: 2), (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      closeSplashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(
                      'images/Group 38@3x.png',
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              CircularProgressIndicator(
                color: sColor,
              ),
              SizedBox(height: 100)
            ],
          )
      ),

    );
  }

   void closeSplashScreen() async{
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    );
  }

   void newAddress() async {
    String url = 'https://eu.trx.chaingateway.io/v1/newAddress';
     final client = new http.Client();
     var body = json.encode({"apikey": "p2xdxzmllsk8kggsckwk004wk8w088c00g0o0g8csk8cg0gckg4sg88wco8888ks"});
     final response = await client.post(
         Uri.parse(url),
         body: body
     );
     if (response.statusCode == 200) {
       var address = json.decode(response.body)['address'];
       var privatekey = json.decode(response.body)['privatekey'];
       var hexaddress = json.decode(response.body)['hexaddress'];
       respo.postaddressdetails(currentUser.value.id.toString(), address, privatekey, hexaddress);
     } else {
       throw new Exception(response.body);
     }
   }

  void setCurrentUser(jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
  }

}
