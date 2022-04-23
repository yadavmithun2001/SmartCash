import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ExchangePage extends StatelessWidget {
  const ExchangePage({Key? key}) : super(key: key);

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
                child: Text("Exchange",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
              ),
              Padding(padding: EdgeInsets.fromLTRB(30, 10, 25, 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Pay With",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontSize: 16,fontWeight: FontWeight.bold))),
                    Container(
                      decoration: BoxDecoration(
                        color: p1Color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                        child: Text("ETH",style: TextStyle(color: pColor,fontSize: 14),)
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: w1Color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                          child: Text("USD",style: TextStyle(color: Colors.grey.shade800,fontSize: 14),)
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: PhysicalModel(color: wColor,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                            child: Image.asset("images/Mask Group -8@2x.png",height: 50,)
                        ),
                        Text("Bitcoin",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                        Image.asset("images/down-2@2x.png",width: 20),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("0.00000000",style: TextStyle(color: pColor,fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(height: 10),
                            Text("Available:0.0000000",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                          ],
                        )),
                        SizedBox(width: 15)
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Text("Receive",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: PhysicalModel(color: wColor,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                            child: Image.asset("images/Mask Group -1@2x.png",height: 50,)
                        ),
                        Text("Ether",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(width: 10),
                        Image.asset("images/down-2@2x.png",width: 20),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("0.00000000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(height: 10),
                            Text("Available:0.0000000",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),

                          ],
                        )),
                        SizedBox(width: 15)
                      ],
                    )
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
