import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamma_keep/Constants/color.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(seconds: 20),
            () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kCardColor.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("assets/appIcon.png"),
                    height: 150.0,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "Gamma Notes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 25.0
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
