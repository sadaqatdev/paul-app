import 'package:flutter/material.dart';
import 'package:paul_app/models/categories.dart';
import 'package:paul_app/widgets/appBar.dart';
import 'package:paul_app/widgets/styles.dart';

import 'itemPage.dart';

class AllCatorgies extends StatelessWidget {
  final List<Category> categoryList;
  AllCatorgies(this.categoryList);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar1("Categories"),
        body: Container(
          // color: whiteColor,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: width / 1.2,
                            child: Text("Categories",
                                style: CustomTextStyle.headig(context))),
                      ),
                      Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      // color: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                      // height: MediaQuery.of(context).size.height * 0.21,
                      width: width,

                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: (3 / 3),
                        controller:
                            new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: List.generate(categoryList.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ItemPage(
                                        categoryId: categoryList[index].id,
                                        name: categoryList[index].name,
                                      )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            categoryList[index].image.url,
                                          ),
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.9),
                                              BlendMode.dstATop),
                                          fit: BoxFit.cover)),
                                  // child: Image.asset(CatogeryList[index].img,
                                  //   // height: MediaQuery.of(context).size.height * 0.14,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                Positioned(
                                  bottom: 18,
                                  left: 10,
                                  child: Text(
                                    categoryList[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  left: 12,
                                  child: Text(
                                    "${categoryList[index].count} items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 66,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
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
