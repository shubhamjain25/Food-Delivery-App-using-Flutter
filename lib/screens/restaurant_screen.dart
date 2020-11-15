import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/widgets/NearbyRestaurants.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant selectedRestaurant;

  RestaurantScreen({this.selectedRestaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Color favColor;

  _buildMenuItems(Food menuItem) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(menuItem.imageUrl),
              ),
            ),
          ),
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black87.withOpacity(0.3),
                    Colors.black54.withOpacity(0.3),
                    Colors.black38.withOpacity(0.3),
                  ],
                  stops: [0.1, 0.4, 0.6, 0.9],
                )),
          ),
          Positioned(
            bottom: 60.0,
            child: Center(
              child: Column(children: <Widget>[
                // TODO: Text is overflowing, check Rest4.
                Container(
                  width: 150.0,
//                  color:Colors.blue,
                  child: Text(
                    menuItem.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: kHeadingStyle.copyWith(
                        color: Colors.white, fontSize: 23.0),
                  ),
                ),
                Text(
                  '\$${menuItem.price}',
                  style: kRecentOrderText.copyWith(
                      color: Colors.white, fontSize: 20.0),
                ),
              ]),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              GestureDetector(
                onTap: () {
                  print('Add button tapped');
                },
                child: Icon(
                  Icons.add,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: widget.selectedRestaurant.imageUrl,
              child: Image(
                image: AssetImage(widget.selectedRestaurant.imageUrl),
                width: MediaQuery.of(context).size.width,
                // So that image width gets 100% on any device of any size
                height: 220.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {});
                        }),
                  ]),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.selectedRestaurant.name,
                        style: kTitleStyle.copyWith(fontSize: 25.0),
                      ),
                      Text('0.2 miles away', style: kRecentOrderText),
                      // Actual functionality is to be added here
                    ]),
                SizedBox(height: 7.0),
                RatingStars(ratingCount: widget.selectedRestaurant.rating),
                SizedBox(height: 7.0),
                Text(widget.selectedRestaurant.address,
                    overflow: TextOverflow.ellipsis, style: kRecentOrderText),
                SizedBox(height: 7.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Reviews',
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Contact',
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                    ]),
                SizedBox(height: 7.0),
              ]),
        ),
        Text('Menu', style: kHeadingStyle),
        Expanded(
          child: GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            crossAxisCount: 2,
            children:List.generate(
                widget.selectedRestaurant.menu.length, (index) {
              Food food = widget.selectedRestaurant.menu[index];
              return _buildMenuItems(food);
            }),
          ),
        ),
      ]),
    );
  }
}
