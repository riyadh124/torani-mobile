import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:torani/app/components/dateFormat.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/widgets/text.dart';

import '../controllers/detail_stock_controller.dart';

class DetailStockView extends GetView<DetailStockController> {
  DetailStockView({Key? key}) : super(key: key);
  DetailStockController detailStockController =
      Get.put(DetailStockController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          title: CText(
            detailStockController.dataStock["type"] == "stock_in"
                ? 'Detail Stok Masuk'
                : 'Detail Stok Keluar',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: CText(
                      "Catatan",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: CText(
                      ": ",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 150,
                    child: CText(
                      "${detailStockController.dataStock["notes"]} ",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: CText(
                      "Waktu",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: CText(
                      ": ",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 150,
                    child: CText(
                      formatDate("${detailStockController.dataStock["date"]}"),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: CText(
                      "Produk",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: CText(
                      ": ",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    detailStockController.dataStock["inventory_items"].length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: 24, left: 20, right: 20, top: 24),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          child:
                              detailStockController.dataStock["inventory_items"]
                                          [index]["thumbnail"] !=
                                      null
                                  ? Image.network(
                                      "https://pink-reindeer-116090.hostingersite.com/public/storage/${detailStockController.dataStock["inventory_items"][index]["thumbnail"]}",
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
                        SizedBox(
                          width: 24,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              "${detailStockController.dataStock["inventory_items"][index]["name"]}",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.unarchive_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                CText(
                                    "${detailStockController.dataStock["inventory_items"][index]["quantity"]} ${detailStockController.dataStock["inventory_items"][index]["unit"]}"),
                                SizedBox(
                                  width: 24,
                                ),
                                Icon(
                                  Icons.category,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                SizedBox(
                                  width: 130,
                                  child: CText(
                                    "${detailStockController.dataStock["inventory_items"][index]["category"]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
