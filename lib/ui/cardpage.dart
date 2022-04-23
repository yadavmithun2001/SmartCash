import 'package:flutter/material.dart';

import '../constants.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Image.asset("images/notification@2x.png",
                        color: Colors.black,
                        height: 30),
                    SizedBox(width: 20),
                    Image.asset("images/profile@2x.png",color: Colors.black,height: 30),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 15, 35, 0),
                child: Image.asset("images/card@2x.png"),
              ),
              SizedBox(height: 30),
              Text("You Are On The Waiting List For",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 0.5)
              ),
              SizedBox(height: 10),
              Text("The SmartCash Card",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 0.5)
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 40, 20),
                child: Text("Invite Your Friends to Get Your SmartCash Card sooner!",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
