import 'package:flutter/material.dart';

void showModal(BuildContext context, WidgetBuilder builder) {
  Navigator.push(
      context, MaterialPageRoute(builder: builder, fullscreenDialog: true));
}
