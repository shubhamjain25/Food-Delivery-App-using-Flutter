import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';

class NearbyRestaurants extends StatefulWidget {
  @override
  _NearbyRestaurantsState createState() => _NearbyRestaurantsState();
}

class _NearbyRestaurantsState extends State<NearbyRestaurants> {
  _nearbyRestaurantCards() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>RestaurantScreen(selectedRestaurant: restaurant)),);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 1.0,
                color: Colors.grey[200],
              ),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Hero(
                        tag: restaurant.imageUrl,
                        child: Image(
                          image: AssetImage(restaurant.imageUrl),
                          height: 130.0,
                          width: 130.0,
                          fit: BoxFit.cover,
                        ),),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 3,
                    child: Container(
//                color:Colors.red,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                restaurant.name,
                                style: kTitleStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              child:
                              RatingStars(ratingCount: restaurant.rating),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                restaurant.address,
                                style: kRecentOrderText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  // A special or most ordered or distance can also be added in the blankspace.
                ]),
          ),
        ),
      );
    });

    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Nearby Restaurants',
              style: kHeadingStyle.copyWith(fontSize: 22.0),
            ),
          ),
          _nearbyRestaurantCards(),
        ]);
  }
}

class RatingStars extends StatelessWidget {
  final int ratingCount;
  String stars = '';

  RatingStars({@required this.ratingCount});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < ratingCount; i++) {
      stars = stars + '⭐';
    }
    return Text(stars);
  }
}
