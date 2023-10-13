import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../main.dart';
import '../Welcome/Components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  Future<void> _showLanguageSwitchDialog(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Handle action for selecting French
                  // Example: Change the app's language to French
                  MyApp.changeLocale(context, Locale('fr')); // Change to French
                  Navigator.of(context).pop();
                },
                child: Text('French'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle action for selecting English
                  // Example: Change the app's language to English
                  MyApp.changeLocale(context, Locale('en'));
                  Navigator.of(context).pop();
                },
                child: Text('English'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'Lan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12, // Adjust the font size as needed
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _showLanguageSwitchDialog(context);
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}
