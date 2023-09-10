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

class InputDelivery extends GetResponsiveView {
  InputDelivery({super.key});
  final tanggal_c = TextEditingController();
  final namaekspedisi_c = TextEditingController();
  final nopol_c = TextEditingController();
  final jenisekspedisi_c = TextEditingController();
  final muatan_c = TextEditingController();
  final manifest_c = TextEditingController();
  final driver_c = TextEditingController();
  final origin_c = TextEditingController();
  final inputter_c = TextEditingController();
  final remark_c = TextEditingController();
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
            width: screen.isDesktop ? Get.width * 0.5 : Get.width * 0.9,
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
                    child: CustomTextField(
                      autoFocus: true,
                      textEditingController: tanggal_c,
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
                            tanggal_c.text =
                                DateFormat('dd/MMM/yyyy').format(dt!);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: namaekspedisi_c,
                      hintText: "Vendor Ekspedisi",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: nopol_c,
                      hintText: "Nomor Polisi",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
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
                              jenisekspedisi_c.text = data;
                            }
                          }),
                      textEditingController: jenisekspedisi_c,
                      hintText: "Jenis Ekspedisi",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: muatan_c,
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
                            muatan_c.text = data;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: manifest_c,
                      hintText: "Nomor Manifest/SPB",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: driver_c,
                      hintText: "Nama Driver",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: origin_c,
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
                            origin_c.text = data;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: inputter_c,
                      hintText: "Diinput Oleh",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      textEditingController: remark_c,
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
                        if (tanggal_c.text.isEmpty) {
                          customErrorMessage("Error", "Tanggal Harus diisi !");
                          return;
                        }
                        if (namaekspedisi_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nama Ekspedisi Harus diisi !");
                          return;
                        }
                        if (jenisekspedisi_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Jenis Ekspedisi Harus diisi !");
                          return;
                        }
                        if (muatan_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Jenis Muatan Harus diisi !");
                          return;
                        }
                        if (manifest_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nomor Manifest Harus diisi !");
                          return;
                        }
                        if (driver_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Nama Driver Harus diisi !");
                          return;
                        }
                        if (origin_c.text.isEmpty) {
                          customErrorMessage(
                              "Error", "Asal Keberangkatan Harus diisi !");
                          return;
                        }
                        if (inputter_c.text.isEmpty) {
                          customErrorMessage("Error", "Isi nama anda !");
                          return;
                        }
                        LoaderDialog.showLoadingDialog("Submitting data");
                        await submitData(
                          dt!,
                          tanggal_c.text,
                          namaekspedisi_c.text,
                          nopol_c.text.isEmpty
                              ? nopol_c.text.replaceAll("", "-")
                              : nopol_c.text,
                          jenisekspedisi_c.text,
                          muatan_c.text,
                          manifest_c.text.isEmpty
                              ? manifest_c.text.replaceAll("", "-")
                              : manifest_c.text,
                          driver_c.text,
                          origin_c.text,
                          inputter_c.text.isEmpty
                              ? inputter_c.text.replaceAll("", "-")
                              : inputter_c.text,
                          remark_c.text.isEmpty
                              ? remark_c.text.replaceAll("", "-")
                              : remark_c.text,
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
    tanggal_c.clear();
    namaekspedisi_c.clear();
    nopol_c.clear();
    jenisekspedisi_c.clear();
    muatan_c.clear();
    manifest_c.clear();
    driver_c.clear();
    origin_c.clear();
    inputter_c.clear();

    customSuccessMessage("Success", "Sukses Mengirim Data !");
  }
}
