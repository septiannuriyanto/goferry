import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goferry/custom_snackbar.dart';
import 'package:goferry/data.dart';
import 'package:goferry/dialog.dart';
import 'package:goferry/custom_button.dart';
import 'package:goferry/custom_loading.dart';
import 'package:goferry/custom_textfield.dart';
import 'package:goferry/global.dart';
import 'package:goferry/text_theme.dart';
import 'package:goferry/theme.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

import '../setup.dart';
import 'input_delivery_controller.dart';

class InputDelivery extends GetResponsiveView {
  InputDelivery({super.key});

  final cont = Get.put(InputDeliveryController());

  DateTime? dt;

  @override
  Widget builder() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Center(
              child: Text(
                "Silahkan masukkan data ekspedisi",
                style: screen.isDesktop
                    ? textTheme.headlineMedium
                    : textTheme.bodyLarge,
              ),
            ),
          ),
          Container(
            width: screen.isDesktop ? Get.width * 0.3 : Get.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
              boxShadow: subtleShadow,
            ),
            child: Form(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => CustomTextField(
                        autoFocus: true,
                        textEditingController: cont.tanggal_c.value,
                        hintText: "Tanggal Pengangkutan",
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            dt = await showDatePicker(
                              context: screen.context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 30)),
                            );
                            if (dt != null) {
                              cont.tanggal_c.value.text =
                                  DateFormat('dd/MMM/yyyy').format(dt!);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.namaekspedisi_c.value,
                      hintText: "Vendor Ekspedisi",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.nopol_c.value,
                      hintText: "Nomor Polisi",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => CustomTextField(
                        prefixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: ThemeColor.mainColor,
                            ),
                            onPressed: () async {
                              final data = await Get.dialog(FreightDialog(
                                dataGroup: freight,
                              ));
                              if (data != null) {
                                cont.jenisekspedisi_c.value.text = data;
                              }
                            }),
                        textEditingController: cont.jenisekspedisi_c.value,
                        hintText: "Jenis Ekspedisi",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => CustomTextField(
                        textEditingController: cont.muatan_c.value,
                        hintText: "Muatan",
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: ThemeColor.mainColor,
                          ),
                          onPressed: () async {
                            final data = await Get.dialog(FreightDialog(
                              dataGroup: muatan,
                            ));
                            if (data != null) {
                              cont.muatan_c.value.text = data;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.manifest_c.value,
                      hintText: "Nomor Manifest/SPB",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.driver_c.value,
                      hintText: "Nama Driver",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => CustomTextField(
                        textEditingController: cont.origin_c.value,
                        hintText: "Berangkat Dari",
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: ThemeColor.mainColor,
                          ),
                          onPressed: () async {
                            final data = await Get.dialog(FreightDialog(
                              dataGroup: origin,
                            ));
                            if (data != null) {
                              cont.origin_c.value.text = data;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.inputter_c.value,
                      hintText: "Diinput Oleh",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: cont.remark_c.value,
                      hintText: "Remark (Opsional)",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomRRButton(
                      borderRadius: 12,
                      color: ThemeColor.mainColor,
                      contentColor: Colors.white,
                      title: "Kirim Data",
                      width: 120,
                      onTap: () async {
                        if (cont.tanggal_c.value.text.isEmpty) {
                          customErrorMessage("Error", "Tanggal Harus diisi !");
                          return;
                        }
                        if (cont.namaekspedisi_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nama Ekspedisi Harus diisi !");
                          return;
                        }
                        if (cont.jenisekspedisi_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Jenis Ekspedisi Harus diisi !");
                          return;
                        }
                        if (cont.muatan_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Jenis Muatan Harus diisi !");
                          return;
                        }
                        if (cont.manifest_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nomor Manifest Harus diisi !");
                          return;
                        }
                        if (cont.driver_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nama Driver Harus diisi !");
                          return;
                        }
                        if (cont.origin_c.value.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Asal Keberangkatan Harus diisi !");
                          return;
                        }
                        if (cont.inputter_c.value.text.isEmpty) {
                          customErrorMessage("Error", "Isi nama anda !");
                          return;
                        }
                        LoaderDialog.showLoadingDialog("Submitting data");
                        await submitData(
                          dt!,
                          cont.tanggal_c.value.text,
                          cont.namaekspedisi_c.value.text,
                          cont.nopol_c.value.text.isEmpty
                              ? cont.nopol_c.value.text.replaceAll("", "-")
                              : cont.nopol_c.value.text,
                          cont.jenisekspedisi_c.value.text,
                          cont.muatan_c.value.text,
                          cont.manifest_c.value.text.isEmpty
                              ? cont.manifest_c.value.text.replaceAll("", "-")
                              : cont.manifest_c.value.text,
                          cont.driver_c.value.text,
                          cont.origin_c.value.text,
                          cont.inputter_c.value.text.isEmpty
                              ? cont.inputter_c.value.text.replaceAll("", "-")
                              : cont.inputter_c.value.text,
                          cont.remark_c.value.text.isEmpty
                              ? cont.remark_c.value.text.replaceAll("", "-")
                              : cont.remark_c.value.text,
                        );
                      })
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  submitData(
    DateTime tgl,
    String tanggal,
    String namaEkspedisi,
    String nopol,
    String jenisEkspedisi,
    String muatan,
    String manifest,
    String driverName,
    String asal,
    String inputter,
    String remark,
  ) async {
    String periode = DateFormat('yyyyMMdd').format(tgl);

    try {
      final gsheets = GSheets(credentials);
      final ss = await gsheets
          .spreadsheet('1BXM0nyhYMaguR5a52_jRbpadcfkqRd0I7bpZl85AXUU');
      var sheet = ss.worksheetByTitle('LCT');
      final dst = await sheet!.values.allRows(fromRow: 2);
      int lastRow = dst.length + 1;
      final newData = [
        lastRow,
        periode,
        tanggal,
        namaEkspedisi,
        nopol,
        jenisEkspedisi,
        muatan,
        manifest.toUpperCase(),
        driverName,
        asal,
        inputter,
        remark
      ];

      await sheet.values.insertRow(lastRow + 1, newData);
    } catch (e) {
      Get.back();
      customErrorMessage("Error submitting data", e.toString());
      print(e);
      return;
    }

    Get.back();

    dt = null;
    cont.tanggal_c.value.clear();
    cont.namaekspedisi_c.value.clear();
    cont.nopol_c.value.clear();
    cont.jenisekspedisi_c.value.clear();
    cont.muatan_c.value.clear();
    cont.manifest_c.value.clear();
    cont.driver_c.value.clear();
    cont.origin_c.value.clear();
    cont.inputter_c.value.clear();

    customSuccessMessage("Success", "Sukses Mengirim Data !");
  }
}
