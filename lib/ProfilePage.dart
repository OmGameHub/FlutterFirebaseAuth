import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginPage.dart';

class ProfilePage extends StatefulWidget {

  final FirebaseUser user;

  ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState(this.user);
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseUser user;

  _ProfilePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage('https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
            ),

            Container(height: 15,),

            Text(
              user.email,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(height: 30,),

            // login btn start
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _logout,
              ),
            ),
            // login btn end

          ],
        ),
      ),
    );
  }

  void _logout()
  {
    FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage()
      )
    );
  }
}