import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_cash/Profile/profile_main_page.dart';
import 'package:smart_cash/Repository/user_repository.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import 'package:smart_cash/ui/all_markets.dart';
import 'package:smart_cash/ui/notifications.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:smart_cash/Repository/getlatestdatamarket.dart' as market;
import 'package:smart_cash/Models/privacy_model.dart' as coinModel;
import 'package:fluttertoast/fluttertoast.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool data = false;
  var data1 = '';
  String coinname='';
  String coinprice='';
  String percentage = '';
  var tronrate;

  List<String> interestrates = [];
  var tronbalance ;
  bool loadingdata = false;
  String pfbalance='';
  String creditline ='Loading';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlatestmarketdata();

    if(currentUser.value.delivery_address.toString() == 'null'){
      interestrates.add('0');
      tronbalance = '0.0000';

    }else{
      getinterestrates();
      getbalnce(currentUser.value.delivery_address.toString());
      getcreditline();

    }
  }

  void getlatestmarketdata() async {
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
      coinname = data1[0]['name'];
      coinprice = data1[0]['inst_price_usd'];
      percentage = data1[0]['change_percent_1d'];
      tronrate = data1[24]['inst_price_usd'];
      setState(() {
        data = true;
      });
    }
  }

  void getinterestrates() async {
    String url = 'https://beautyandessentials.shop/smartcash_admin/public/api/getinterestrate';
    final response = await http.get(
        Uri.parse(url)
    );
    if(response.statusCode == 200){
      var list = json.decode(response.body);
      for(var u in list){
        interestrates.add(u['interestrate']);
      }

    }
  }

  void getcreditline() async {
    String url = 'https://beautyandessentials.shop/smartcash_admin/public/api/getcreditline/1';
    final response = await http.get(
        Uri.parse(url)
    );
    if(response.statusCode == 200){
      creditline = json.decode(response.body)[0]['creditline'].toString();
    }
  }


  String finalbc='';

  void getbalnce(String address) async {
    String url = 'https://eu.trx.chaingateway.io/v1/getTRC20Balance';
    final client = new http.Client();
    var body = json.encode({"contractaddress": "TLa2f6VPqDgRE67v1736s7bJ8Ray5wYjU7","tronaddress": address,"apikey": "p2xdxzmllsk8kggsckwk004wk8w088c00g0o0g8csk8cg0gckg4sg88wco8888ks"});
    final response = await client.post(
        Uri.parse(url),
        body: body
    );
    if (response.statusCode == 200) {
      var balance = json.decode(response.body)['balance'];
      setState(() {
        tronbalance = balance.toString();
        loadingdata = true;
      });
    } else {
      throw new Exception(response.body);
    }
  }

  void calcutalateinterest(){
    double interestrte = double.parse(tronbalance)*double.parse(tronrate) * double.parse(interestrates[0].toString());
    finalbc = interestrte.toString();
  }






  @override
  Widget build(BuildContext context) {
    bool _value = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
                        },
                      child: Image.asset("images/notification@2x.png",
                          color: Colors.black,
                          height: 30),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileMainPage()));
                        },
                        child: Image.asset("images/profile@2x.png",color: Colors.black,height: 30)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0,0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      ClipRRect(
                        child: Image.asset("images/Group -28.png",fit: BoxFit.contain),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        child: Image.asset("images/Group -29.png",fit: BoxFit.contain),

                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: PhysicalModel(color: wColor,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: w1Color,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset("images/star (2)@2x.png",color: Colors.black,height: 25,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text("Portfolio Balance",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,
                                    color: Colors.grey.shade600,fontSize: 18)),
                                SizedBox(height: 5),
                                Text('\$'+(double.parse(tronbalance)*double.parse(tronrate)).toString(),style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,fontSize:23,)),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        Container(
                          child: Column(
                            children: [
                              InkWell(
                                  onTap:(){
                                    showDialog(context: context, builder:(context){
                                      return SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        children: [
                                          Container(

                                            decoration : BoxDecoration(
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Text("Protfolio Balance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19))
                                                      ),
                                                      InkWell(
                                                        onTap:(){
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: pColor,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child:  Padding(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Image.asset("images/close.png"),
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                                                  child: Text("The Portfolio represents the dollar value of the assets in you Samrtcash Account, including crypto,stable coin and fiat balances ",
                                                    style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w300),),
                                                ),
                                                SizedBox(height: 30),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    color: sColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15)),
                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                          child: Text(
                                                            "Ok",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white,
                                                                fontSize: 22),
                                                          ),
                                                        )),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                                  },
                                  child: Image.asset("images/question@2x.png",height: 25)),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                        SizedBox(width: 15)
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: PhysicalModel(color: wColor,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text("Credit Line",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,
                                            color: Colors.grey.shade600,fontSize: 16)),
                                        SizedBox(height: 5),
                                        Text("\$"+creditline,style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Colors.black,fontSize:20,)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        InkWell(
                                            onTap : (){
                                              showDialog(context: context, builder:(context){
                                                return SimpleDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  children: [
                                                    Container(

                                                      decoration : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30)
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(30, 10, 15, 0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(child: Text("Credit Line",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19))
                                                                ),
                                                                InkWell(
                                                                  onTap:(){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        color: pColor,
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child:  Padding(
                                                                      padding: const EdgeInsets.all(10),
                                                                      child: Image.asset("images/close.png"),
                                                                    ),
                                                                  ),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                                                            child: Text("Your Credit Line is based on the market value of the crypto assets you keep in you Smartcash Account. Additional credit line is automatically and instantly available on your  SamrtCash Account upon appreciation of crypto's value. The value of crypto assets exceeding the used credit Line are always available for withdrawl ",
                                                              style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w300),),
                                                          ),
                                                          SizedBox(height: 30),
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                                            child: RaisedButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              color: sColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15)),
                                                              child: Container(
                                                                  alignment: Alignment.center,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                    child: Text(
                                                                      "Ok",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.white,
                                                                          fontSize: 22),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                            },
                                            child: Image.asset("images/question@2x.png",height: 25)),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Available Credit",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Colors.grey.shade600,fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 5),
                              Text('\$'+(double.parse(tronbalance)*double.parse(tronrate)).toString(),style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black,fontSize:20,)),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: PhysicalModel(color: wColor,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("images/growth@2x.png",height: 60),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Interest Earned",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Colors.grey.shade600,fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 5),
                              Text(interestrates.length == 0 ? 'calculating' :"\$"+(double.parse(tronbalance)*double.parse(tronrate)).toString(),style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.green,fontSize:20,),
                                  textAlign: TextAlign.left),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: RaisedButton(
                  onPressed: () {
                    showDialog(context: context, builder:(context){
                      return SimpleDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        children: [
                          Container(
                            decoration : BoxDecoration(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Row(
                                    children: [
                                      Expanded(child: SizedBox()
                                      ),
                                      InkWell(
                                        onTap:(){
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: pColor,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child:  Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset("images/close.png"),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Image.asset("images/success@2x.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 15, 15, 10),
                                  child: Text("Success",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 0, 15, 10),
                                  child: Text("Your withdrawl request has been created , please go to help and support for more help"),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: sColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                        )),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      );
                    });
                  },
                  color: sColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Borrow",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 20,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WalletPage())
                      );
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Top Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 22),
                          ),
                        )),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Markets",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontSize: 18,fontWeight: FontWeight.w600))),
                    Container(
                      decoration: BoxDecoration(
                        color: w1Color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: InkWell(
                          onTap: (){
                            showMaterialModalBottomSheet(context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25.0, 40, 25, 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Filter Watchlist",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 15),
                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: w1Color,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                                                child: Text("Market Cap",style: TextStyle(fontSize: 12),)
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: w1Color,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                                                child: Text("Price",style: TextStyle(fontSize: 12),)
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: w1Color,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                                                child: Text("24 Volume",style: TextStyle(fontSize: 12),)
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: w1Color,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                                                child: Text("% Change",style: TextStyle(fontSize: 12),)
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: w1Color,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                                                child: Text("Name",style: TextStyle(fontSize: 12),)
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Row(
                                                      children: [
                                                        Text("Drag to Reorder",style: TextStyle(color: Colors.grey),),
                                                        Expanded(child: SizedBox()),
                                                        Text("Reset All"),

                                                      ],
                                                    ),
                                                    SizedBox(height: 25),
                                                    PhysicalModel(color: wColor,
                                                        elevation: 2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                                                                child: Image.asset("images/Mask Group -8@2x.png",height: 45,)
                                                            ),
                                                            Text("Bitcoin",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            Expanded(child: SizedBox()),
                                                            Switch(
                                                                value: _value, onChanged: (value){
                                                                  setState(() {
                                                                    _value = value;
                                                                  });
                                                            },
                                                              activeColor: sColor,
                                                            ),
                                                            SizedBox(width: 15)
                                                          ],
                                                        )
                                                    ),
                                                    SizedBox(height: 20),
                                                    PhysicalModel(color: wColor,
                                                        elevation: 2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                                                                child: Image.asset("images/Mask Group -1@2x.png",height: 45,)
                                                            ),
                                                            Text("Ether",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            Expanded(child: SizedBox()),
                                                            Switch(
                                                              value: _value, onChanged: (value){
                                                              setState(() {
                                                                _value = value;
                                                              });
                                                            },
                                                              activeColor: sColor,
                                                            ),
                                                            SizedBox(width: 15)
                                                          ],
                                                        )
                                                    ),
                                                    SizedBox(height: 20),
                                                    PhysicalModel(color: wColor,
                                                        elevation: 2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                                                                child: Image.asset("images/Mask Group -5@2x.png",height: 45,)
                                                            ),
                                                            Text("NEXO",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            Expanded(child: SizedBox()),
                                                            Switch(
                                                              value: _value, onChanged: (value){
                                                              setState(() {
                                                                _value = value;
                                                              });
                                                            },
                                                              activeColor: sColor,
                                                            ),
                                                            SizedBox(width: 15)
                                                          ],
                                                        )
                                                    ),
                                                    SizedBox(height: 20),
                                                    PhysicalModel(color: wColor,
                                                        elevation: 2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                                                                child: Image.asset("images/Mask Group -4@2x.png",height: 45,)
                                                            ),
                                                            Text("XRP",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            Expanded(child: SizedBox()),
                                                            Switch(
                                                              value: _value, onChanged: (value){
                                                              setState(() {
                                                                _value = value;
                                                              });
                                                            },
                                                              activeColor: sColor,
                                                            ),
                                                            SizedBox(width: 15)
                                                          ],
                                                        )
                                                    ),
                                                    SizedBox(height: 20),
                                                    PhysicalModel(color: wColor,
                                                        elevation: 2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                                                                child: Image.asset("images/Mask Group -2@2x.png",height: 45,)
                                                            ),
                                                            Text("Tehter",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                                            Expanded(child: SizedBox()),
                                                            Switch(
                                                              value: _value, onChanged: (value){
                                                              setState(() {
                                                                _value = value;
                                                              });
                                                            },
                                                              activeColor: sColor,
                                                            ),
                                                            SizedBox(width: 15)
                                                          ],
                                                        )
                                                    ),

                                                    SizedBox(height: 10),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                    Positioned(
                                        top: 30,
                                        right: 20,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: pColor,
                                                  borderRadius: BorderRadius.circular(11)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Image.asset("images/close@2x.png",height: 20),
                                              ),
                                            )
                                        )
                                    )
                                  ],
                                )
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset("images/filter.png"),
                              SizedBox(width: 10),
                              Text("Filter",style: TextStyle(color: Colors.grey.shade600),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllMarketPage()));
                      },

                        child: Text("See All",style: TextStyle(color: pColor,fontSize: 16,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 10)
                  ],
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: PhysicalModel(color: wColor,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset("images/Mask Group -8@2x.png",height: 50,)
                        ),
                        Text(!data ? '---' : coinname,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(width: 15),
                        Image.asset("images/Path 21687@2x.png",width: 50),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(!data ? '---' : coinprice ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(!data ? '---' : percentage,style: TextStyle(color: percentage.startsWith('-') ? Colors.red : Colors.green,fontWeight: FontWeight.bold)),

                          ],
                        )),
                        SizedBox(width: 15)
                      ],
                    )
                ),
              ),
              SizedBox(height: 100)

            ],
          ),

        ),
      ),
    );
  }
}
