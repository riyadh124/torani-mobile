import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torani/app/components/dialog.dart';
import 'package:torani/app/components/loading.dart';
import 'package:torani/app/data/invetoryItem.dart';
import 'package:torani/app/env/global_var.dart';
import 'package:torani/app/modules/home/views/home_view.dart';
import 'package:torani/app/modules/tabDecider/views/tab_decider_view.dart';

class ServiceProvider extends GetConnect {
  @override
  void login(context, email, pass) async {
    print("email: " + email);
    print("password: " + pass);

    if (email != '' && pass != '') {
      showLoading();

      try {
        final response = await post('$urlApi/auth/login', {
          'email': email,
          'password': pass,
        });

        var data = response.body;
        print("response $data");

        if (data['message'] == 'Login successful') {
          GetStorage().write("token", data["token"]);
          GetStorage().write("userData", data["user"]);
          onLoadingDismiss();
          Get.offAll(() => TabDeciderView());
          successMessage(context, data['message']);
        } else {
          onLoadingDismiss();
          errorMessage(data['message']);
        }
      } catch (e) {
        onLoadingDismiss();
        errorMessage(e);
      }
    } else {
      errorMessage("Lengkapi Email dan Password terlebih dahulu.");
    }
  }

  Future<List> getStocksProduct() async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/products-stock',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return data['data'];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }

  Future<List> getStocks() async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/stocks',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return data['data'];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }

  Future submitStockOut(List<InventoryItem> inventoryItems, notes) async {
    final token = await GetStorage().read("token");
    try {
      var selectedItems =
          inventoryItems.where((item) => item.selectedQuantity > 0).toList();
      if (selectedItems.isEmpty) {
        errorMessage("Tidak ada produk dipilih");
        return {"message": "Gagal membuat stok keluar"};
      }

      if (notes == "") {
        errorMessage("Catatan wajib di isi");
        return {"message": "Gagal membuat stok keluar"};
      }

      List<Map<String, dynamic>> items = selectedItems.map((item) {
        return {
          'inventory_item_id': item.id,
          'quantity': item.selectedQuantity,
        };
      }).toList();

      var body = {
        'items': items,
        'notes': notes,
      };

      final response = await post('$urlApi/stock-out', body,
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['message'] == "Stock out recorded successfully") {
        // successMessage(Get.context, data['message']);
        return data;
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return {"message": "Gagal membuat stok keluar"};
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return {"message": "Gagal membuat stok keluar"};
    }
  }

  Future getStockCounts() async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/products-count',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return data;
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }

  Future getProducts() async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/total-stock',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response ${data["data"]["products"]}");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return [
          {"products": data["data"]["products"]},
          {"data": data["data"]}
        ];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }
}
