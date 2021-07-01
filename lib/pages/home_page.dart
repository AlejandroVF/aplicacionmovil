import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/logogif.gif",
                height: 400,
              ),
            ),
            Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Colors.red[700],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textColor: Colors.white,
                            onPressed: ()=>Get.toNamed("/loginpage"),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Iniciar Sesión")]
                            ),
                          ),
                          SizedBox(height: 40),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Colors.red[700],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textColor: Colors.white,
                            onPressed: ()=> Get.toNamed("/registration"),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Registrarme")]
                            ),
                          ),


                        ],
                      )),
                ))
          ],
        ));
  }
}
