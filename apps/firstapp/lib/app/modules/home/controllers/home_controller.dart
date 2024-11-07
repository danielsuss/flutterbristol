import 'package:firstapp/app/data/repos/count_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  CountRepo countRepo = Get.find();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    countRepo.subscribeToCount().listen((event) {
      count.value = event;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => countRepo.incrementCount();

  void decrement() => countRepo.decrementCount();

  void set(value) => countRepo.setCount(value);
}
