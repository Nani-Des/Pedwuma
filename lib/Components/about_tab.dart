// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/services_tab.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class AboutTab extends StatelessWidget {
  bool isCustomerSection;
  AboutTab({
    Key? key,
    this.isCustomerSection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 5.0, bottom: 20 * screenHeight),
            child: Text(
              AppLocalizations.of(context)!.cat,
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          ServicesTab(text: allJobItemList[0].jobCategory),
          SizedBox(height: 5 * screenHeight),
          isCustomerSection
              ? Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 5.0,
                      bottom: 20 * screenHeight,
                      top: 10 * screenHeight),
                  child: Text(
                    AppLocalizations.of(context)!.bi,
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                )
              : SizedBox(),
          isCustomerSection
              ? AdditionalInfo(
                  text: 'Experience',
                  fileName: allJobItemList[0].experience,
                )
              : SizedBox(),
          isCustomerSection ? SizedBox(height: 8 * screenWidth) : SizedBox(),
          isCustomerSection
              ? AdditionalInfo(
                  text: AppLocalizations.of(context)!.cert,
                  fileName: allJobItemList[0].certification,
                )
              : SizedBox(),
          isCustomerSection ? SizedBox(height: 8 * screenWidth) : SizedBox(),
          isCustomerSection
              ? AdditionalInfo(
                  text: AppLocalizations.of(context)!.ref,
                  fileName: allJobItemList[0].references,
                )
              : SizedBox(),
          isCustomerSection
              ? Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 5.0,
                      bottom: 20 * screenHeight,
                      top: 15 * screenHeight),
                  child: Text(

                    '${AppLocalizations.of(context)!.ax}: ${allJobItemList[0].jobsDone}',
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
