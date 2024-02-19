import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Upload/Handyman/Components/body.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Handyman/handyman_job_upload_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Components/default_back_button.dart';
import '../../../constants.dart';

class HandymanJobUploadScreen extends StatelessWidget {
  const HandymanJobUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          AppLocalizations.of(context)!.profileupload,
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HandymanJobUploadList(),
                  ),
                );
              },
              icon: Icon(
                Icons.list_rounded,
              ),
              color: primary,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: EdgeInsets.only(right: 20 * screenWidth)),
        ],
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}
