import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/modules/SignIn.dart';

import '../modles/Google_SignIn.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body:
    Container(height: double.infinity,width: double.infinity,color: Colors.greenAccent,
    child: Center(child: MaterialButton(
        onPressed: (){
GoogleSignInAuth.signOut();
Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
        },
      child: Text("Sign Out"),
    )
      ,
    ),
    )
    )
    );
  }
}
