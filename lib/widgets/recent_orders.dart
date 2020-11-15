import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/order.dart';

class RecentOrders extends StatelessWidget {
  _buildRecentOrder(BuildContext context, Order order) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        // If you want recent orders in less height, make vertical equals to 10
        width: 320.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.grey[200]),
        ),
        child: Row(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
              image: AssetImage(order.food.imageUrl),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
//              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(
                      order.food.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(
                      order.restaurant.name,
                      style: kRecentOrderText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.0),
                    child: Text(
                      order.date,
                      style: kRecentOrderText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              color: Theme.of(context).primaryColor,
            ),
            margin: EdgeInsets.only(right: 15.0),
            width: 50.0,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.add),
              iconSize: 30.0,
              onPressed: () {},
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Recent Orders',
            style: kHeadingStyle,
          ),
        ),
        Container(
            height: 100.0,
//          color: Colors.blueAccent,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left:10.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
              Order order = currentUser.orders[index];
              return _buildRecentOrder(context, order);
            },
              itemCount: currentUser.cart.length,
            )),
      ],
    );
  }
}
