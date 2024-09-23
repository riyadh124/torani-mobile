import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torani/app/data/invetoryItem.dart';
import 'package:torani/app/data/service_provider.dart';

class TakeStockController extends GetxController {
  //TODO: Implement TakeStockController

  var inventoryItems = <InventoryItem>[].obs;
  var filteredItems = <InventoryItem>[].obs; // List to hold filtered items
  var isLoading = false.obs;
  TextEditingController notesController = TextEditingController();
  TextEditingController searchController =
      TextEditingController(); // Controller for search input

  @override
  void onInit() {
    super.onInit();
    fetchInventoryItems();
    searchController.addListener(search); // Attach listener to search
  }

  void fetchInventoryItems() async {
    try {
      isLoading(true);
      var returnData = await ServiceProvider().getProducts();
      List data = returnData[0]["products"];
      print("data: ${data.length}");
      if (data.length > 0) {
        inventoryItems.value =
            data.map((item) => InventoryItem.fromJson(item)).toList();

        print("inventoryItems.value: ${inventoryItems.value}");

        filteredItems.assignAll(inventoryItems);
      } else {
        Get.snackbar('Error', 'Failed to fetch inventory items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch inventory items');
    } finally {
      isLoading(false);
    }
  }

  void search() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredItems.assignAll(inventoryItems);
    } else {
      filteredItems.assignAll(inventoryItems
          .where((item) => item.name.toLowerCase().contains(query))
          .toList());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
