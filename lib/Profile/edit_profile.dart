import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cash/Profile/profile_main_page.dart';
import 'package:smart_cash/ui/cardpage.dart';
import 'package:smart_cash/ui/dashboard.dart';
import 'package:smart_cash/ui/exchangepage.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_cash/Wallet/wallet_page.dart';
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import 'package:smart_cash/Models/user_model.dart' as userModel;
import 'package:image_picker/image_picker.dart';

import '../Repository/user_repository.dart';
import '../constants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = '';
  String displayname = '';
  String location = '';
  String currency = '';
  String phonenumber = '';

  userModel.User user = new userModel.User();

  @override
  void initState() {
    super.initState();
    getData();
  }


  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      currentUser.value = userModel.User.fromJson(await json.decode(prefs.get('current_user').toString()));
    }
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
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    child: Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    textAlign: TextAlign.start,),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  get1stImage();
                },
                child: Container(
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _image1 == null ? Image.asset("images/profile-1@2x.png",height: 120,width: 120) : Image.file(File(_image1!.path),height: 120,width: 120,fit: BoxFit.cover,)
                          ),
                        ),
                        Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'images/edit (1)@2x.png',
                                    color: sColor,
                                    height: 20,),
                                )))
                      ],
                    ),
                    height: 160, width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    )
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 25),
                  Text("Name",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: w1Color
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                          child: TextField(
                              decoration: InputDecoration(
                                hintText: "User Name",
                                border: InputBorder.none
                              ),
                              onChanged: (value) => name = value,
                            ),
                        ),
                      ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 25),
                  Text("Display Name",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)),
                  Expanded(child: SizedBox()),
                  Container(
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: w1Color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Txtx",
                              border: InputBorder.none
                          ),
                          onChanged: (value) => displayname = value,
                        ),
                      ),
                    ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 25),
                  Text("Location",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: w1Color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "India",
                            border: InputBorder.none
                        ),
                        onChanged: (value) => location = value,
                      ),
                    ),
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 25),
                  Text("Currency",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: w1Color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Dollar (\$)",
                            border: InputBorder.none
                        ),
                        onChanged: (value) => currency = value,
                      ),
                    ),
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 25),
                  Text("Phone Number",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: w1Color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "+91123456789",
                            border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => phonenumber = value,
                      ),
                    ),
                  ),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(25),
                child: RaisedButton(
                  onPressed: () {
                    respo.updateuserdetails(respo.currentUser.value.id.toString(),name,_image1!.path, displayname, location, currency, phonenumber);
                    Timer(Duration(seconds: 2), (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileMainPage()),
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
                          "Save",
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
        ),
      ),

    );
  }
}
