import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bs),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildFAQSection(context),
                buildContactInfoSection(context),
                SizedBox(height: 24),
                buildLogoImage(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget buildLogoImage() {
    return Center(
      child: Image.asset(
        'assets/images/app_logoa.png', // Replace with your image path
        width: 150, // Adjust width as needed
        height: 150, // Adjust height as needed
      ),
    );
  }

  Widget buildFAQSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.faq,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        buildFAQItem(
          AppLocalizations.of(context)!.ex,
          AppLocalizations.of(context)!.ey,
        ),
        buildFAQItem(
          AppLocalizations.of(context)!.ez,
          AppLocalizations.of(context)!.fa,
        ),
        buildFAQItem(
          AppLocalizations.of(context)!.fb,
          AppLocalizations.of(context)!.fc,
        ),

        buildFAQItem(
          AppLocalizations.of(context)!.ff,
          AppLocalizations.of(context)!.fh,
        ),

        buildFAQItem(
          AppLocalizations.of(context)!.fi,
          AppLocalizations.of(context)!.fj,
        ),
        buildFAQItem(
          AppLocalizations.of(context)!.fk,
          AppLocalizations.of(context)!.fl,
        ),
        buildFAQItem(
          AppLocalizations.of(context)!.fm,
          AppLocalizations.of(context)!.fn,
        ),

        buildFAQItem(
          AppLocalizations.of(context)!.fd,
          AppLocalizations.of(context)!.fe,
        ),
        // Add more FAQ items following this structure
      ],
    );
  }

  Widget buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget buildContactInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.fg,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('WhatsApp: +1210-204-4814'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email: info@Pedwuma.com'),
        ),
      ],
    );
  }
}
