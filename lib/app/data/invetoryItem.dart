import 'package:get/get_connect/http/src/request/request.dart';

class InventoryItem {
  final int id;
  final String name;
  int quantity; // The stock quantity
  int selectedQuantity; // Quantity to be stocked out
  String thumbnail;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.thumbnail,
    this.selectedQuantity = 0,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
        id: json['id'],
        name: json['name'],
        quantity: json['stock_quantity'],
        thumbnail: json["thumbnail"] ?? "");
  }
}
