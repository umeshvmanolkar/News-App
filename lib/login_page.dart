
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map <String,String> _authData = {

    'email':'',
    'password':''
  };

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
                              ),

                              SizedBox(height: 15,),

                              Align(child: Text("Forgot password?",style: TextStyle(color: Colors.blue[800]),),alignment: Alignment.centerRight,),

                              SizedBox(height: 10,),

                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                child:
                              ElevatedButton(child:Text("Sign in"),
                                  onPressed: (){
                                    _submit();
                                  }),
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
