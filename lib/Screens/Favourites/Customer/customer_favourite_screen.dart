import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/constants.dart';

import '../../Favourites/Customer/Components/body.dart';

class CustomerFavouritesScreen extends StatelessWidget {
  const CustomerFavouritesScreen({Key? key}) : super(key: key);

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
