import 'dart:developer';

import 'package:akuntansi_flut/services/model/response/supplier_list.dart';
import 'package:akuntansi_flut/services/model/supplier.dart';
import 'package:akuntansi_flut/services/repository/supplier_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/routes/app_navigation.dart';
import '../../../utils/v_color.dart';
import '../../../utils/widgets/v_widgets.dart';

class SupplierDataTableSource extends DataTableSource {
  SupplierListResponse _data = SupplierListResponse();
  List<Supplier> supplierList = List<Supplier>.empty(growable: true);

  void sort<T>(Comparable<T> Function(Supplier supplier) getField, bool ascending) {
    supplierList.sort((Supplier a, Supplier b) {
      if (!ascending) {
        final Supplier c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  Future<bool> getData(int page, bool reset, {int rowPerPage = 25, String search = "", String active = "1"}) async {
    try {
      if (reset) {
        supplierList.clear();
      }
      var response = await SupplierRepo().getAllDataBy(page, rowPerPage: rowPerPage, search: search, active: active);
      if (response.code == 200) {
        _data = response.data ?? SupplierListResponse();
        supplierList.addAll(_data.supplierList ?? []);
        supplierList = supplierList.toSet().toList();

        final ids = supplierList.map((e) => e.id).toSet();
        supplierList.retainWhere((x) => ids.remove(x.id));
      }
    } catch (e) {
      log("error : $e");
    }
    return false;
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.total ?? 0;
  @override
  int get selectedRowCount => 0;

  int get rowPerPage => _data.perPage!;

  int getRowPerPageCustom() {
    int currentVal = _data.to! - _data.from! + 1;
    return currentVal;
  }

  @override
  DataRow getRow(int index) {
    return DataRow(
      color: index % 2 == 1 ? MaterialStateColor.resolveWith((states) => VColor.grey4Opacity) : MaterialStateColor.resolveWith((states) => VColor.transparant),
      cells: [
        dataCell(supplierList[index].id!.toString(), Get.width * (5 / 100)),
        dataCell(supplierList[index].name!, Get.width * (25 / 100), flex: 6),
        DataCell(
          Container(
            padding: const EdgeInsets.only(right: 5),
            constraints: BoxConstraints(
              minWidth: Get.width * (5 / 100),
            ),
            child: Checkbox(
              activeColor: VColor.grey1,
              value: supplierList[index].active == "1" ? true : false,
              onChanged: (value) => {},
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.only(right: 5),
            constraints: BoxConstraints(
              minWidth: Get.width * (5 / 100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  hoverColor: VColor.transparant,
                  onPressed: () {
                    VNavigation().toSupplierDetailPage(supplierList[index].id!);
                  },
                  icon: const Icon(Icons.ads_click, color: VColor.black),
                ),
                IconButton(
                  hoverColor: VColor.transparant,
                  onPressed: () {
                    VNavigation().toSupplierCreatePage(suppId: supplierList[index].id!);
                  },
                  icon: const Icon(Icons.edit, color: VColor.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataCell dataCell(String? text, double width, {int flex = 1}) {
    return DataCell(
      Container(
        constraints: BoxConstraints(minWidth: width),
        // width: width,
        padding: const EdgeInsets.only(right: 5),
        child: VText(text ?? "null", align: TextAlign.left),
      ),
    );
  }
}
