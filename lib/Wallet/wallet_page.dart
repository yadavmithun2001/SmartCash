import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cash/Wallet/view_wallet.dart';
import 'package:smart_cash/Wallet/wallet_address_page.dart';
import 'package:smart_cash/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import 'package:smart_cash/Models/user_model.dart' as userModel;
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  String otp = '';
  bool isCodeSent = false;
  late String _verificationId;
  bool _showotpdialog = true;
  String _phonenumber = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<userModel.User> _users = [];
  userModel.User currentuser = new userModel.User();
  
  @override
  void initState() {
    super.initState();
    setState(() {
      respo.getallusers().then((value){
        setState(() {
          _users.addAll(value);
        });
      });
    });

  }

  void checkuser() {
    if(_firebaseAuth.currentUser != null){
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => WalletAdddressPage()
          )
      );
    }
  }

  Future<void> matcuser() async {
    setState(() {
      for(int i=0;i<_users.length;i++){
        if(_users[i].id.toString() == respo.currentUser.value.id.toString()){
          currentuser = _users[i];
          setCurrentUser(json.encode(currentuser));
          getaddress();
        }
      }
    });
  }

  void getaddress(){
    if(currentuser.delivery_address.toString() == 'null'){
      newAddress();
    }
  }


  void setCurrentUser(jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
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
      respo.postaddressdetails(respo.currentUser.value.id.toString(), address, privatekey, hexaddress);
    } else {
      throw new Exception(response.body);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    matcuser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 100),
          Image.asset("images/wallet@2x.png"),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(25),
            child: RaisedButton(
              onPressed: () {

                if(_firebaseAuth.currentUser != null){
                  checkuser();
                }else{
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
                                      topLeft: Radius.circular(20)
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25.0, 40, 25, 140
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: w1Color,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left : 0,
                                                    bottom: 0,
                                                    top: 0,
                                                    child: Container(
                                                        decoration : BoxDecoration(
                                                            color: pColor,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(5),
                                                          child: Image.asset("images/call@2x.png",height: 20),
                                                        )
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                                                    child: TextField(
                                                        keyboardType: TextInputType.number,
                                                        onChanged:(value) => _phonenumber = value,
                                                        decoration: InputDecoration(
                                                            hintText: 'Mobile Number',
                                                            border: InputBorder.none
                                                        )
                                                        ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 50),
                                          RaisedButton(
                                            onPressed: () {
                                              if(_phonenumber.length == 10){
                                                _onVerifyCode();
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
                                                                    topLeft: Radius.circular(20)
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(
                                                                    25.0, 20, 25, 120),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("Enter OTP sent to "+_phonenumber,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                                        SizedBox(height: 20),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: w1Color,
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: Stack(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(15, 3, 5, 3),
                                                                                child: TextField(
                                                                                  keyboardType: TextInputType.number,
                                                                                  onChanged: (value) => otp = value,
                                                                                  decoration: InputDecoration(
                                                                                      hintText: 'Enter 6 digit OTP',
                                                                                      border: InputBorder.none
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 50),

                                                                        RaisedButton(
                                                                          onPressed: () {
                                                                            if(otp.length == 6){
                                                                              _onFormSubmitted(otp);
                                                                            }else{
                                                                              setSnackbar('Please enter Valid OTP');
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
                                                                                  "Verify OTP",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
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
                                              }else{
                                                setSnackbar('please enter valid Phone Number');
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
                                                    "Send OTP",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
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
                      "View Wallet",
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
    );
  }


  setSnackbar(String msg) {
    Fluttertoast.showToast(
        msg: msg,
       backgroundColor: pColor,
       textColor: Colors.white

    );
  }

  void _onVerifyCode() async {
    if (mounted) {
      setState(() {
        isCodeSent = true;
      });
    }
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      _firebaseAuth.signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          setSnackbar('OTP Sent Successfully');
        } else {
          setSnackbar('OTP Error');
        }
      }).catchError((error) {
        setSnackbar(error.toString());
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      if (mounted) {
        setState(() {
          isCodeSent = false;
        });
      }
    };

    final PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
      if (mounted) {
        setState(() {
          _verificationId = verificationId;
          _showotpdialog = true;
        });
      }
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      if (mounted) {
        setState(() {
          _verificationId = verificationId;
        });
      }
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91"+_phonenumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );
  }

  void _onFormSubmitted(String code){
      AuthCredential _authCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: code);
      _firebaseAuth.signInWithCredential(_authCredential).then((UserCredential value) async {
        if (value.user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewWalletPage()));
        } else {
          setSnackbar('something went wrong');
        }
      }).catchError((error){
        setSnackbar(error.toString());
      });
  }
}

