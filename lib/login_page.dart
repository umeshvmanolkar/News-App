
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

  
  logIn(String email, String password) async{
    Map data = {
      'email':email,
      'password':password
    };

    final response = await http.post(Uri.parse('https://nodejs-register-login-app.herokuapp.com/login'),body: data);  //API response

    if(response.statusCode == 200){            //checking status of API

      var jsonData = json.decode(response.body);

      if(jsonData['Success']=="Success!"){                                    //validating user login credentials
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);                                      //Storing user email id into shared preferences

        setState(() {
          _isLoading = false;

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NewsPage()),(Route<dynamic> route) => false);       //opening news.dart page
          String jsonsDataString = response.body.toString(); // toString of Response's body is assigned to jsonDataString
          data = jsonDecode(jsonsDataString);

        });

      } else {

      }
    } else{

    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator(),): MaterialApp(
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
                              Center(child: Text("Sign in",style: TextStyle(color:Colors.blue[900],fontWeight:FontWeight.bold,fontSize: 25), )),

                            SizedBox(height: 20,),

                            TextFormField(

                                decoration: InputDecoration(
                                    hintText: "Email:",
                                    hintStyle: TextStyle(color: Colors.white,fontSize: 18),
                                  filled: true,
                                    fillColor: Colors.brown[300],
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

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
                              controller: emailController,
                            ),

                              SizedBox(height: 13,),

                              TextFormField(
                                obscureText: true,
                                style: TextStyle(fontSize: 18.0,height: 1),

                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintStyle: TextStyle(color: Colors.white,fontSize: 18),
                                    filled: true,
                                    fillColor: Colors.brown[300],
                                    hintText: "Password:",
                                    border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                                    validator: (value){
                                  if(value.isEmpty || value.length<5){
                                    return 'Password is too short';
                                  }
                                  return null;
                                    },

                                controller: passwordController
                              ),

                              SizedBox(height: 15,),

                              Align(child: Text("Forgot password?",style: TextStyle(color: Colors.blue[800]),),alignment: Alignment.centerRight,),

                              SizedBox(height: 10,),

                                Padding(

                                  padding: EdgeInsets.only(left: 90,right: 90),
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      onPressed: () async{
                                        setState(() {
                                          _isLoading = true;
                                        });
                                           if (_formKey.currentState.validate()) {
                                             if (emailController.text.contains("@") &&
                                                 emailController.text.isNotEmpty) {

                                               logIn(emailController.text,
                                                   passwordController.text);
                                             }
                                             else {
                                               print("invalid email");
                                             }
                                           }
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
                                  margin: const EdgeInsets.only(left: 25, right: 10),
                                  child: Divider(color: Colors.grey, height: 50,)),
                                  ),

                                  Text("Or Sign In With",style: TextStyle(fontWeight: FontWeight.bold),),

                                  Expanded( child:
                                  Container(
                                  margin: const EdgeInsets.only(left: 10, right: 25),
                                  child: Divider(color: Colors.grey,
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
