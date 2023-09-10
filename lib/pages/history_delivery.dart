import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:goferry/constants/hardcode_colors.dart';
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

      historyData.value = dst;
    } catch (e) {
      Get.back();
      customErrorMessage("Error submitting data", e.toString());
      return;
    }
  }
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
              : ListView.builder(
                  controller: getxcon._sc,
                  reverse: false,
                  itemCount: getxcon.listEkspedisi.length,
                  itemBuilder: ((context, index) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      getxcon._sc.animateTo(
                        getxcon._sc.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeOut,
                      );
                    });
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
                                child:
                                    Text(getxcon.listEkspedisi[index].urutan!),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
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
                                                convertToEpochDate(getxcon
                                                    .listEkspedisi[index]
                                                    .tanggal!)!),
                                            style: TextStyle(
                                                color: ThemeColor.mainColor),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  getxcon.listEkspedisi[index]
                                                      .driverName!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: VerticalDivider(),
                                              ),
                                              Expanded(
                                                child: Text(getxcon
                                                    .listEkspedisi[index]
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: rads(8),
                                                      color: commodityColor[
                                                          getxcon
                                                              .listEkspedisi[
                                                                  index]
                                                              .muatan!]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Center(
                                                      child: AutoSizeText(
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
                                                  color: originColor[getxcon
                                                      .listEkspedisi[index]
                                                      .asal!]),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: AutoSizeText(
                                                    getxcon.listEkspedisi[index]
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
