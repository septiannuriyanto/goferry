import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goferry/pages/analytics_page.dart';
import 'package:goferry/pages/history_delivery.dart';
import 'package:goferry/pages/input_delivery.dart';
import 'package:goferry/setup.dart';
import 'package:goferry/custom_snackbar.dart';
import 'package:goferry/text_theme.dart';
import 'package:goferry/theme.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

class TabViewer extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabcon;

  final List<Tab> myTabs = const [
    Tab(
      icon: Icon(
        Icons.add_box_sharp,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.history,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.analytics_outlined,
      ),
    ),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    tabcon = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    tabcon.dispose();
    super.onClose();
  }
}

class Home extends GetResponsiveView {
  Home({super.key});

  @override
  Widget builder() {
    final tabs = Get.put(TabViewer());
    return Scaffold(
      backgroundColor: Theme.of(screen.context).canvasColor,
      appBar: AppBar(
        // foregroundColor: Colors.white,
        backgroundColor: ThemeColor.mainColor,
        title: Center(
            child: SizedBox(
          height: screen.isDesktop ? 50 : 20,
          child: Image.asset('assets/goferry.png'),
        )),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: ThemeColor.mainColor.withGreen(100),
          controller: tabs.tabcon,
          tabs: tabs.myTabs,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabs.tabcon,
                children: [
                  InputDelivery(),
                  HistoryDelivery(),
                  AnalyticsPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
