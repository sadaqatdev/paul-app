import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/Views/notification.dart';
import 'package:paul_app/Views/viewItems.dart';
import 'package:paul_app/controllers/browser_controller.dart';
import 'package:paul_app/controllers/home_product_controller.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/progress_bar.dart';
import 'package:paul_app/widgets/styles.dart';

import 'all_categories.dart';
import 'itemPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(BrowserController());

  final vontroller = Get.put(HomeProductController());

  Timer debounce;

  TextEditingController searchQuery = TextEditingController();

  onSearchChange() {
    print('-----------------');
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    } else {
      debounce = Timer(Duration(milliseconds: 500), () {
        HomeProductController.to.resetStreams();
        HomeProductController.to.setLoadingState(LoadMoreStatus.INITIAL);
        HomeProductController.to.fetchProducts(HomeProductController.to.page,
            strSearch: searchQuery.text);
      });
    }
  }

  @override
  void initState() {
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

          // appBar: customAppBar1("Sign In"),

          body: Container(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 6,
                      ),

                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      SizedBox(
                        width: 6,
                      ),
                      //notification icon with badge
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => notification()));
                        },
                        child: new Icon(
                          Icons.notifications,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      width: width / 1.1,
                      child: Text("Your club home",
                          style: CustomTextStyle.headig(context))),
                  SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  //Catergory
                  Container(
                    width: width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "workSans",
                                fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AllCatorgies(controller.categoryList)));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "See all",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: "workSans",
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  GetBuilder<BrowserController>(builder: (controller) {
                    return Expanded(
                      child: ListView.separated(
                          itemCount: controller.categoryList.length,
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ItemPage(
                                          categoryId:
                                              controller.categoryList[index].id,
                                          name: controller
                                              .categoryList[index].name,
                                        )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: basicColorShopper,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 40,
                                  width: width / 3,
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: CustomTextStyle.normaltext3(
                                              context),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: controller
                                                    .categoryList[index].name),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                              // width: 6,
                            );
                          }),
                    );
                  }),

                  const SizedBox(
                    height: 12,
                  ),

                  //Latest items
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Text(
                      "Latest Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "workSans",
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  Expanded(
                    flex: 8,
                    child: GetBuilder<HomeProductController>(
                        init: HomeProductController(),
                        builder: (controller) {
                          if (controller.allProduct != null &&
                              controller.allProduct.length > 0 &&
                              controller.getLoadMoreStatus() !=
                                  LoadMoreStatus.INITIAL) {
                            return Column(
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
                                      controller: controller.pscrcontroller,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: List.generate(
                                          controller.allProduct.length,
                                          (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ViewItems(
                                                product: controller
                                                    .allProduct[index],
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
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.22,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12)),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    controller
                                                                        .allProduct[
                                                                            index]
                                                                        .images[
                                                                            0]
                                                                        .src,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                          .allProduct[index]
                                                          .name,
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
                                                      controller
                                                          .allProduct[index]
                                                          .categories[0]
                                                          .name,
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
                                                      controller
                                                          .allProduct[index]
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
                            );
                          } else {
                            return ProgressBar();
                          }
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  GestureDetector productWidget(BuildContext context, int index, double height,
      HomeProductController pcontroller) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ViewItems()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.16,
          width: MediaQuery.of(context).size.width / 3,

          // decoration: ,
          child: Card(
            elevation: 0,
            shadowColor: Colors.white,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              // side: BorderSide(width: 1,color: Colors.grey[200])
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Image.network(
                        pcontroller.productList[index].images[0].src,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Positioned(
                    //   right: 5,
                    //   top: 5,
                    //   child: Container(
                    //       height: 25,
                    //       width: 25,
                    //       decoration: new BoxDecoration(
                    //         shape: BoxShape
                    //             .circle, // You can use like this way or like the below line
                    //         color: Colors.white,
                    //       ),
                    //       child: latestItemList[index].iconss),
                    // )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 6),
                  child: Text(
                    pcontroller.productList[index].name,
                    style: TextStyle(
                        fontFamily: "workSans",
                        color: Colors.grey,
                        fontSize: height / 60,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Text(
                    pcontroller.productList[index].categories[0].name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height / 56,
                        fontFamily: "workSans",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Text(
                    pcontroller.productList[index].price,
                    style: TextStyle(
                        fontFamily: "workSans",
                        color: Colors.grey,
                        fontSize: height / 60,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
