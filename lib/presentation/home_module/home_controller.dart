import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common_model/records_model.dart';
import '../../core/constants/dummy_data.dart';

class HomeController extends GetxController {
  RefreshController refreshController = RefreshController();

  TextEditingController searchController = TextEditingController();
  TextEditingController rupeesController = TextEditingController();
  List<RecordsModel>? recordsList;
  List<String> citiesList = [];
  List<String> selectedCites = [];

  @override
  void onInit() {
    loadDummyDataFromJson();
    super.onInit();
  }

  int startIndex = 0;
  int endIndex = 20;

  loadDummyDataFromJson({bool isLoadMore = false}) {
    if (!isLoadMore) {
      startIndex = 0;
      endIndex = 20;
      recordsList = [];
    }

    dummyJsonListOf43Records.getRange(startIndex, endIndex).forEach((element) {
      final data = RecordsModel.fromJson(element);
      recordsList?.add(data);
    });

    print("recordsList.length-> ${recordsList?.length}");
    update();
  }

  searchData(String value) {
    recordsList = [];
    for (var element in dummyJsonListOf43Records) {
      final data = RecordsModel.fromJson(element);
      if (data.name!.toLowerCase().contains(value.toLowerCase()) ||
          data.city!.toLowerCase().contains(value.toLowerCase()) ||
          data.phone!.toLowerCase().contains(value.toLowerCase())) {
        if (!recordsList!.contains(data)) {
          recordsList?.add(data);
        }
      }
    }
    update();
  }

  onRefresh() {
    startIndex = 0;
    endIndex = 20;
    loadDummyDataFromJson();
    selectedCites.clear();
    update();
    refreshController.refreshCompleted();
  }

  onLoadMore() {
    print(recordsList?.length);

    if ((recordsList?.length ?? 0) < dummyJsonListOf43Records.length) {
      startIndex = recordsList!.length;

      endIndex = recordsList!.length + 20;
      if (endIndex > dummyJsonListOf43Records.length) {
        endIndex = dummyJsonListOf43Records.length;
      }
      print("new start index-> $startIndex");
      print("new end index-> $endIndex");

      loadDummyDataFromJson(isLoadMore: true);
    }
    refreshController.loadComplete();
  }

  updateRupees(int id) {
    recordsList!.singleWhere((element) => element.id == id).rupee = int.parse(
      rupeesController.text,
    );
    update();
    Get.back();
  }

  getCitiesList() {
    for (var element in dummyJsonListOf43Records) {
      final data = RecordsModel.fromJson(element);
      if (!citiesList.contains(data.city)) {
        citiesList.add(data.city!);
      }
    }
    update();
  }

  selectCities(String cityName) {
    if (!selectedCites.contains(cityName)) {
      selectedCites.add(cityName);
    } else {
      selectedCites.remove(cityName);
    }
  }

  getRecordsByCity() {
    recordsList = [];
    for (var element in dummyJsonListOf43Records) {
      final data = RecordsModel.fromJson(element);
      for (var e in selectedCites) {
        if (data.city!.toLowerCase().contains(e.toLowerCase())) {
          if (!recordsList!.contains(data)) {
            recordsList?.add(data);
          }
        }
      }
    }
  }

  closeFilterDialogBox() {
    Get.back();
    selectedCites.clear();
    refreshController.position!.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    loadDummyDataFromJson();
  }
}
