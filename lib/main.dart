import 'package:Hungry_App/splach.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async {
// عشان الدوران و التلفون ميلفش
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ]
  );

  // Widget widget;
  // var onBoarding = CacheHelper.getData(key: 'onBoarding') ;
  // var description = CacheHelper.getData(key: 'description') ;
  //
  // if(onBoarding !=null)
  // {
  //   if(description!=null) widget= ShopLayout();
  //   else widget =ShopLoginscreen();
  // }else {
  //   widget =onBoarding();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:Splachview(),
    );
  }
}

