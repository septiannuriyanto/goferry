import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:goferry/constants/hardcode_colors.dart';
import 'package:goferry/custom_button.dart';
import 'package:goferry/custom_loading.dart';
import 'package:goferry/global.dart';
import 'package:goferry/model/ekspedisi.dart';
import 'package:goferry/theme.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

import '../custom_snackbar.dart';
import '../setup.dart';

class HistoryFetcher extends GetxController {
  RxList<List<String>> historyData = RxList.empty();
  RxList<Ekspedisi> listEkspedisi = RxList.empty();

  final ScrollController _sc = ScrollController();

  bool isAscending = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHistory();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchHistory() async {
    try {
      final gsheets = GSheets(credentials);
      final ss = await gsheets
          .spreadsheet('1BXM0nyhYMaguR5a52_jRbpadcfkqRd0I7bpZl85AXUU');
      var sheet = ss.worksheetByTitle('LCT');
      final dst = await sheet!.values.allRows(fromRow: 2);

      for (var i = 0; i < dst.length; i++) {
        // print(dst[i]);
        listEkspedisi.add(Ekspedisi.fromJsonData(dst[i]));
      }
      listEkspedisi.sort((a, b) => b.periode!.compareTo(a.periode!));

      historyData.value = dst;
    } catch (e) {
      Get.back();
      customErrorMessage("Error submitting data", e.toString());
      return;
    }
  }

  void sortData(SortType sortType) {
    isAscending = !isAscending;
    if (isAscending == true) {
      if (sortType == SortType.DateDelivery) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi.sort((a, b) => a.periode!.compareTo(b.periode!));
        return;
      }
      if (sortType == SortType.Vendor) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi
            .sort((a, b) => a.namaEkspedisi!.compareTo(b.namaEkspedisi!));
        return;
      }
      if (sortType == SortType.Material) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi.sort((a, b) => a.muatan!.compareTo(b.muatan!));
        return;
      }
      if (sortType == SortType.City) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi.sort((a, b) => a.asal!.compareTo(b.asal!));
        return;
      }
    } else {
      if (sortType == SortType.DateDelivery) {
        print("Sort by Date Delivery Descending");
        listEkspedisi.sort((a, b) => b.periode!.compareTo(a.periode!));
        return;
      }
      if (sortType == SortType.Vendor) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi
            .sort((a, b) => b.namaEkspedisi!.compareTo(a.namaEkspedisi!));
        return;
      }
      if (sortType == SortType.Material) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi.sort((a, b) => b.muatan!.compareTo(a.muatan!));
        return;
      }
      if (sortType == SortType.City) {
        print("Sort by Date Delivery Ascending");
        listEkspedisi.sort((a, b) => b.asal!.compareTo(a.asal!));
        return;
      }
    }
  }
}

enum SortType {
  DateInput,
  DateDelivery,
  Vendor,
  City,
  Material,
}

class HistoryDelivery extends GetResponsiveView {
  HistoryDelivery({super.key});

  @override
  Widget builder() {
    final getxcon = Get.put(HistoryFetcher());
    return Obx(() => Container(
          child: getxcon.listEkspedisi.isEmpty
              ? Center(
                  child: Container(
                    child: LoadingWidget(
                        Get.context!, "Loading Data...\nPlease Wait.."),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Sort By :'),
                          ),
                          Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomRRButton(
                                      title: "Date Input",
                                      color: Colors.amber.shade100,
                                      borderRadius: 12,
                                      width: 100,
                                      onTap: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomRRButton(
                                      title: "Date Delivery",
                                      color: Colors.amber.shade100,
                                      borderRadius: 12,
                                      width: 100,
                                      onTap: () {
                                        getxcon.sortData(
                                          SortType.DateDelivery,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomRRButton(
                                      title: "Vendor",
                                      color: Colors.amber.shade100,
                                      borderRadius: 12,
                                      width: 100,
                                      onTap: () {
                                        getxcon.sortData(SortType.Vendor);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomRRButton(
                                      title: "City",
                                      color: Colors.amber.shade100,
                                      borderRadius: 12,
                                      width: 100,
                                      onTap: () {
                                        getxcon.sortData(
                                          SortType.City,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomRRButton(
                                      title: "Material",
                                      color: Colors.amber.shade100,
                                      borderRadius: 12,
                                      width: 100,
                                      onTap: () {
                                        getxcon.sortData(
                                          SortType.Material,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: getxcon._sc,
                          reverse: false,
                          itemCount: getxcon.listEkspedisi.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: ThemeColor.mainColor.withOpacity(0.2),
                                  borderRadius: rads(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(getxcon
                                            .listEkspedisi[index].urutan!),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: VerticalDivider(),
                                    ),
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormat('dd-MM-yy').format(
                                                        convertToEpochDate(
                                                            getxcon
                                                                .listEkspedisi[
                                                                    index]
                                                                .tanggal!)!),
                                                    style: TextStyle(
                                                        color: ThemeColor
                                                            .mainColor),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          getxcon
                                                              .listEkspedisi[
                                                                  index]
                                                              .driverName!,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child:
                                                            VerticalDivider(),
                                                      ),
                                                      Expanded(
                                                        child: Text(getxcon
                                                            .listEkspedisi[
                                                                index]
                                                            .nopol!),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                getxcon.listEkspedisi[index]
                                                    .namaEkspedisi!,
                                                style: const TextStyle(
                                                    color: Colors.pink,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                      child: Text(getxcon
                                                          .listEkspedisi[index]
                                                          .jenisEkspedisi!),
                                                    )),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  rads(8),
                                                              color: commodityColor[
                                                                  getxcon
                                                                      .listEkspedisi[
                                                                          index]
                                                                      .muatan!]),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                getxcon
                                                                    .listEkspedisi[
                                                                        index]
                                                                    .muatan!,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: rads(8),
                                                          color: originColor[
                                                              getxcon
                                                                  .listEkspedisi[
                                                                      index]
                                                                  .asal!]),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: AutoSizeText(
                                                            getxcon
                                                                .listEkspedisi[
                                                                    index]
                                                                .asal!,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ],
                ),
        ));
  }

  DateTime? convertToEpochDate(String dateIntInput) {
    const gsDateBase = 2209161600 / 86400;
    const gsDateFactor = 86400000;

    final date = double.tryParse(dateIntInput);
    if (date == null) return null;
    final millis = (date - gsDateBase) * gsDateFactor;
    return DateTime.fromMillisecondsSinceEpoch(millis.toInt(), isUtc: true);
  }
}
