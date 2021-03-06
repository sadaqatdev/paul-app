import 'package:get/get.dart';
import 'package:paul_app/models/categories.dart';
import 'package:paul_app/services/api_services.dart';

class BrowserController extends GetxController {
  List<Category> categoryList = [];
  ApiServices _services = ApiServices();
  bool idLoading = true;
  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }

  void getCategoryList() async {
    categoryList = await _services.getCategories();
    update();
  }
}
