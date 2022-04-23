import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../constants.dart';

class AllMarketPage extends StatefulWidget {
  const AllMarketPage({Key? key}) : super(key: key);

  @override
  State<AllMarketPage> createState() => _AllMarketPageState();
}

class _AllMarketPageState extends State<AllMarketPage> {

  List<String> coinname = [];
  List<String> coinprice = [];
  List<String> percentage = [];
  List<String> icon = [];
  bool data = false;
  List<bool> upanddown = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlatestmarketdata().then((value) {
      setState(() {
        coinname.addAll(value);
        data = true;
      });
    });
    getprice().then((value) {
      setState(() {
        coinprice.addAll(value);
      });
    });
    getpercentage().then((value) {
      setState(() {
        percentage.addAll(value);
      });
    });
    getcoin().then((value) {
      icon.addAll(value);
    });
  }

  Future<List<String>> getlatestmarketdata() async {
    String url = 'https://investing-cryptocurrency-markets.p.rapidapi.com/coins/list';
    var response = await http.get(
        Uri.parse(url),
        headers: {
          "X-RapidAPI-Key" : "f1bc4a0e31mshf880ebd63d1e7a4p1f13c9jsn594aae8a8560"
        }
    );
    List<String> coinname = [];
    if(response.statusCode == 200){
      var data1 = json.decode(response.body)['data'][0]['screen_data']['crypto_data'];

      for(var data in data1){
        coinname.add(data['name']);
      }

      setState(() {
        data = true;
      });
    }
    return coinname;
  }
  Future<List<String>> getprice() async {
    String url = 'https://investing-cryptocurrency-markets.p.rapidapi.com/coins/list';
    var response = await http.get(
        Uri.parse(url),
        headers: {
          "X-RapidAPI-Key" : "f1bc4a0e31mshf880ebd63d1e7a4p1f13c9jsn594aae8a8560"
        }
    );
    List<String> coinname = [];
    if(response.statusCode == 200){
      var data1 = json.decode(response.body)['data'][0]['screen_data']['crypto_data'];

      for(var data in data1){
        coinname.add(data['inst_price_usd']);
      }

      setState(() {
        data = true;
      });
    }
    return coinname;
  }
  Future<List<String>> getpercentage() async {
    String url = 'https://investing-cryptocurrency-markets.p.rapidapi.com/coins/list';
    var response = await http.get(
        Uri.parse(url),
        headers: {
          "X-RapidAPI-Key" : "f1bc4a0e31mshf880ebd63d1e7a4p1f13c9jsn594aae8a8560"
        }
    );
    List<String> coinname = [];
    if(response.statusCode == 200){
      var data1 = json.decode(response.body)['data'][0]['screen_data']['crypto_data'];

      for(var data in data1){
        coinname.add(data['change_percent_1d']);
      }

      setState(() {
        data = true;
      });
    }
    return coinname;
  }
  Future<List<String>> getcoin() async {
    String url = 'https://investing-cryptocurrency-markets.p.rapidapi.com/coins/list';
    var response = await http.get(
        Uri.parse(url),
        headers: {
          "X-RapidAPI-Key" : "f1bc4a0e31mshf880ebd63d1e7a4p1f13c9jsn594aae8a8560"
        }
    );
    List<String> coinname = [];
    if(response.statusCode == 200){
      var data1 = json.decode(response.body)['data'][0]['screen_data']['crypto_data'];

      for(var data in data1){
        coinname.add(data['logo_url']);
      }

      setState(() {
        data = true;
      });
    }
    return coinname;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    Image.asset("images/profile@2x.png",color: Colors.black,height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text('All Markets',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
              ),
              data ? Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: coinname.length,
                    itemBuilder: (context,position){
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                        child: PhysicalModel(color: wColor,
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
                                    child: Image.network(icon[position].toString(),height: 40)
                                ),
                                Text(coinname[position].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                SizedBox(width: 15),
                                Image.asset("images/Path 21687@2x.png",width: 40),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('\$'+coinprice[position].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10),
                                    Text(percentage[position].toString(),style: TextStyle(color: percentage[position].startsWith('-') ? Colors.red : Colors.green,fontWeight: FontWeight.bold),),

                                  ],
                                )),
                                SizedBox(width: 15)
                              ],
                            )
                        ),
                      );
                    }),
              ) : Center(child: CircularProgressIndicator()),




            ],
          ),
        ),
      ),
    );
  }
}
