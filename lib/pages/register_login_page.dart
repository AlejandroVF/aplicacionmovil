import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/controllers/register_login_controller.dart';

class RegisterLoginPage extends StatelessWidget {
  final controller = Get.put(LoginRegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginRegisterController>(
        init: LoginRegisterController(),
        builder: (_) {
          return Form(
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
                      decoration: const InputDecoration(labelText: 'Email:'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Ingrese eMail';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      decoration: const InputDecoration(labelText: 'Contraseña:'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Ingrese Contraseña';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.red[700],
                        child: Text('Registrarse', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          _.register();
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(controller.success == null
                          ? ''
                          : (controller.success
                          ? 'Registrado Exitosamente ' +
                          controller.userEmail
                          : 'Fallo al Registrarse')),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}