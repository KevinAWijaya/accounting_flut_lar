import 'package:akuntansi_flut/utils/v_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/model/item_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/widgets/v_widgets.dart';
import '../item.dart';

Widget buildTableItem() {
  return GetBuilder<ItemController>(
    builder: (controller) => controller.isLoading
        ? const VLoadingPage()
        : Container(
            decoration: BoxDecoration(
              color: VColor.white,
              borderRadius: BorderRadius.all(
                Radius.circular(radiusMedium),
              ),
            ),
            child: Theme(
              data: Theme.of(Get.context!).copyWith(cardColor: VColor.white, dividerColor: VColor.primary),
              child: PaginatedDataTable(
                source: controller.dataSource,
                showFirstLastButtons: true,
                primary: true,
                columnSpacing: 10,
                horizontalMargin: 10,
                rowsPerPage: 15,
                showCheckboxColumn: false,
                columns: [
                  tableColumn(controller, "Code", (user) => user.code!, minWidth: Get.width * (4 / 100)),
                  tableColumn(controller, "Name", (user) => user.name!, minWidth: Get.width * (24 / 100)),
                  tableColumn(controller, "Category Name", (user) => user.categoryName!, minWidth: Get.width * (16 / 100)),
                  tableColumn(controller, "Min Price", (user) => int.parse(user.minPrice!), minWidth: Get.width * (12 / 100)),
                  tableColumn(controller, "Price", (user) => int.parse(user.price!), minWidth: Get.width * (8 / 100)),
                  tableColumn(controller, "Active", (user) => user.active!, minWidth: Get.width * (8 / 100)),
                  tableColumn(controller, " ", null, minWidth: Get.width * (8 / 100)),
                ],
              ),
            ),
          ),
  );
}

DataColumn tableColumn<T>(
  ItemController controller,
  String title,
  Comparable<T> Function(ItemModel user)? sortBy, {
  double minWidth = 100.0,
}) {
  return DataColumn(
    label: SizedBox(
      width: minWidth,
      child: VText(
        title,
        align: TextAlign.left,
        overflow: TextOverflow.clip,
      ),
    ),
    onSort: sortBy != null ? (columnIndex, ascending) => controller.sortData(sortBy, columnIndex, ascending) : null,
  );
}
