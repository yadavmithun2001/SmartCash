import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cash/Profile/about_smartcash.dart';
import 'package:smart_cash/Profile/edit_profile.dart';
import 'package:smart_cash/Profile/privacy_policy.dart';
import 'package:smart_cash/ui/cardpage.dart';
import 'package:smart_cash/ui/dashboard.dart';
import 'package:smart_cash/ui/exchangepage.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import 'package:smart_cash/Models/user_model.dart' as userModel;
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_cash/ui/splash.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Config/api.dart';
import '../Config/config.dart';
import '../constants.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);
  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  String privacy_policy = '';
  String about_smartcash = '';

  @override
  void initState() {
    super.initState();
    respo.getprivacypolicy().then((value) {
      privacy_policy = value;
    });
    respo.aboutsmartcash().then((value) {
      about_smartcash = value;
    });
  }


  File? _image1;
  final ImagePicker _picker = ImagePicker();

  Future get1stImage() async {
   var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = File(pickedFile!.path);
   });
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
                    Image.asset("images/profile@2x.png",color: pColor,height: 30),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  //get1stImage();
                },
                child: Container(
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                         child: Image.asset("images/profile-1@2x.png",height: 120,width: 120 ,color:sColor,fit: BoxFit.cover,)
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: pColor,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'images/verify-5@2x.png',
                              color: Colors.white,
                              height: 30,),
                          )))
                  ],
                ),
                height: 160, width: 160,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                )
                ),
              ),
              InkWell(
                onTap: (){

                },
                  child: Text("Verified",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18))),
              SizedBox(height: 30),
              InkWell(
                onTap: (){
                  Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => EditProfilePage())
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: p1Color,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/profile-1@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edit Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text("Edit your profile",style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
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
                                        Text("Help & Support",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 30,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: w1Color,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(25, 2, 20, 2),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: "Enter Your Name",
                                                border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                        ),
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
                                                  hintText: "Enter Email Id",
                                                  border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: w1Color,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(25, 2, 20, 80),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Enter Message",
                                                  border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        RaisedButton(
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
                                                  "Save",
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
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/help@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Help & Support",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text('Create a ticket and we will,\n contact you',style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyPage(desc: privacy_policy)
                        )
                    );
                  });

                },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/privacy@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Privacy Policy",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text("How we work & use your data",style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
              InkWell(
                  onTap: (){

                  },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/rate us@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rate Us",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text("Tell us what you think",style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutSamrtCashPage(desc: about_smartcash))
                  );
                },

                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/about@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("About Smartcash",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text('Create to see full details \n about us',style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
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
                                          Text("Invite Friends",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 30,),
                                          Image.asset("images/invite-1@2x.png"),
                                          SizedBox(height: 30),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: w1Color,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(15),
                                                  child: Text(
                                                     "ga5usxcio90u97f",
                                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                                                  ),
                                                ),
                                                Expanded(child: SizedBox()),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(7),
                                                      color: sColor
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                                      child: Image.asset("images/copy@2x.png",height: 25),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30),

                                          RaisedButton(
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
                                                    "Share",
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

                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: p1Color,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/invite@2x.png",height: 30
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Invite Friends",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text("Earn more by inviting friends",style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: p1Color,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("images/logout@2x.png",height: 30
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: (){
                      respo.logout();
                      Fluttertoast.showToast(
                          msg:'Logged out successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: pColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Logout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        Text("Click to logout",style: TextStyle(fontSize: 16,)),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: SizedBox(height: 1,child: Container(decoration: BoxDecoration(color: Colors.grey)),),
              ),
              SizedBox(height: 10),


            ],
          ),
        ),
      ),

    );
  }
}
