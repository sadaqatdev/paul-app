import 'package:flutter/material.dart';

import 'package:paul_app/Views/salesDetail.dart';
import 'package:paul_app/controllers/cart_controller.dart';
import 'package:paul_app/models/product_cart.dart';

class MySalesContainer extends StatelessWidget {
  final List<CartProduct> list;
  final CartController controller;
  MySalesContainer({Key key, this.list, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemCount: list.length,
        shrinkWrap: true,
        // physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => salesDetial()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height / 12,
                    width: width / 6,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                      image: NetworkImage(
                        list[index].image,
                      ),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          list[index].title,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: height / 60,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5),
                        child: Text(
                          list[index].type,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: height / 56,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              "  € ${list[index].price}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: height / 60,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                              onTap: () {},
                              child: FlatButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    controller.removeFromCart(list[index]);
                                  },
                                  child: Text('Remove'))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 5,
          );
        });
  }
}
