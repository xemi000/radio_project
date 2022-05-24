import 'package:flutter/material.dart';

import 'radio_page.dart';

class FavRadiosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: RadioPage(
        isFavouriteOnly: true,
      ),
    );
  }
}
