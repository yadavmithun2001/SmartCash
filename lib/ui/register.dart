import 'package:flutter/material.dart';
import 'package:smart_cash/ui/home.dart';
import 'package:smart_cash/ui/home_tab_controller.dart';
import 'package:smart_cash/Repository/user_repository.dart' as respo;
import 'package:smart_cash/ui/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int selected = 0;
  String email = '';
  String password ='';
  String cnfpassword = '';

  bool isLoading = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset(
                          "images/Group 38@3x.png",
                          height: 100,
                          width: 200,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: pColor,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "images/vuesax-linear-sms@2x.png",
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Email Id",
                                        border: InputBorder.none),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) => email = value
                                ),

                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: pColor,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "images/vuesax-linear-key@2x.png",
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        border: InputBorder.none),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  onChanged: (value) => password = value ,
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: pColor,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "images/vuesax-linear-key@2x.png",
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        border: InputBorder.none),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  onChanged: (value) => cnfpassword = value ,
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );

                            },
                            child: Text("Forgot Password?", style: TextStyle(color: pColor),))),
                    SizedBox(
                      height: 30,
                    ),

                    isLoading ?  Center(child: CircularProgressIndicator(color: sColor)) : RaisedButton(
                      onPressed: () {
                        setState(() {

                          if(email.isEmpty){
                            Fluttertoast.showToast(
                                msg: "Email Can't be Empty",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else if(password.isEmpty){
                            Fluttertoast.showToast(
                                msg: "Password Can't be Empty",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else if(!email.contains('@')){
                            Fluttertoast.showToast(
                                msg: "Enter valid Email ID ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else if(password.length < 6){
                            Fluttertoast.showToast(
                                msg: "Password should contain 6 characters",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else if(cnfpassword.length < 6){
                            Fluttertoast.showToast(
                                msg: "Confirm Password should contain 6 characters",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else if(password!=cnfpassword){
                            Fluttertoast.showToast(
                                msg: "Password and Confirm Password doesn't match",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else {
                            isLoading = true;
                            respo.register(email, password).then((value){
                              message = value;
                            });
                            if(message=='Success'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            }else{
                              isLoading = false;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            }

                          }

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
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )),
                    ),

                    Expanded(child: SizedBox()),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ",
                          style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: pColor,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
