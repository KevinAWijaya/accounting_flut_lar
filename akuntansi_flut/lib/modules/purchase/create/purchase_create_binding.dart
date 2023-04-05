import 'package:get/get.dart';

import 'purchase_create_controller.dart';

class PurchaseCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseCreateController>(() => PurchaseCreateController());
  }
}
