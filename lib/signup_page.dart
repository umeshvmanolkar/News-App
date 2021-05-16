
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    var ui;
    return MaterialApp(
      home: Scaffold(
          body:Container(

            decoration: BoxDecoration(image:
            DecorationImage(
              image: AssetImage("images/tea_back.png"),
              fit: BoxFit.cover,
            )),

            child:SingleChildScrollView(
              child: Column(
                  children:[
                    SizedBox(height: 150,),

                    Container(

                        padding: EdgeInsets.only(left: 35),
                        child: Align(
                          child: Text("Welcome!!",
                              style:TextStyle(
                                  color: Colors.white,
                                  fontSize:35,
                                  fontWeight: FontWeight.bold
                              )),alignment: Alignment.topLeft,
                        )),

                    SizedBox(height: 95,),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Center(child: Text("Sign Up",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25), )),

                                SizedBox(height: 20,),
                                TextField(
                                  style: TextStyle(fontSize: 18.0,height: 1),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Email",
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                                ),

                                SizedBox(height: 15,),

                                TextField(

                                  style: TextStyle(fontSize: 18.0,height: 1),

                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Password",

                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                                  obscureText: true,
                                ),

                                SizedBox(height: 15,),

                                TextField(

                                  style: TextStyle(fontSize: 18.0,height: 1),

                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Re-enter Password",

                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                                  obscureText: true,
                                ),

                                SizedBox(height: 10,),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child:
                                  ElevatedButton(child:Text("Sign in"),
                                      onPressed: (){}),
                                ),


                                SizedBox(height: 10,),

                                Row( children:[

                                  Expanded( child:
                                  Container(
                                      margin: const EdgeInsets.only(left: 10, right: 15),
                                      child: Divider(color: Colors.black, height: 50,)),
                                  ),

                                  Text("Or Sign In With"),

                                  Expanded( child:
                                  Container(
                                      margin: const EdgeInsets.only(left: 15, right: 10),
                                      child: Divider(color: Colors.black,height: 50,)),
                                  ),
                                ],),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Image(image: AssetImage("images/google_logo.png"),height: 50,width: 50,),

                                    SizedBox(width: 10,),

                                    Image(image: AssetImage("images/facebook_logo.png"),height: 50,width: 50,)
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account?"),

                                    Text(" Sign up",style: TextStyle(color: Colors.orange),),

                                    SizedBox(height: 10,)
                                  ],
                                )
                              ]

                          ),
                        )
                    )
                  ]
              ),
            ),
          )
      ),
    );
  }
}