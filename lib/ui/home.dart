import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cash/ui/cardpage.dart';
import 'package:smart_cash/ui/dashboard.dart';
import 'package:smart_cash/ui/exchangepage.dart';
import 'package:smart_cash/ui/home_tab_controller.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_cash/Repository/getlatestdatamarket.dart' as market;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String price='';
  int selectedIndex = 0;
  final pages = [
      const DashBoardPage(),
      const WalletPage(),
      const CardPage(),
      const ExchangePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
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
                      selectedIndex = 0 ;
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
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => WalletPage())
                                                );
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
                                              child: Row(
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
                                top: 0,
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
      backgroundColor: wColor,
      body: pages[selectedIndex]
    );
  }
}
