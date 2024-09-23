import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:torani/app/env/colors.dart';
import 'package:torani/app/modules/detailStock/views/detail_stock_view.dart';
import 'package:torani/app/widgets/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          title: CText(
            'Dashboard',
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
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.move_up_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => homeController.isTotalStockInExist.value
                              ? CText(
                                  "${homeController.totalStockIn.value}",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFFBDDEFC),
                                )
                              : SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CText(
                          "Stok Masuk",
                          color: Color(0xFF6AB5F9),
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width / 2 - 20,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.move_down_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => homeController.isTotalStockOutExist.value
                              ? CText(
                                  "${homeController.totalStockOut.value}",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFFBDDEFC),
                                )
                              : SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CText(
                          "Stok Keluar",
                          color: Color(0xFF6AD2F3),
                          fontSize: 12,
                        )
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
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  CText(
                    "Riwayat Stok",
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
                child: Obx(
                  () => homeController.isListStocksExist.value
                      ? RefreshIndicator(
                          onRefresh: () async {
                            homeController.isListStocksExist.value = false;
                            homeController.isTotalStockInExist.value = false;
                            homeController.isTotalStockOutExist.value = false;
                            homeController.fetchData();
                          },
                          child: ListView.builder(
                            itemCount: homeController.listStocks.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Get.to(() => DetailStockView(),
                                    arguments:
                                        homeController.listStocks[index]),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 24),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: homeController.listStocks[index]
                                                    ["type"] ==
                                                "stock_in"
                                            ? Icon(
                                                Icons
                                                    .keyboard_double_arrow_up_sharp,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons
                                                    .keyboard_double_arrow_down_sharp,
                                                color: Colors.red,
                                              ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: homeController
                                                            .listStocks[index]
                                                        ["type"] ==
                                                    "stock_in"
                                                ? Colors.green.withOpacity(0.2)
                                                : Colors.red.withOpacity(0.2)),
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
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                200,
                                            child: CText(
                                              "${homeController.listStocks[index]["notes"]}",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    homeController
                                                        .listStocks[index]
                                                            ['inventory_items']
                                                        .asMap()
                                                        .map<int, String>(
                                                            (int i,
                                                                dynamic stock) {
                                                          String comma = (i ==
                                                                  homeController
                                                                          .listStocks[
                                                                              index]
                                                                              [
                                                                              'inventory_items']
                                                                          .length -
                                                                      1)
                                                              ? ''
                                                              : ', ';
                                                          return MapEntry(i,
                                                              "${stock["name"]} : ${stock["quantity"]}$comma");
                                                        })
                                                        .values
                                                        .toList()
                                                        .join(), // Join all entries into a single string
                                                    overflow: TextOverflow
                                                        .ellipsis, // Handle overflow
                                                    maxLines:
                                                        1, // Limit to one line
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        size: 36,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            )
          ],
        ));
  }
}
