import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'ProfilePage.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    _checkUserProfile();
    super.initState();
  }

  _checkUserProfile() async
  {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) 
    {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context) => ProfilePage(user)
        )
      );
    } 
  }

  Future _login() async
  {
    String email = emailController.text.trim();
    String pass = passController.text.trim();

    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    ))
    .user;

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(user)
      )
    );
  }

  Future _loginWithGoogle() async
  {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(user)
      )
    ); 
  }

  void _loginWithFacebook() async
  {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email', "public_profile"]);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token
        );

        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(user)
          )
        );  
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        print("error: ${result.errorMessage}");
        break;
    }    
  }

  void _goToSignupPage() => Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (BuildContext context) => SignupPage()
    )
  );

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

                // app logo start
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
                // app logo end

                Container(height: 15,),

                // email input field start
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                // email input field end

                Container(height: 10,),

                // password input field start
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
                // password input field end

                Container(height: 30,),

                // login btn start
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _login,
                ),
                // login btn end

                // or line start
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(

                    children: <Widget>[

                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.black26,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text("OR"),
                      ),

                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.black26,
                        ),
                      ),

                    ],
                  ),
                ),
                // or line end

                // login with google start
                MaterialButton(
                  color: Color(0xFFEAF0F1),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.redAccent,
                      ),

                      Container(width: 15,),

                      Text(
                        "Login with google",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  onPressed: _loginWithGoogle,
                ),
                // login with google end

                Container(height: 10,),

                // login with facebook start
                MaterialButton(
                  color: Color(0xFF405d9b),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),

                      Container(width: 15,),

                      Text(
                        "Login with Facebook",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: _loginWithFacebook,
                ),
                // login with facebook end

                Divider(height: 35, thickness: 2,),

                // create new accout start
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "Don't have an accont?",
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
                        "Create",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: _goToSignupPage,
                    ),
                  ],
                ),
                // create new accout end

              ],
            ),
          ),
        ),
      ),
    );
  }
}