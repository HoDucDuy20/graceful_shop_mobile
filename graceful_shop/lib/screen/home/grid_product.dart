// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class GridProduct extends StatefulWidget {
  String titleName;
  GridProduct({Key? key, required this.titleName}) : super(key: key);

  @override
  State<GridProduct> createState() => _GridProductState(titleName: titleName);
}

class _GridProductState extends State<GridProduct> {
  String titleName;
  _GridProductState({required this.titleName});
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: ListTile(
              // tileColor: Colors.blueGrey,
              title: Text(
                titleName,
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: Dimensions.font40,
              ),
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                childAspectRatio: 0.7,
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/img_2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "Áo cổ rộng gợi cảm",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(50, 54, 67, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "250.00",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(50, 54, 67, 1),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite),
                                  ),
                                  Text('20')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Xem thêm',
                    style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.move_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
