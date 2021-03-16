import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:paul_app/Views/basket.dart';
import 'package:paul_app/controllers/cart_controller.dart';
import 'package:paul_app/models/product_cart.dart';
import 'package:paul_app/widgets/custom_steper.dart';

import 'package:paul_app/models/product.dart' as p;

class ViewItems extends StatefulWidget {
  final p.Product product;
  const ViewItems({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ViewItems> {
  int currentPage = 0;

  int qunty = 0;
  @override
  void initState() {
    Get.put(CartController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('--------DESCRIPTION-------');
    print(widget.product.description);

    return SafeArea(
      child: Scaffold(
        // appBar: customAppBar1("Your Item"),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 380,
                width: Get.width,
                child: Stack(
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          aspectRatio: 16 / 9,
                          // scrollPhysics: NeverScrollableScrollPhysics(),
                          viewportFraction: 1.0,
                          initialPage: currentPage,
                          enableInfiniteScroll: true,

                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 8),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 2000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          //onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: widget.product.images.map((item) {
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: item.src,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          );
                        }).toList()),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: new DotsIndicator(
                          position: currentPage.toDouble(),
                          dotsCount: widget.product.images.length,
                          decorator: DotsDecorator(
                            activeColor: Colors.white,
                            color: Colors.grey,
                            activeSize: Size(10, 10),
                            size: Size(6, 6),
                            spacing: EdgeInsets.symmetric(horizontal: 2),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          // numberOfDot: imgList.length,
//                      position: currentIndexPage,
//                      dotColor: Colors.black87,
//                      dotActiveColor: Colors.amber
//
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 20,
                      child: widget.product.onSale
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                    "On sale",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text("Home & Living", style: TextStyle(
                          //     color: Colors.grey,
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 1.6 * SizeConfig.textMultiplier
                          // ),),

                          Text(
                            widget.product.salePrice ?? '',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.product.price + "£",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "workSans",
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "workSans",
                          fontSize: 24),
                    ),
                    SizedBox(height: 24),

                    // Center(
                    //   child: Container(
                    //     width: 45 * SizeConfig.heightMultiplier,
                    //     decoration: BoxDecoration(
                    //         color: grayColor.withOpacity(0.4),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(12))),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 10, vertical: 10),
                    //       child: Column(
                    //         // mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   Navigator.of(context).push(
                    //                       MaterialPageRoute(
                    //                           builder: (Context) =>
                    //                               vendorProfile()));
                    //                 },
                    //                 child: MyCircleAvatar(
                    //                   imgUrl:
                    //                       'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 1 * SizeConfig.heightMultiplier,
                    //               ),
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "Made and sold by",
                    //                     style: TextStyle(
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.w600,
                    //                         color: Colors.grey),
                    //                   ),
                    //                   Text(
                    //                     "Paul",
                    //                     style: TextStyle(
                    //                         fontSize: 14,
                    //                         fontWeight: FontWeight.w600,
                    //                         color: Colors.black),
                    //                   ),
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   SmoothStarRating(
                    //                     rating: 4,
                    //                     isReadOnly: false,
                    //                     size: 16,
                    //                     color: Colors.yellow,
                    //                     filledIconData: Icons.star,
                    //                     halfFilledIconData: Icons.star_half,
                    //                     defaultIconData: Icons.star_border,
                    //                     starCount: 5,
                    //                     allowHalfRating: true,
                    //                     spacing: 2.0,
                    //                     onRated: (value) {
                    //                       print("rating value -> $value");
                    //                       // print("rating value dd -> ${value.truncate()}");
                    //                     },
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () {
                    //                       Navigator.of(context).push(
                    //                           MaterialPageRoute(
                    //                               builder: (Context) =>
                    //                                   Reviews()));
                    //                     },
                    //                     child: Text(
                    //                       "View / leave review",
                    //                       style: TextStyle(
                    //                           fontSize: 12,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: Colors.grey),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   Navigator.of(context).push(
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               ItemPage()));
                    //                 },
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                       height: 40,
                    //                       width: 40,
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(6),
                    //                         border: Border.all(
                    //                             color: Colors.grey
                    //                                 .withOpacity(0.4)),
                    //                         color: Colors.white,
                    //                       ),
                    //                       child: Center(
                    //                           child: Image(
                    //                         image: AssetImage(
                    //                           "images/chat.png",
                    //                         ),
                    //                         height: 20,
                    //                         width: 20,
                    //                       )),
                    //                     ),
                    //                     SizedBox(
                    //                       width: 1 *
                    //                           SizeConfig.heightMultiplier,
                    //                     ),
                    //                     Container(
                    //                       height: 40,
                    //                       width: 40,
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(6),
                    //                         border: Border.all(
                    //                             color: Colors.grey
                    //                                 .withOpacity(0.4)),
                    //                         color: Colors.white,
                    //                       ),
                    //                       child: Center(
                    //                           child: Image(
                    //                         image: AssetImage(
                    //                           "images/love.png",
                    //                         ),
                    //                         height: 20,
                    //                         width: 20,
                    //                       )),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSteper(
                          lowerLimit: 0,
                          upperLimit: 20,
                          iconSize: 22,
                          valuel: this.qunty,
                          stepValur: 1,
                          onChanged: (value) {
                            print(value);
                            this.qunty = value;
                          },
                        ),
                        FlatButton(
                            color: Colors.red,
                            onPressed: () {
                              CartProduct product = CartProduct(
                                productId: widget.product.id,
                                quantity: this.qunty,
                                price: double.parse(widget.product.price),
                                title: widget.product.name,
                                type: widget.product.attributes[0].options[0],
                                image: widget.product.images[0].src,
                              );
                              CartController.to.addToCart(product);
                              Get.showSnackbar(GetBar(
                                message: 'successful Add to Cart',
                                duration: Duration(seconds: 2),
                              ));
                            },
                            child: Text(
                              'Add to Basket',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),

                    ExpandedSection(
                      lableHeader: "Description",
                      desc: widget.product.description,
                      shortDesc: widget.product.shortDescription,
                    ),

                    Wrap(
                        children: widget.product.attributes
                            .map((e) => Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: attributeTile(e.name, e.options)))
                            .toList()),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Basket();
                            }));
                          },
                          child: Text(
                            'View Basket',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding attributeTile(String name, option) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontFamily: "workSans",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            option.toString(),
            style: TextStyle(
              fontSize: 15,
              fontFamily: "workSans",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final String desc;
  final String lableHeader;
  final String shortDesc;
  const ExpandedSection({
    Key key,
    this.desc,
    this.lableHeader,
    this.shortDesc,
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.widget.lableHeader),

            // Expanded(
            //     child: FlutterNativeHtmlView(
            //         htmlData: show
            //             ? widget.desc.isEmpty
            //                 ? widget.shortDesc
            //                 : widget.desc
            //             : widget.shortDesc)),
            Html(
                data: show
                    ? widget.desc.isEmpty
                        ? widget.shortDesc
                        : widget.desc
                    : widget.shortDesc),
            Align(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  show = !show;
                });
              },
              child: Text(
                show ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ))
          ],
        ));
  }
}
