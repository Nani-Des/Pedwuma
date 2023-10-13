import 'package:flutter/material.dart';

import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import '../../Favourites/Handyman/Components/body.dart';

class HandymanFavouritesScreen extends StatelessWidget {
  const HandymanFavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        elevation: 0.0,
        backgroundColor: white,
        title: Text(
          'Favourites',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}
