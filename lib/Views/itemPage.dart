import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/Views/viewItems.dart';
import 'package:paul_app/controllers/product_controller.dart';
import 'package:paul_app/widgets/colors.dart';

import 'package:paul_app/widgets/progress_bar.dart';

class ItemPage extends StatefulWidget {
  final int categoryId;
  final String name;
  ItemPage({this.categoryId, this.name});
  @override
  _ItemPageState createState() => new _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _sortOptions = [
    SortBy(value: 'popularity', text: 'Popularity', sortOrder: 'asc'),
    SortBy(value: 'modified', text: 'Latest', sortOrder: 'asc'),
    SortBy(value: 'price', text: 'Price: High to Low', sortOrder: 'desc'),
    SortBy(value: 'price', text: 'Price: Low to High', sortOrder: 'asc'),
  ];

  ProductController contr;
  Timer debounce;
  TextEditingController searchQuery = TextEditingController();
  onSearchChange() {
    print('-----------------');
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    } else {
      debounce = Timer(Duration(milliseconds: 500), () {
        ProductController.to.resetStreams();
        ProductController.to.setLoadingState(LoadMoreStatus.INITIAL);
        ProductController.to.fetchProducts(ProductController.to.page,
            strSearch: searchQuery.text);
      });
    }
  }

  @override
  void initState() {
    contr = Get.put(ProductController(categoryId: widget.categoryId));
    searchQuery.addListener(onSearchChange);
    super.initState();
  }

  @override
  dispose() {
    searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              height: 40,
                              decoration: BoxDecoration(
                                color: grayColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextField(
                                controller: searchQuery,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 6),
                                    hintText: "Search...",
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Expanded(
                              child: PopupMenuButton(
                            onSelected: (value) {
                              ProductController.to.resetStreams();
                              ProductController.to.setSortMethod(value);
                              ProductController.to
                                  .fetchProducts(ProductController.to.page);
                            },
                            itemBuilder: (BuildContext context) {
                              return _sortOptions
                                  .map((e) => PopupMenuItem(
                                        child: Text(e.text),
                                        value: e,
                                      ))
                                  .toList();
                            },
                            child: Icon(Icons.tune),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<ProductController>(
                    init: ProductController(),
                    builder: (controller) {
                      if (controller.allProduct != null &&
                          controller.allProduct.length > 0 &&
                          controller.getLoadMoreStatus() !=
                              LoadMoreStatus.INITIAL) {
                        return Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 0.0),
                                  width: width,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.6,
                                    controller: controller.scrcontroller,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: List.generate(
                                        controller.allProduct.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ViewItems(
                                              product:
                                                  controller.allProduct[index],
                                            );
                                          }));
                                        },
                                        child: Container(
                                          // height: MediaQuery.of(context).size.height /2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.4,

                                          // decoration: ,
                                          child: Card(
                                            elevation: 0,
                                            shadowColor: Colors.white,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              // side: BorderSide(width: 1,color: Colors.grey[200])
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.22,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              controller
                                                                  .allProduct[
                                                                      index]
                                                                  .images[0]
                                                                  .src,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          )),
                                                      // child: Image.asset(
                                                      //   recentViewList[index].img,
                                                      //   height: MediaQuery.of(context).size.height *
                                                      //       0.18,
                                                      //   width: MediaQuery.of(context).size.width,
                                                      //   fit: BoxFit.cover,
                                                      // ),
                                                    ),
                                                    // Positioned(
                                                    //   right: 5,
                                                    //   top: 5,
                                                    //   child: Container(
                                                    //       height: 25,
                                                    //       width: 25,
                                                    //       decoration:
                                                    //           new BoxDecoration(
                                                    //         shape: BoxShape
                                                    //             .circle, // You can use like this way or like the below line
                                                    //         color: Colors.white,
                                                    //       ),
                                                    //       child:
                                                    //           controller.allProduct[index]
                                                    //               .iconss),
                                                    // )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 6),
                                                  child: Text(
                                                    controller
                                                        .allProduct[index].name,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: height / 60,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 0),
                                                  child: Text(
                                                    controller.allProduct[index]
                                                        .categories[0].name,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: height / 56,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 0),
                                                  child: Text(
                                                    controller.allProduct[index]
                                                        .price,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: height / 60,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Visibility(
                                child: Container(
                                  child: ProgressBar(),
                                  height: 35,
                                  width: 35,
                                ),
                                visible: controller.getLoadMoreStatus() ==
                                    LoadMoreStatus.LOADING,
                              )
                            ],
                          ),
                        );
                      } else {
                        return ProgressBar();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
