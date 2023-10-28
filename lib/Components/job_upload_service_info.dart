import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Models/category.dart';
import '../constants.dart';

class JobUploadServiceInfo extends StatefulWidget {
  bool isReadOnly;
  String serviceProvided;
  final TextEditingController chargeController;
  JobUploadServiceInfo({
    Key? key,
    required this.chargeController,
    this.serviceProvided = '',
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<JobUploadServiceInfo> createState() => _JobUploadServiceInfoState();
}

class _JobUploadServiceInfoState extends State<JobUploadServiceInfo> {
  Future getCategoryData(String categoryName) async {
    final document = await FirebaseFirestore.instance
        .collection('Category')
        .where('Category Name', isEqualTo: categoryName)
        .get();

    if (document.docs.isNotEmpty) {
      final category = document.docs.single.data();
      final $categoryName = CategoryData(
          categoryName: category['Category Name'],
          servicesProvided: List<String>.from(category['Services Provided']));

      setState(() {
        servicesProvided = $categoryName.servicesProvided;
        serviceProvHintText = servicesProvided[0];
        servicesProvided.sort();
      });
    } else {
      print('Item not found.');
    }
  }

  @override
  void initState() {
    getCategoryData(serviceCatHintText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: screenWidth * 5.0, right: 10 * screenWidth),
          child: Text(
            AppLocalizations.of(context)!.servinfo,
            style: TextStyle(
              color: black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 13 * screenHeight),
        Container(
          constraints: BoxConstraints(
            minHeight: 422 * screenHeight,
          ),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ServiceCategorySelect(
                isReadOnly: widget.isReadOnly,
                title: AppLocalizations.of(context)!.eq,
                dropdownList: allCategoriesName.toSet().toList(),
                hintText: serviceCatHintText,
                onChanged: (newValue) {
                  setState(() {
                    getCategoryData(newValue);
                    serviceProvHintText = servicesProvided[0];
                    serviceCatHintText = newValue;
                  });
                },
              ),
              SizedBox(height: 20 * screenHeight),
              ServiceCategorySelect(
                isReadOnly: widget.isReadOnly,
                title: AppLocalizations.of(context)!.er,
                dropdownList: servicesProvided.toList(),
                hintText: widget.isReadOnly
                    ? widget.serviceProvided
                    : serviceProvHintText,
                onChanged: (newValue) {
                  setState(() {
                    serviceProvHintText = newValue;
                  });
                },
              ),
              SizedBox(height: 20 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    isHintText: chargeHintText == '0' ? true : false,
                    isReadOnly: widget.isReadOnly,
                    controller: widget.chargeController,
                    title: 'Charge',
                    hintText: chargeHintText == '0'
                        ? '...'
                        : chargeHintText.toString(),
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 73,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 1.0, left: 10 * screenWidth),
                    child: Container(
                      height: 47 * screenHeight,
                      width: 40 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '\$',
                          style: TextStyle(
                            color: primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 1.0),
                    child: ServiceCategorySelect(
                      isReadOnly: widget.isReadOnly,
                      title: 'Charge per',
                      width: 117,
                      dropdownList: chargePerList,
                      hintText: chargePHint,
                      onChanged: (newValue) {
                        setState(() {
                          chargePHint = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 2),
                ],
              ),
              SizedBox(height: 20 * screenHeight),
              ServiceCategorySelect(
                isReadOnly: widget.isReadOnly,
                title: AppLocalizations.of(context)!.es,
                dropdownList: expertiseList,
                hintText: expertHint,
                onChanged: (newValue) {
                  setState(() {
                    expertHint = newValue;
                  });
                },
              ),
              SizedBox(height: 10 * screenHeight),
            ],
          ),
        ),
      ],
    );
  }
}
