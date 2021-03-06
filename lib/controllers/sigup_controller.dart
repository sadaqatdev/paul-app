import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paul_app/models/customer.dart';
import 'package:paul_app/services/api_services.dart';

class SignUpController extends GetxController {
  ApiServices _apiServices;
  var isLoading = false.obs;
  final storage = GetStorage();
  @override
  void onInit() {
    _apiServices = ApiServices();

    super.onInit();
  }

  void createCutomer(CustomerModel model) async {
    isLoading(true);
    bool result = await _apiServices.createCustomer(model);
    if (result) {
      showBar('Sucessfully Account Created');
      storage.write('isLogin', 'yes');
      Get.offAllNamed('/naviga');
      isLoading(false);
    } else {
      isLoading(false);
      showBar('Email AlredyExist Please Try Again');
    }
  }

  showBar(s) {
    Get.showSnackbar(GetBar(
      message: s.toString(),
      duration: Duration(seconds: 3),
    ));
  }

  void loginCustomer(userName, password) async {
    isLoading(true);
    _apiServices.loginCustomer(userName, password).then((user) {
      print(user);
      isLoading(false);
      Get.offAll('/naviga');
    }).catchError((e) {
      print(e);
      isLoading(false);

      showBar(e);
    });
  }
}
