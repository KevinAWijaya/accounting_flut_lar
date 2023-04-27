import 'package:akuntansi_flut/services/model/supplier.dart';
import 'package:flutter/material.dart';

import '../../commons/base_controller.dart';
import 'component/table_data_source.dart';

class SupplierController extends BaseController {
  final SupplierDataTableSource dataSource = SupplierDataTableSource();

  // filter by status
  String selectedFilterStatus = 'Active';
  final List<String> filterStatusItems = [
    'All',
    'Active',
    'Non-Active',
  ];

  // filter by Name
  String selectedFilterBy = 'Name';
  final TextEditingController itemSearchController = TextEditingController();
  final List<String> filterByItems = [
    'Name',
    'Code',
  ];

  // table
  int page = 1;
  int rowPerPage = 10;

  @override
  Future<void> onInit() async {
    isLoading = true;
    await dataSource.getData(page, rowPerPage: rowPerPage, true);
    isLoading = false;
    update();

    super.onInit();
  }

  void sortData<T>(Comparable<T> Function(Supplier supplier) getField, int colIndex, bool ascending) {
    dataSource.sort<T>(getField, ascending);
  }

  Future<void> changePage(int page, bool reset, {int rowPerPageTemp = 0}) async {
    rowPerPage = rowPerPageTemp <= 0 ? rowPerPage : rowPerPageTemp;
    isLoading = true;
    update();
    this.page = page;
    String active = "1";

    if (selectedFilterStatus == "Active") {
      active = "1";
    } else if (selectedFilterStatus == "Non-Active") {
      active = "0";
    } else {
      active = "";
    }
    await dataSource.getData(page, reset, rowPerPage: rowPerPage, search: itemSearchController.text, active: active);
    isLoading = false;
    update();
  }
}
