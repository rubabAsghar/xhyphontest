import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhyphontest/view/screens/dropdown.dart';

import 'controller/surah-controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ... other app configurations
      home: QuranApp(),
    );
  }
}
