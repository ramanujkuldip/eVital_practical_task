import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kuldeep_practical/core/constants/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common_model/records_model.dart';
import '../../commons/base_button.dart';
import '../../commons/base_text.dart';
import '../../commons/base_textfield.dart';
import '../../core/constants/string_res.dart';
import '../../core/theme/color_res.dart';
import '../../core/utility/utils.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      dispose: (state) => Get.delete<HomeController>(),
      builder: (controller) {
        controller.getCitiesList();
        return Scaffold(appBar: buildAppBar(), body: mainBody(controller));
      },
    );
  }

  AppBar buildAppBar() {
    return Utils.getAppBar(
      title: "Home",
      actions: [
        IconButton(
          onPressed: () {
            Utils.showConfirmDialog(
              description: "Do you want to logout?",
              positiveTap: () {
                Utils.performLogout();
              },
            );
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  SafeArea mainBody(HomeController controller) {
    return SafeArea(
      child: Column(
        children: [
          searchFieldView(controller),
          10.heightSpacer,
          recordsListView(controller),
        ],
      ),
    );
  }

  Padding searchFieldView(HomeController controller) {
    return Padding(
      padding: EdgeInsets.only(
        right: 18.getSize,
        left: 18.getSize,
        top: 10.getSize,
      ),
      child: Row(
        children: [
          Expanded(
            child: BaseTextField(
              controller: controller.searchController,
              isShowBorder: true,
              hintText: "Search..",
              suffixIcon: Icon(Icons.search),
              borderRadius: 8,
              contentPadding: EdgeInsets.zero,
              onChanged: (p0) {
                controller.searchData(p0);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              filterByCityDialogBoxView(controller).then((value) {
                controller.update();
              });
            },
            icon: Utils.getImage(
              StringRes.filterIco,
              width: 43.getSize,
              height: 43.getSize,
              fit: BoxFit.cover,
              // color: ColorRes.blackColor.withOpacity(0.2)
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> filterByCityDialogBoxView(HomeController controller) {
    return Get.dialog(
      Center(
        child: Material(
          color: ColorRes.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.all(18.getSize),
                    padding: EdgeInsets.all(18.getSize),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorRes.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BaseText(
                                text: "Filter by city",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: controller.closeFilterDialogBox,
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        10.heightSpacer,
                        SizedBox(
                          height: Get.height * .5,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final cityName = controller.citiesList[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.selectCities(cityName);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BaseText(
                                        text: controller.citiesList[index],
                                      ),
                                    ),
                                    CheckboxTheme(
                                      data: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      child: Checkbox(
                                        value: controller.selectedCites
                                            .contains(cityName),
                                        onChanged: (value) {
                                          controller.selectCities(cityName);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (context, index) => 10.heightSpacer,
                            itemCount: controller.citiesList.length,
                          ),
                        ),
                        10.heightSpacer,
                        Row(
                          children: [
                            Expanded(
                              child: BaseRaisedButton(
                                buttonText: "Apply",
                                onPressed: () {
                                  Get.back();
                                  controller.getRecordsByCity();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  recordsListView(HomeController controller) {
    if (controller.recordsList == null) {
      return Expanded(
        child: Center(
          child: Lottie.asset(
            StringRes.circularLoaderLottie,
            height: 70.getSize,
            width: 70.getSize,
          ),
        ),
      );
    } else if (controller.recordsList!.isEmpty) {
      return Expanded(
        child: Center(child: BaseText(text: "Records list is empty!!")),
      );
    }
    return Expanded(
      child: SmartRefresher(
        controller: controller.refreshController,
        header: Utils.customHeader(),
        footer: Utils.customFooter(),
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoadMore,
        enablePullDown: true,
        enablePullUp: true,
        child: ListView.separated(
          padding: EdgeInsets.only(
            left: 18.getSize,
            right: 18.getSize,
            bottom: 18.getSize,
          ),
          itemBuilder: (context, index) {
            final data = controller.recordsList?[index];
            return GestureDetector(
              onTap: () {
                controller.rupeesController.text = "${data?.rupee ?? 0}";
                updateRupeesDialogBoxView(controller, data);
              },
              child: cardView(data),
            );
          },
          separatorBuilder: (context, index) => 10.heightSpacer,
          itemCount: controller.recordsList?.length ?? 0,
        ),
      ),
    );
  }

  Future<dynamic> updateRupeesDialogBoxView(
    HomeController controller,
    RecordsModel? data,
  ) {
    return Get.dialog(
      Center(
        child: Material(
          color: ColorRes.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                margin: EdgeInsets.all(18.getSize),
                padding: EdgeInsets.all(18.getSize),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(text: "Update Rupee"),
                    10.heightSpacer,
                    BaseTextField(
                      controller: controller.rupeesController,
                      isShowBorder: true,
                      contentPadding: EdgeInsets.zero,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberRangeFormatter(),
                      ],
                    ),
                    20.heightSpacer,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: BaseRaisedButton(
                            onPressed: () {
                              Get.back();
                            },
                            buttonText: "Cancel",
                            textColor: ColorRes.whiteColor,
                            buttonColor: ColorRes.textGreyColor,
                          ),
                        ),
                        10.widthSpacer,
                        Expanded(
                          child: BaseRaisedButton(
                            textColor: ColorRes.whiteColor,
                            onPressed: () {
                              controller.updateRupees(data!.id!);
                            },
                            buttonText: "Update",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container cardView(RecordsModel? data) {
    return Container(
      padding: EdgeInsets.all(7.getSize),
      decoration: BoxDecoration(
        color: ColorRes.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(10.getSize),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 55.getSize,
            width: 55.getSize,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Utils.getCacheNetworkImage(
              imageUrl: data?.image ?? "",
              placeholderWidget: Icon(Icons.account_circle),
            ),
          ),
          7.widthSpacer,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(text: data?.name ?? "", fontSize: 16),
                BaseText(text: "Phone: ${data?.phone ?? ""}", fontSize: 14),
                BaseText(text: "City: ${data?.city ?? ""}", fontSize: 14),
              ],
            ),
          ),
          Row(
            children: [
              BaseText(
                text: "${StringRes.rupeesSymbol}${data?.rupee ?? 0}",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    (data?.rupee ?? 0) > 50
                        ? ColorRes.greenColor
                        : ColorRes.redColor,
              ),
              Icon(
                (data?.rupee ?? 0) > 50
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color:
                    (data?.rupee ?? 0) > 50
                        ? ColorRes.greenColor
                        : ColorRes.redColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
