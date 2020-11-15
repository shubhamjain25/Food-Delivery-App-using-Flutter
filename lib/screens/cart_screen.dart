import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double amount;


  _buildCartScreen(Order cartItem) {
    amount = cartItem.food.price * cartItem.quantity;
    return Container(
      height: 170.0,
      padding: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(cartItem.food.imageUrl),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartItem.food.name,
                      style: kHeadingStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      cartItem.restaurant.name,
                      style: kTitleStyle.copyWith(fontSize: 15.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              width: 0.6,
                              color: Colors.black87,
                            )),
                        child: Container(
                          height: 30.0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cartItem.quantity = cartItem.quantity - 1;
                                    });
                                  },
                                  child: Text('-', style: kCartScreenBtn),
                                ),
                                Text(
                                  cartItem.quantity.toString(),
                                  style: kCartScreenBtn.copyWith(
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cartItem.quantity = cartItem.quantity + 1;
                                    });
                                  },
                                  child: Text('+', style: kCartScreenBtn),
                                ),
                              ]),
                        )),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
//                color: Colors.red,
                child: Text(
                  '\$$amount',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    for (int i = 0; i < currentUser.cart.length; i++) {
      Order orderItem = currentUser.cart[i];
      totalAmount = totalAmount + orderItem.food.price * orderItem.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Cart(${currentUser.cart.length})',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: currentUser.cart.length + 1,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Colors.black,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartScreen(order);
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 10.0,
            ),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Estimated Delivery Time', style: kCartScreenBottomTitle),
                      Text('25 min', style: kCartScreenBottomValue.copyWith(color:Colors.green[600]),),
                    ]),
                SizedBox(height:10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total Cost', style: kCartScreenBottomTitle),
                      Text('\$${totalAmount.toStringAsFixed(2)}',style: kCartScreenBottomValue),
                    ]),
                SizedBox(height:90.0),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: FlatButton(
          child: Center(
            child: Text('Checkout', style:kCheckoutBtn),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
