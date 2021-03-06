import 'package:flutter/material.dart';
import 'package:paul_app/Views/search.dart';
import 'package:paul_app/widgets/colors.dart';

class searchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 61,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                color: grayColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (Context) => searchPage()));
                      }),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search...", border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
