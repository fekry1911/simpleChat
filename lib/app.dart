import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/shared/local/cache_helper.dart';
import 'core/shared/network/messaging_config.dart';
import 'features/auth/presentation/login.dart';
import 'features/bottom_nav/presentaion/HomePage.dart';

import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MessagingConfig.initFirebaseMessaging();

    return MaterialApp(

      navigatorKey: navigatorKey,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //  brightness: Brightness.light,
        primarySwatch: Colors.green,
        // scaffoldBackgroundColor: const Color(0xFFF9F5EC),
        fontFamily: 'Kitab', // Add Kitab or Arabic-style font if available
        brightness: Brightness.dark,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green
        ),
      ),

      home:CacheHelper.getData(key: "login") != null
          ? Homepage()
          : LoginScreen(), //HomeScreen(),
    );
  }
}
