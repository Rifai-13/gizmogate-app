import 'package:get/get.dart';

class HomeController extends GetxController {
  var sliderIndex = 0.obs;
  var searchQuery = ''.obs;

  void updateSliderIndex(int index) {
    sliderIndex.value = index;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
