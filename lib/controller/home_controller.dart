import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/model.dart';

class HomeController extends GetxController {
  Rx<IncomFoods> incomFoods = IncomFoods(tblIncompatibleFood: []).obs;
  RxBool isLoading = true.obs;
  RxString error = ''.obs;
  RxString searchQuery = ''.obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      error.value = '';
      final String jsonString =
          await rootBundle.loadString('assets/incom_food.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      incomFoods.value = IncomFoods.fromJson(jsonData);
    } catch (e) {
      error.value = 'Error fetching data: $e';
      Get.snackbar('Error', error.value, snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
    update(); // Notify UI to rebuild
  }

  List<TblIncompatibleFood> get filteredFoods {
    if (searchQuery.value.isEmpty) {
      return incomFoods
          .value.tblIncompatibleFood; 
    } else {
      return incomFoods.value.tblIncompatibleFood
          .where((food) =>
              food.foodA
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              food.foodB
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              food.description
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }
}
