import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_cash/Repository/user_repository.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import 'package:smart_cash/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_cash/ui/cardpage.dart';
import 'package:smart_cash/ui/dashboard.dart';
import 'package:smart_cash/ui/exchangepage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import 'package:smart_cash/Models/user_model.dart' as userModel;

class WalletAdddressPage extends StatefulWidget {
  const WalletAdddressPage({Key? key}) : super(key: key);

  @override
  State<WalletAdddressPage> createState() => _WalletAdddressPageState();
}

class _WalletAdddressPageState extends State<WalletAdddressPage> {
  int selectedIndex = 1;
  int selecteddown = 0;
  bool tab = false;
  bool totalsent = false;
  bool totalrec = false;
  int? selected = 0;
  bool? rememberMe = true;
  bool privatekey = false;
  bool importantnotes = false;

  bool loadingdata = false;

  List<userModel.User> _users = [];
  userModel.User currentuser = new userModel.User();

  String tronbalance = '';

  String destination_address = '';
  String amount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    respo.getallusers().then((value){
      setState((){
        _users.addAll(value);
       }
      );
    });

  }

  Future<void> matcuser() async {
    setState(() {
      for(int i=0;i<_users.length;i++){
        if(_users[i].id.toString() == respo.currentUser.value.id.toString()){
          currentuser = _users[i];
        }
      }
    });
  }

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


  void sendtrc20() async {
    String url = 'https://eu.trx.chaingateway.io/v1/sendTRC20';
    final client = new http.Client();
    var body = json.encode({"contractaddress": "TLa2f6VPqDgRE67v1736s7bJ8Ray5wYjU7", "from": currentuser.delivery_address.toString(), "to": destination_address.toString(), "privatekey": currentuser.private_key.toString(), "amount": amount, "apikey": "p2xdxzmllsk8kggsckwk004wk8w088c00g0o0g8csk8cg0gckg4sg88wco8888ks"});
    final response = await client.post(
        Uri.parse(url),
        body: body
    );
    if(response.statusCode == 200){
      var result = json.decode(response.body)['ok'];
      if(result.toString() == 'false'){
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
                      child: Image.asset("images/failure-5@2x.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 15, 10),
                      child: Text("Error",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 15, 10),
                      child: Text(json.decode(response.body)['description'].toString()),
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
      }else{
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
                      child: Text(json.decode(response.body)['description'].toString()),
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
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    matcuser();
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
                      Image.asset("images/vuesax-bold-chart-square-1.png",color: selectedIndex == 0 ? sColor : Colors.grey,),
                      Text("Dashboard",style: TextStyle(color:selectedIndex == 0 ? sColor : Colors.grey,fontSize: 12))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-empty-wallet.png",color: selectedIndex == 1 ? sColor : Colors.grey),
                      Text("Wallet",style: TextStyle(color:selectedIndex == 1 ? sColor : Colors.grey,fontSize: 12))
                    ],
                  ),
                ),
              ),
              InkWell(
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
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: p1Color,
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image.asset("images/topup@2x.png",height: 30
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Top Up",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                                    Text("Top up crypto, stablecoins or fiat",style: TextStyle(fontSize: 14)),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                              child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade300)),),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: p1Color,
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image.asset("images/borrow@2x.png",height: 30
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Borrow",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                                    Text("Borrow using crypto as collateral",style: TextStyle(fontSize: 14)),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                              child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey.shade300)),),
                                            ),
                                            SizedBox(height: 10),
                                            InkWell(
                                              onTap: (){
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
                                                              child: Text("Your transaction withdrawl has been done successfully on 7.12.2022 at 8 pm"),
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
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: p1Color,
                                                        borderRadius: BorderRadius.circular(15)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Image.asset("images/withdraw@2x.png",height: 30
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Withdraw",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                                      Text("send crypto, stablecoins or fiat ",style: TextStyle(fontSize: 14)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10)
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
                  child: Image.asset("images/Group 17553@2x.png")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-card-pos.png",color: selectedIndex == 2 ? sColor : Colors.grey),
                      Text("Card",style: TextStyle(color: selectedIndex == 2 ? sColor : Colors.grey,fontSize: 12))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/vuesax-bold-convert-card.png",color: selectedIndex == 3 ? sColor : Colors.grey),
                      Text("Exchange",style: TextStyle(color: selectedIndex == 3 ? sColor : Colors.grey,fontSize: 12))
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                child: Row(
                  children: [
                    Image.asset("images/Mask Group -2@2x.png",height: 60),
                    Text("Top up TRX",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Expanded(child: SizedBox()),
                    Text("Change coin",style: TextStyle(color: pColor,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                child: Text("Delivery Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20,10),
                child: Container(
                  decoration: BoxDecoration(
                      color: w1Color,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          currentuser.delivery_address.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,color: sColor,fontSize: 12),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: InkWell(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: currentuser.delivery_address.toString()));
                            Fluttertoast.showToast(
                                msg: 'Delivery Address copied to clipboard',
                              backgroundColor: pColor,
                              textColor: Colors.white
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: sColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 6, 5, 6),
                              child: Image.asset("images/copy@2x.png",height: 25),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          privatekey = false;
                          getbalnce(currentuser.delivery_address.toString());
                          tab = !tab ;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !tab ? wColor : pColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: w1Color,
                              blurRadius: 6,
                              spreadRadius: 5,
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 12,10, 12),
                          child: Text("Show Balance Details",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                          color: tab ? wColor : Colors.black
                          ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: (){
                        setState(() {
                          tab = false;
                          privatekey = !privatekey;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: !privatekey ? wColor : pColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: w1Color,
                                blurRadius: 6,
                                spreadRadius: 5,
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 12,10, 12),
                          child: Text("Show Private key",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                              color: privatekey ? wColor : Colors.black),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Visibility(
                  visible: tab,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25,10, 25, 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              totalsent = !totalsent;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: !totalsent ? wColor : pColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: w1Color,
                                    blurRadius: 6,
                                    spreadRadius: 5,
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 12,10, 12),
                              child: Row(
                                children: [
                                  Image.asset("images/money-send.png",color: totalsent ? wColor : pColor),
                                  SizedBox(width: 5),
                                  Text("Total Sent:-"+tronbalance,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                                    color: totalsent ? wColor : Colors.black,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              totalrec = !totalrec;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: !totalrec ? wColor : pColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: w1Color,
                                    blurRadius: 6,
                                    spreadRadius: 5,
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 12,10, 12),
                              child: Row(
                                children: [
                                  Image.asset("images/money-recive.png",color: totalrec ? wColor : pColor),
                                  SizedBox(width: 5),
                                  Text("Total Received:"+tronbalance,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                                      color: totalrec ? wColor : Colors.black),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              Visibility(
                  visible: totalsent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Text("Date",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("   Pay Id",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("   Amount",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("Status",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),



                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),



                      ],
                    ),
                  )
              ),
              Visibility(
                  visible: totalrec,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Text("Date",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("   Pay Id",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("   Amount",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            Expanded(child: SizedBox()),
                            Text("Status",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),



                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/tick-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("11/01/2021",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("12345",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Text("\$100",style: TextStyle(fontSize: 16)),
                            Expanded(child: SizedBox()),
                            Image.asset("images/close-circle.png"),
                            SizedBox(width: 10)
                          ],
                        ),
                        SizedBox(height: 10),



                      ],
                    ),
                  )
              ),
              Visibility(
                  visible: privatekey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: wColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: w1Color,
                              blurRadius: 6,
                              spreadRadius: 5,
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          children: [
                            Expanded(child: Text(currentuser.private_key.toString(),style: TextStyle(fontSize: 16),)),
                            InkWell(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text: currentuser.private_key.toString()));
                                Fluttertoast.showToast(
                                    msg: 'Private key copied to clipboard',
                                    backgroundColor: pColor,
                                    textColor: Colors.white
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: sColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Copy",style: TextStyle(color: wColor),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: PhysicalModel(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.asset("images/Group -13@2x.png",height: 30),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Send only Bitcoin (BTC) to this"),
                                Text("address using Bitcoin (native)"),
                                Text("network"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: w1Color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(

                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset("images/Mask Group -8@2x.png",height: 45),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("Important Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          ),
                          Expanded(child: SizedBox()),
                          InkWell(
                            onTap: (){
                             setState(() {
                               importantnotes = !importantnotes;
                             });
                            },
                              child: Image.asset("images/down@2x.png",width: 20,color: selecteddown == 0 ? Colors.black : Colors.white,)
                          ),
                          SizedBox(width: 15)
                        ],
                      ),
                      Visibility(
                          visible: importantnotes,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
                          )),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25),
                child: RaisedButton(
                  onPressed: () {
                  /*  showMaterialModalBottomSheet(context: context,
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
                                            Text("Top up wallet",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 30),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: w1Color,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(25, 2, 20, 2),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText: "Enter Value",hintStyle: TextStyle(color: Colors.grey.shade800,fontSize: 16),                                                     border: InputBorder.none
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: w1Color,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                      child: Text("\$10",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: w1Color,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                      child: Text("\$100",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: w1Color,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                      child: Text("\$150",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            SizedBox(height: 30),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: w1Color,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                    child: Text("\$180",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                  ),
                                                ),
                                                Expanded(child: SizedBox()),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: w1Color,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                    child: Text("\$200",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                  ),
                                                ),
                                                Expanded(child: SizedBox()),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: w1Color,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                                                    child: Text("\$250",style: TextStyle(color: Colors.grey.shade600,fontSize: 16),),
                                                  ),
                                                ),


                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            RaisedButton(
                                              onPressed: () {
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
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      SingleChildScrollView(
                                                                        child: Column(
                                                                          children: [
                                                                            PhysicalModel(color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(13),
                                                                              elevation: 5,
                                                                              child: Row(
                                                                                children: [Padding(
                                                                                  padding: const EdgeInsets.all(20),
                                                                                  child: Image.asset("images/Icon payment-credit-card@2x.png",height: 25,),
                                                                                ),
                                                                                  SizedBox(width: 20),
                                                                                  Text("Credit Card",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                  Expanded(child: SizedBox()),
                                                                                  Padding(
                                                                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                      child: Radio(
                                                                                        activeColor: pColor,
                                                                                        value: 0,
                                                                                        groupValue: selected,
                                                                                        onChanged: (val){
                                                                                          setState(() {
                                                                                            selected = val as int?;
                                                                                          });
                                                                                        },
                                                                                      )
                                                                                  ),],
                                                                              ),),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                    child: Image.asset("images/upi.png",height: 35,width: 30,),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("UPI Id",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 1,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    child: Image.asset("images/paytm-logo@2x.png",height: 35),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("PayTm",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 2,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    child: Image.asset("images/google pay@2x.png",height: 35,),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("Google Pay",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 3,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    child: Image.asset("images/paypal@2x.png",height: 25,width: 30,),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("PayPal",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 4,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    child: Image.asset("images/paypal@2x.png",height: 25,width: 30,),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("PayPal",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 4,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: PhysicalModel(color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(13),
                                                                                elevation: 5,
                                                                                child: Row(
                                                                                  children: [Padding(
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    child: Image.asset("images/phonepay@2x.png",height: 25,width: 30,),
                                                                                  ),
                                                                                    SizedBox(width: 20),
                                                                                    Text("PhonePay",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                                                                                    Expanded(child: SizedBox()),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                                                        child: Radio(
                                                                                          activeColor: pColor,
                                                                                          value: 4,
                                                                                          groupValue: selected,
                                                                                          onChanged: (val){
                                                                                            setState(() {
                                                                                              selected = val as int?;
                                                                                            });
                                                                                          },
                                                                                        )
                                                                                    ),],
                                                                                ),),
                                                                            ),
                                                                            SizedBox(height: 30,),
                                                                            RaisedButton(
                                                                              onPressed: () {

                                                                              },
                                                                              color: sColor,
                                                                              shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(15)),
                                                                              child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                                                    child: Text(
                                                                                      "Top Up",
                                                                                      style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontSize: 20),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                            SizedBox(height: 10)
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                        Positioned(
                                                            top: 5,
                                                            right: 20,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: CircleAvatar(
                                                                  child: Icon(
                                                                    Icons.close_rounded,
                                                                    color: Colors.white,
                                                                  ),
                                                                  backgroundColor: pColor,
                                                                )))
                                                      ],
                                                    ));
                                              },
                                              color: sColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                    child: Text(
                                                      "Top Up",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Center(child: Text("Processing Time Upto 15 Minutes",textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
                                            SizedBox(height: 10)

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
                        )); */

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
                                      Expanded(child: Text("Coming Soon",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19))
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
                                  child: Text("We are working on it , this feature will be available soon ",
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
                  color: sColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Text(
                          "Top up wallet",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18),
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
                      getbalnce(currentuser.delivery_address.toString());
                      loadingdata = true;
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
                                              Text("Transfer Crypto" ,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                              Text(!loadingdata ? 'fetching' : 'Available Credit:- $tronbalance' ,style: TextStyle(color: Colors.black,fontSize: 15),),
                                              SizedBox(height: 30),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: w1Color,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(25, 2, 20, 2),
                                                  child: TextField(
                                                    onChanged: (value) => destination_address = value,
                                                    decoration: InputDecoration(
                                                        hintText: "Enter Destination Address",hintStyle: TextStyle(color: Colors.grey.shade800),
                                                        border: InputBorder.none
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: w1Color,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(25, 2, 20, 2),
                                                  child: TextField(
                                                    onChanged: (value) => amount = value,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                        hintText: "Enter Crypto Amount",hintStyle: TextStyle(color: Colors.grey.shade800),
                                                        border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),

                                              Row(
                                                children: [
                                                  Checkbox(
                                                    value: rememberMe,
                                                    onChanged: (value){
                                                      rememberMe = value;
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text("I agree to terms and Conditions, Refund Policy, Payment info policy ",style:
                                                    TextStyle(color: Colors.black,fontSize: 15),),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              RaisedButton(
                                                onPressed: () {
                                                  double available = double.parse(tronbalance);
                                                  double amount1 = double.parse(amount);
                                                  if(destination_address.toString() == ''){
                                                    Fluttertoast.showToast(
                                                        msg: 'please enter destination address',
                                                        textColor: Colors.white,
                                                        backgroundColor: pColor
                                                    );
                                                  }else if(amount.toString().isEmpty){
                                                    Fluttertoast.showToast(
                                                        msg: 'please enter amount',
                                                        textColor: Colors.white,
                                                        backgroundColor: pColor
                                                    );
                                                  }else if(available < amount1){
                                                    Fluttertoast.showToast(
                                                        msg: 'you don\'t have enough balance to transfer',
                                                        textColor: Colors.white,
                                                        backgroundColor: pColor
                                                    );
                                                  }else{
                                                    sendtrc20();
                                                  }
                                                },
                                                color: sColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15)),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                      child: Text(
                                                        "Transfer",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: 10)
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
                    color: pColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Text(
                            "Transfer",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
