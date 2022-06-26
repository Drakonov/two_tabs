import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'home/screens_bloc/screens_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        fontFamily: 'Proxima Nova',
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          //backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(color: Colors.orange),
          toolbarTextStyle: TextStyle(color: Colors.orange),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
      },
      initialRoute: '/home',
      title: "Здоровье Лайт",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
        //Locale('en', ''),
      ],
    );
  }
}
