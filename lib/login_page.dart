
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/News.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Map <String,String> _authData = {

    'email':'',
    'password':''
  };
  
  signIn(String email, String password) async{
    Map data = {
      'email':email,
      'password':password
    };
    // var response = await http.get(Uri.https("www.getpostman.com", "collections/299632c9a18ed457ba78"));//API
    final response = await http.post(
        Uri.parse('https://nodejs-register-login-app.herokuapp.com/login'),body: data);

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      debugPrint(jsonData.toString());
      if(jsonData['Success']=="Success!"){
        setState(() {
          // sharedPreferences.setString("token",jsonData["token"]);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NewsPage()),(Route<dynamic> route) => false);

          String jsonsDataString = response.body.toString(); // toString of Response's body is assigned to jsonDataString
          data = jsonDecode(jsonsDataString);
          print(data.toString());

          print(response.body);

          print(jsonData);

        });
        print(jsonData['Success'].toString());

      } else {
        print(jsonData['Success'].toString());
      }

    }
    else{
      print(response);
      print(response.body);
    }
  }


  final GlobalKey<FormState> _formKey = GlobalKey();

  

  Future _submit()async{
    if(!_formKey.currentState.validate()){
      //invalid
      return;
    }

    _formKey.currentState.save();
  }

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

                  SizedBox(height: 130,),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),

                      ),
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment
                                .stretch,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Center(child: Text("Sign in",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25), )),

                            SizedBox(height: 20,),
                            TextFormField(
                                style: TextStyle(fontSize: 18.0,height: 1),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: "Email",
                                    border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),

                                    validator: (value){
                                  // ignore: missing_return
                                  if(value.isEmpty||!value.contains('@')){
                                    // ignore: missing_return
                                    return "Invalid Email";
                                  }
                                  return null;
                                    },

                              onSaved: (value){
                                  _authData['email'] = value;
                              },

                              controller: emailController,


                            ),

                              SizedBox(height: 15,),

                              TextFormField(
                                obscureText: true,
                                style: TextStyle(fontSize: 18.0,height: 1),

                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: "Password",
                                    border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                                    validator: (value){
                                  if(value.isEmpty || value.length<5){
                                    return 'Password is too short';
                                  }
                                  return null;
                                    },
                                onSaved: (value){
                                  _authData['password'] = value;
                                },

                                controller: passwordController
                              ),

                              SizedBox(height: 15,),

                              Align(child: Text("Forgot password?",style: TextStyle(color: Colors.blue[800]),),alignment: Alignment.centerRight,),

                              SizedBox(height: 10,),

                              // Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.all(Radius.circular(40)),
                              //     ),
                              //   child:
                              // ElevatedButton(child:Text("Sign in"),
                              //     onPressed: (){
                              //       _submit();
                              //     }),
                              // ),

                              // RaisedButton(
                              //   onPressed: (){
                              //   _submit();
                              //   } ,
                              //   color:Colors.blue,
                              //
                              //   shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(30)
                              //     ),
                              //   child: Text('Sign in',
                              //   style: TextStyle(color: Colors.white),),
                              //  ),



                                Padding(

                                  padding: EdgeInsets.only(left: 90,right: 90),
                                  child: FlatButton(
                                      onPressed: () async{

                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString('email', emailController.text);
                                    signIn(emailController.text,passwordController.text);
                                    print("click");
                                  },
                                      color: Colors.blue[400],

                                      shape: StadiumBorder(),
                                      child:Text('Sign in',
                                          style: TextStyle(color: Colors.white,fontSize: 20),)

                                  ),
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
                                  child: Divider(color: Colors.black,
                                height: 50,)),
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

                                  TextButton(
                                      onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> SignupPage()));
                                    },
                                      child: Text("Sign up",style: TextStyle(color: Colors.orange),)
                                  ),


                                  SizedBox(height: 10,)
                                ],
                              )
                            ]

                        ),
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
