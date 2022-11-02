import 'package:givepo/controller/item_controller.dart';
import 'package:givepo/util/dimensions.dart';
import 'package:givepo/view/base/custom_app_bar.dart';
import 'package:givepo/view/base/footer_view.dart';
import 'package:givepo/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givepo/view/base/menu_drawer.dart';

class PopularItemScreen extends StatefulWidget {
  final bool isPopular;
  PopularItemScreen({@required this.isPopular});

  @override
  State<PopularItemScreen> createState() => _PopularItemScreenState();
}

class _PopularItemScreenState extends State<PopularItemScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.isPopular) {
      Get.find<ItemController>().getPopularItemList(
          true, Get.find<ItemController>().popularType, false);
    } else {
      Get.find<ItemController>().getReviewedItemList(
          true, Get.find<ItemController>().reviewType, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.isPopular
              ? 'popular_items_nearby'.tr
              : 'best_reviewed_item'.tr,
          showCart: true),
      endDrawer: MenuDrawer(),
      body: Scrollbar(
          child: SingleChildScrollView(
              child: FooterView(
                  child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<ItemController>(builder: (itemController) {
          return ItemsView(
            isStore: false,
            stores: null,
            type: widget.isPopular
                ? itemController.popularType
                : itemController.reviewType,
            items: widget.isPopular
                ? itemController.popularItemList
                : itemController.reviewedItemList,
            onVegFilterTap: (String type) {
              if (widget.isPopular) {
                itemController.getPopularItemList(true, type, true);
              } else {
                itemController.getReviewedItemList(true, type, true);
              }
            },
          );
        }),
      )))),
    );
  }
}
