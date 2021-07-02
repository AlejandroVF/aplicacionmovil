import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:proyecto/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(labelText: "Email:"),
                        validator: (String value) {
                          if (value.isEmpty) return 'Por Favor Ingrese un Mail';
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: controller.passwordController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration:
                        const InputDecoration(labelText: 'Contraseña:'),
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Ingrese una Contraseña Valida';
                          return null;
                        },
                        obscureText: true,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16.0),
                        alignment: Alignment.center,
                        child: SignInButton(
                          Buttons.Email,
                          text: "Iniciar Sesión",
                          onPressed: () async {
                            _.signInWithEmailAndPassword();
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16.0),
                        alignment: Alignment.center,
                        child: SignInButton(
                          Buttons.GoogleDark,
                          text: "Google",
                          onPressed: () async {
                            _.signInWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}