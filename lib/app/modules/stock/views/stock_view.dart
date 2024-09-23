import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:torani/app/data/service_provider.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/modules/takeStock/views/take_stock_view.dart';
import 'package:torani/app/widgets/button.dart';
import 'package:torani/app/widgets/text.dart';

import '../controllers/stock_controller.dart';

class StockView extends GetView<StockController> {
  StockView({Key? key}) : super(key: key);
  StockController stockController = Get.put(StockController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          title: CText(
            'Produk',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          actions: [],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width / 2 - 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          "Total Produk",
                          fontSize: 14,
                          color: Color(0xFFA4ABB9),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => controller.isListProductsExist.value
                              ? CText(
                                  controller.totalProducts.value.toString(),
                                  color: Color(0xFF47484A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )
                              : SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                      color: primaryColor)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.fastfood,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width / 2 - 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          "Total Stok",
                          fontSize: 14,
                          color: Color(0xFFA4ABB9),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => controller.isListProductsExist.value
                              ? CText(
                                  controller.totalStock.value.toString(),
                                  color: Color(0xFF47484A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )
                              : SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.shopping_cart,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PrimaryButton(
                  text: "Keluarkan Stok",
                  onTap: () {
                    Get.to(() => TakeStockView());
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  CText(
                    "List Produk",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFA5ABBA),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Obx(() => stockController.isListProductsExist.value
                      ? RefreshIndicator(
                          onRefresh: () async {
                            controller.isListProductsExist.value = false;
                            controller.fetchData();
                          },
                          child: ListView.builder(
                            itemCount: stockController.listProducts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 24),
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      child: stockController.listProducts[index]
                                                  ["thumbnail"] !=
                                              null
                                          ? Image.network(
                                              "https://pink-reindeer-116090.hostingersite.com/public/storage/${stockController.listProducts[index]["thumbnail"]}",
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(
                                              Icons.fastfood,
                                              color: Colors.white,
                                            ),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: primaryColor),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        stockController.listProducts[index]
                                                    ["stock_quantity"] !=
                                                0
                                            ? CText(
                                                "${stockController.listProducts[index]["name"]}",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              )
                                            : SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        130,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CText(
                                                      "${stockController.listProducts[index]["name"]}",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                    CText(
                                                      "*Stok kosong, harap di isi kembali.",
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.unarchive_outlined,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            CText(
                                                "${stockController.listProducts[index]["stock_quantity"]} ${stockController.listProducts[index]["unit"]}"),
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
                                                "${stockController.listProducts[index]["category"]}",
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
                      : Center(
                          child: CircularProgressIndicator(),
                        ))),
            )
          ],
        ));
  }
}
