import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future _signUp() async
  {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();

    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );

    Navigator.pop(context);
  }

  void _goToLoginPage() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.palette,
                        size: 120,
                        color: Theme.of(context).accentColor,
                      ),

                      Text(
                        "Art Work",
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(height: 15,),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                ),

                Container(height: 10,),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),

                Container(height: 10,),

                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),

                Container(height: 30,),

                MaterialButton(
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _signUp,
                ),

                Divider(height: 35, thickness: 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "Already have an accont",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),

                    Container(width: 10),

                    MaterialButton(
                      
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: _goToLoginPage,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}