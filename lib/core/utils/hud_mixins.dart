import 'package:flutter/material.dart';

mixin HudMixins {
  showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  navigateThenUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  navigateRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
