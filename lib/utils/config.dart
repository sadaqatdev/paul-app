class Config {
  static const String CK = 'ck_58aeab0e232d2f3b485da541cd7f1317c419006c';
  static const String CS = 'cs_52e9b5e0c07b72f8b222f84c34e3a232543f951f';

  static String baseUrl = 'https://www.threadandthread.com/wp-json';
  static String url = '$baseUrl/wc/v3/';
  static String tokenUrl = '$baseUrl/jwt-auth/v1/token';
  static String cutomUrl = 'customers';
  static String categoryUrl = 'products/categories';
  static String productUrl = 'products';
  static String todayOfferTagId = '24';
  static String topSellingProductTagId = '25';
  static String wcfm = '$baseUrl/wcfmmp/v1/products/';
}
