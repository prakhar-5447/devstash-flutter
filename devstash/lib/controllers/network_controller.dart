import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController networktabController;
  var selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    networktabController = TabController(length: 3, vsync: this);

    networktabController.addListener(() {
      selectedTabIndex.value = networktabController.index;
    });
  }

  @override
  void onClose() {
    networktabController.dispose();
    super.onClose();
  }
}
