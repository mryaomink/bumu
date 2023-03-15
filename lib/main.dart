import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guest_book/screens/guest_book.dart';
import 'package:guest_book/screens/yao_form.dart';
import 'package:get_it/get_it.dart';
import 'package:guest_book/screens/yao_splash.dart';
import 'package:guest_book/service/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCoqS5zzxxW_5KB0Q83yv7iutRfZtlFP6Q",
          appId: "1:207931931442:web:624039375ac597639cf52b",
          storageBucket: "diskominfo-bjb-app.appspot.com",
          messagingSenderId: "207931931442",
          projectId: "diskominfo-bjb-app"));
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Tamu Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.amber,
      ),
      initialRoute: 'guest',
      routes: {
        'splash': (context) => const YaoSplash(),
        'input': (context) => const YaoForm(),
        'guest': (context) => const GuestBook(),
      },
    );
  }
}
