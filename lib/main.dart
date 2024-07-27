import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:handyman_app/Screens/Splash/splash_screen.dart';
import 'package:handyman_app/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Screens/Login/login_screen.dart';

//var publicKey = 'pk_test_caf898bc3a14e3b6c7bd997dd1828c8469726c63';
//final plugin = PaystackPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await plugin.initialize(publicKey: publicKey);
  await Firebase.initializeApp();

  //var result = PaystackPlugin().sdkInitialized;
  //print(result);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  // Define a static method to change the app's locale
  static void changeLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state._changeLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  // Future<void> initializedPaystack() async {
  //   await plugin.initialize(publicKey: publicKey);
  // }
  Locale _currentLocale = Locale('en');
  void _changeLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedwuma',
      locale: _currentLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en'),//English
        Locale('fr'),//French
      ],
      home: const SplashScreen(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: primary,
        ),

        appBarTheme: AppBarTheme(
          color: white,
          elevation: 0.0,
        ),
        fontFamily: 'Inter',

      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        // Add other routes as needed
      },
    );

    // return FutureBuilder(
    //   future: initializedPaystack(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MaterialApp(
    //         title: 'HomeCareX',
    //         home: const SplashScreen(),
    //         color: Colors.white,
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //           primaryColor: primary,
    //           datePickerTheme: DatePickerThemeData(
    //             headerBackgroundColor: primary,
    //           ),
    //           appBarTheme: AppBarTheme(
    //             color: white,
    //             elevation: 0.0,
    //           ),
    //           fontFamily: 'Inter',
    //           backgroundColor: white,
    //         ),
    //       );
    //     } else {
    //       return const CircularProgressIndicator(); // or any other loading widget
    //     }
    //   },
    // );
  }

}
