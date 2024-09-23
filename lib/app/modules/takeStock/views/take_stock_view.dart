import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torani/app/components/dialog.dart';
import 'package:torani/app/components/loading.dart';
import 'package:torani/app/data/service_provider.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/widgets/button.dart';
import 'package:torani/app/widgets/text.dart';

import '../controllers/take_stock_controller.dart';

class TakeStockView extends GetView<TakeStockController> {
  TakeStockView({Key? key}) : super(key: key);
  TakeStockController controller = Get.put(TakeStockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        title: CText(
          'Stok Keluar',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  labelText: 'Cari Produk',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.filteredItems.length,
                itemBuilder: (context, index) {
                  var item = controller.filteredItems[index];
                  return ListTile(
                    leading: Container(
                      clipBehavior: Clip.hardEdge,
                      child: item.thumbnail != ""
                          ? Image.network(
                              "https://pink-reindeer-116090.hostingersite.com/public/storage/${item.thumbnail}",
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.fastfood,
                              color: Colors.white,
                            ),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColor),
                    ),
                    title: Text(item.name),
                    subtitle: Text('Stok : ${item.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (item.selectedQuantity > 0) {
                              item.selectedQuantity--;
                              controller.filteredItems.refresh();
                            }
                          },
                        ),
                        Text('${item.selectedQuantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (item.selectedQuantity < item.quantity) {
                              item.selectedQuantity++;
                              controller.filteredItems.refresh();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.notesController,
                decoration: InputDecoration(
                  labelText: 'Catatan',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: PrimaryButton(
                  text: "Kirim",
                  onTap: () async {
                    showLoading();
                    var isSend = await ServiceProvider().submitStockOut(
                        controller.inventoryItems,
                        controller.notesController.text);
                    onLoadingDismiss();
                    print("isSend: $isSend");
                    if (isSend["message"] ==
                        "Stock out recorded successfully") {
                      Get.back();
                      successMessage(context, isSend["message"]);
                    }
                  }),
            )
          ],
        );
      }),
    );
  }
}
