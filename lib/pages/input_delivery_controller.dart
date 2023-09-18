import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDeliveryController extends GetxController {
  final tanggal_c = Rx(TextEditingController());
  final namaekspedisi_c = Rx(TextEditingController());
  final nopol_c = Rx(TextEditingController());
  final jenisekspedisi_c = Rx(TextEditingController());
  final muatan_c = Rx(TextEditingController());
  final manifest_c = Rx(TextEditingController());
  final driver_c = Rx(TextEditingController());
  final origin_c = Rx(TextEditingController());
  final inputter_c = Rx(TextEditingController());
  final remark_c = Rx(TextEditingController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tanggal_c.value.dispose();
    namaekspedisi_c.value.dispose();
    nopol_c.value.dispose();
    jenisekspedisi_c.value.dispose();
    muatan_c.value.dispose();
    manifest_c.value.dispose();
    driver_c.value.dispose();
    origin_c.value.dispose();
    inputter_c.value.dispose();
    remark_c.value.dispose();
  }
}
