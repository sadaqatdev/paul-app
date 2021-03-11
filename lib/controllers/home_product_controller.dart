import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:paul_app/models/product.dart';
import 'package:paul_app/services/api_services.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;
  SortBy({
    this.value,
    this.text,
    this.sortOrder,
  });
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class HomeProductController extends GetxController {
  int categoryId;
  HomeProductController({this.categoryId});
  static HomeProductController get to => Get.find<HomeProductController>();

  ApiServices _services;

  ScrollController pscrcontroller = ScrollController();

  List<Product> productList;

  bool isLoading = true;

  SortBy _sortBy;

  int pageSized = 10;

  int page = 1;

  @override
  void onInit() {
    _sortBy = SortBy(value: 'modified', text: 'Latest', sortOrder: 'asc');
    resetStreams();
    setLoadingState(LoadMoreStatus.INITIAL);

    fetchProducts(page);

    pscrcontroller.addListener(() {
      if (pscrcontroller.position.pixels ==
          pscrcontroller.position.maxScrollExtent) {
        setLoadingState(LoadMoreStatus.LOADING);
        fetchProducts(++page);
      }
    });

    super.onInit();
  }

  onClose() {
    pscrcontroller.dispose();

    super.onClose();
  }

  List<Product> get allProduct => productList;

  double get totlaRecords => productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;

  getLoadMoreStatus() => _loadMoreStatus;

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    update();
  }

  resetStreams() {
    _services = ApiServices();
    productList = [];
  }

  setSortMethod(SortBy sortBy) {
    _sortBy = sortBy;
    update();
  }

  void fetchProducts(pageNumber,
      {String strSearch,
      String tagName,
      categoryId,
      String sortBy,
      String sortOrder = 'asc'}) async {
    productList = await _services.getProduct(
        pageNumber: pageNumber,
        categoryId: categoryId,
        pageSize: this.pageSized,
        sortBy: this._sortBy.value,
        sortOrder: this._sortBy.sortOrder,
        strSearch: strSearch,
        tagName: tagName);
    isLoading = false;
    setLoadingState(LoadMoreStatus.STABLE);
    update();
  }
}
