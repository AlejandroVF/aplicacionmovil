import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:proyecto/routes/my_routes.dart';
import 'package:proyecto/services/firebase_services.dart';

import 'models/productos_model.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    navigatorKey: Get.key,
    getPages: routes(),
  ));
}


