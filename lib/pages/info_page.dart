import 'package:flutter/material.dart';

class infoPage extends StatefulWidget {
  const infoPage({Key key}) : super(key: key);

  @override
  _infoPageState createState() => _infoPageState();
}

class _infoPageState extends State<infoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text('Información'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/logogif.gif",
              height: 300,
            ),
          ),
          Center(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Text("FVAlquiler es una aplicación de Alquileres Gratuita para la Provincia de La Rioja con el fin de "
                        "facilitar la busqueda de Departamentos y Casas. Esta aplicacion esta disponible para el Sistema "
                        "Operativo Android. Actualmente se esta trabajando para que este disponible para Dispositivos con Sistema Operativo iOS como asi tambien "
                        "en la WEB "

                        )
                    )),
              )])
      );
  }
}
