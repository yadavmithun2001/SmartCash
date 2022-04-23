import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cash/ui/cardpage.dart';
import 'package:smart_cash/ui/dashboard.dart';
import 'package:smart_cash/ui/exchangepage.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_cash/Models/privacy_model.dart' as privacyModel;

import '../Config/api.dart';
import '../Config/config.dart';
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import '../constants.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final String desc;
  const PrivacyPolicyPage({Key? key, required this.desc}) : super(key: key);
  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey
              )
            ],
            color: wColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-chart-square-1.png",color: Colors.grey,),
                      Text("Dashboard",style: TextStyle(color: Colors.grey.shade600,fontSize: 12))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-empty-wallet.png",color: Colors.grey),
                      Text("Wallet",style: TextStyle(color: Colors.grey.shade600,fontSize: 12))
                    ],
                  ),
                ),
              ),
              Image.asset("images/Group 17553@2x.png"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-card-pos.png",color: Colors.grey),
                      Text("Card",style: TextStyle(color: Colors.grey.shade600,fontSize: 12))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-convert-card.png",color: Colors.grey),
                      Text("Exchange",style: TextStyle(color: Colors.grey.shade600,fontSize: 12))
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: showidget()
    );
  }
  
  Widget showidget() {
    if(!isLoading){
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: w1Color,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 10,0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),
                                      border: InputBorder.none
                                  ),
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),

                                ),
                              ),
                            ),
                            Image.asset("images/search-normal@2x.png",
                                color: Colors.black,height: 20),
                            SizedBox(width: 20)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Image.asset("images/notification@2x.png",
                        color: Colors.black,
                        height: 30),
                    SizedBox(width: 20),
                    Image.asset("images/profile@2x.png",color: pColor,height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 20, 10),
                child: Text("Privacy Policy",style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Text(widget.desc.toString()),
              )
            ],
          ),
        ),
      );
    }
    return CircularProgressIndicator(color: sColor);
  }

}
