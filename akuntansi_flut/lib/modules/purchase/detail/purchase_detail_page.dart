import 'package:akuntansi_flut/modules/purchase/detail/purchase_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../utils/v_color.dart';
import '../../../utils/widgets/v_widgets.dart';
import '../../app_bar/custom_app_bar.dart';
import 'table.dart';

class PurchaseDetailPage extends StatelessWidget {
  const PurchaseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: customAppBar(),
      backgroundColor: VColor.background,
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(paddingSmall),
      child: Column(
        children: [
          const _Header(),
          const SizedBox(height: marginSmall),
          Expanded(
            child: ListView(
              children: const [
                _DetailItem(),
                PurchaseLineTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: VColor.primary, borderRadius: BorderRadius.all(Radius.circular(radiusMedium))),
      padding: const EdgeInsets.all(paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  VText(
                    "Dashboard",
                    fontSize: textSizeMedium,
                    color: VColor.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Icon(
                    Icons.arrow_right,
                    color: VColor.white,
                  ),
                  VText(
                    "Purchase",
                    fontSize: textSizeMedium,
                    color: VColor.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Icon(
                    Icons.arrow_right,
                    color: VColor.white,
                  ),
                  const VText(
                    "View",
                    fontSize: textSizeMedium,
                    color: VColor.black,
                  ),
                ],
              ),
              const SizedBox(
                height: marginSuperSmall,
              ),
              const VText(
                "Purchase Detail",
                fontSize: textSizeLarge,
                color: VColor.white,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  VButton(
                    "Back",
                    buttonColor: VColor.platinum,
                    leftIcon: const Icon(
                      Icons.list,
                      color: VColor.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  // const SizedBox(width: marginMedium),
                  // VButton(
                  //   "Update",
                  //   buttonColor: VColor.secondary,
                  //   leftIcon: const Icon(
                  //     Icons.edit,
                  //     color: VColor.white,
                  //   ),
                  //   onPressed: () {
                  //     VNavigation().toSupplierCreatePage();
                  //   },
                  // ),
                  // const SizedBox(width: marginMedium),
                  // VButton(
                  //   "Delete",
                  //   buttonColor: VColor.red,
                  //   leftIcon: const Icon(
                  //     Icons.delete,
                  //     color: VColor.white,
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem();

  Widget detailField(String title, String field) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: VText(title),
          ),
          const SizedBox(
            width: marginMedium,
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: VText(field),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(paddingMedium),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GetBuilder<PurchaseDetailController>(
              builder: (controller) => Column(
                children: [
                  detailField("Supplier Name", controller.purchaseHeader.sName ?? "No Name"),
                  const SizedBox(height: marginExtraLarge),
                  detailField("Transaction Date", controller.purchaseHeader.purchaseDate ?? "No Date"),
                  const SizedBox(height: marginExtraLarge),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: marginExtraLarge,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
