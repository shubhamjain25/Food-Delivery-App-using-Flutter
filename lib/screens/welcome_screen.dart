import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/widgets/NearbyRestaurants.dart';
import 'package:food_delivery/widgets/recent_orders.dart';
import 'cart_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: (){},
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: Text('Food Delivery'),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(),),);
              } ,
              child: Text('Cart(${currentUser.cart.length})', style: TextStyle(fontSize: 20.0, color: Colors.white),),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor),
                ),
                hintText: 'Search Food or Restaurants',
                prefixIcon: IconButton(icon: Icon(Icons.search, size: 30.0,), onPressed:(){},),
                suffixIcon: IconButton(icon: Icon(Icons.clear,  size: 30.0,), onPressed: (){},),
              ),
            ),
          ),
          RecentOrders(),
          NearbyRestaurants(),
        ]
      ),
    );
  }
}
