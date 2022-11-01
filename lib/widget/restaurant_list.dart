import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant_list.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurantlist restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RestaurantDetailPage(
                restaurantlist: restaurant,
              );
            }));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/" +
                              restaurant.pictureId)),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black),
                      ),
                      iconWithText(
                        context,
                        icon: Icons.location_on,
                        text: restaurant.city,
                      ),
                      iconWithText(
                        context,
                        icon: Icons.star,
                        text: '${restaurant.rating}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Row iconWithText(BuildContext context, {IconData? icon, required String text}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 15,
        color: Colors.blueGrey,
      ),
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: Colors.deepPurple),
      ),
    ],
  );
}
