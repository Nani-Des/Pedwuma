import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Services/storage_service.dart';
import '../constants.dart';
import 'add_file_item.dart';

class JobUploadWorkCertInfo extends StatefulWidget {
  bool isRegistration;
  bool isReadOnly;
  bool isHandyManUpload;
  JobUploadWorkCertInfo({
    Key? key,
    this.isHandyManUpload = false,
    this.isRegistration = false,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<JobUploadWorkCertInfo> createState() => _JobUploadWorkCertInfoState();
}

class _JobUploadWorkCertInfoState extends State<JobUploadWorkCertInfo> {
  Storage storage = Storage();

  Future addPortfolio() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );

    if (result != null) {
      setState(() {
        resultList = result;
        result.files.forEach((file) {
          final fileName = file.name;
          if (!uploadPortfolioList.contains(fileName)) {
            uploadPortfolioList.add(fileName);
          } else {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black45,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Center(
                      child: Text(
                        '$fileName ${AppLocalizations.of(context)!.at}',
                        style: TextStyle(height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                    )),
              );
            });
          }
        });
      });
    }
  }

  Future addCertification() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        resultCertList = result;
        result.files.forEach((file) {
          final fileName = file.name;
          if (!uploadCertList.contains(fileName)) {
            uploadCertList.add(fileName);
          } else {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black45,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Center(
                      child: Text(
                        '$fileName ${AppLocalizations.of(context)!.at}',
                        style: TextStyle(height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                    )),
              );
            });
          }
        });
      });
    }
  }

  Future addExperience() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        resultExperienceList = result!;
        result.files.forEach((file) {
          final fileName = file!.name;
          if (!uploadExperienceList.contains(fileName)) {
            uploadExperienceList.add(fileName);
          } else {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black45,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Center(
                      child: Text(
                        '$fileName ${AppLocalizations.of(context)!.at}',
                        style: TextStyle(height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                    )),
              );
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.isHandyManUpload
                    ? 'Work Experience & Certification'
                    : 'Work Details & Rating',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 13 * screenHeight),
        Container(
          constraints: BoxConstraints(minHeight: 120),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.isHandyManUpload
                  ? AddFileItem(
                      directory: 'Certification',
                      isReadOnly: widget.isReadOnly,
                      selectedOptions: uploadCertList,
                      screen: addCertification,
                      title: AppLocalizations.of(context)!.cert,
                      hintText: AppLocalizations.of(context)!.au,
                    )
                  : AddFileItem(
                      directory: 'Portfolio',
                      isReadOnly: widget.isReadOnly,
                      selectedOptions: uploadPortfolioList,
                      screen: addPortfolio,
                      title: AppLocalizations.of(context)!.portfolio,
                      hintText: AppLocalizations.of(context)!.av,
                    ),
              widget.isHandyManUpload
                  ? SizedBox(height: 20 * screenHeight)
                  : SizedBox(),
              widget.isHandyManUpload
                  ? AddFileItem(
                      directory: 'Experience',
                      isReadOnly: widget.isReadOnly,
                      selectedOptions: uploadExperienceList,
                      title: AppLocalizations.of(context)!.exp,
                      hintText: AppLocalizations.of(context)!.aw,
                      screen: addExperience,
                    )
                  : SizedBox(),
              SizedBox(height: 20 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    isReadOnly: widget.isReadOnly,
                    isOverallRating: true,
                    title: AppLocalizations.of(context)!.rating,
                    hintText: '4.7',
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 140,
                  ),
                  SizedBox(width: 20 * screenWidth),
                  widget.isHandyManUpload
                      ? ProfileItem(
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5)
                          ],
                          isHintText: false,
                          title: AppLocalizations.of(context)!.ax,
                          hintText: jobTotalHintText.toString(),
                          keyboardType: TextInputType.number,
                          isWidthMax: false,
                          width: 139,
                        )
                      : SizedBox(),
                ],
              ),
              widget.isHandyManUpload
                  ? widget.isRegistration
                      ? SizedBox()
                      : SizedBox(height: 20 * screenHeight)
                  : SizedBox(),
              widget.isHandyManUpload
                  ? widget.isRegistration
                      ? SizedBox()
                      : AddFileItem(
                          directory: 'References',
                          isReadOnly: widget.isReadOnly,
                          selectedOptions: uploadReferenceList,
                          screen: () {
                            setState(() {});
                          },
                          title: AppLocalizations.of(context)!.ref,
                          hintText: AppLocalizations.of(context)!.ay,
                        )
                  : SizedBox(),
              widget.isHandyManUpload
                  ? widget.isRegistration
                      ? SizedBox()
                      : SizedBox(height: 20 * screenHeight)
                  : SizedBox(),
              widget.isHandyManUpload
                  ? widget.isRegistration
                      ? SizedBox()
                      : AddFileItem(
                          directory: 'Portfolio',
                          isReadOnly: widget.isReadOnly,
                          selectedOptions: uploadPortfolioList,
                          screen: addPortfolio,
                          title: AppLocalizations.of(context)!.portfolio,
                          hintText: AppLocalizations.of(context)!.av,
                        )
                  : SizedBox(),
              SizedBox(height: 10 * screenHeight),
            ],
          ),
        ),
      ],
    );
  }
}
