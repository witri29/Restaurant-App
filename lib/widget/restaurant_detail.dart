import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/style.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';
import 'package:resto_app/data/model/restaurant_list.dart';
import 'package:resto_app/provider/database_provider.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;
  final Restaurantlist restaurantlist;

  const RestaurantDetail(
      {Key? key, required this.restaurant, required this.restaurantlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              var isFavourited = snapshot.data ?? false;
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/medium/" +
                              restaurant.pictureId,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: myTextTheme.headline6,
                                    ),
                                    isFavourited == true
                                        ? IconButton(
                                            onPressed: () =>
                                                provider.removeFavorite(
                                                    restaurantlist.id),
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.deepPurple,
                                            ))
                                        : IconButton(
                                            onPressed: () => provider
                                                .addFavorite(restaurantlist),
                                            icon: const Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.deepPurple,
                                            )),
                                    _sizebox(10),
                                    Row(
                                      children: [
                                        _icon(Icons.location_on, 20,
                                            Colors.deepPurple),
                                        Text(
                                          ' ${restaurant.city}',
                                          style: myTextTheme.bodyText2,
                                        ),
                                      ],
                                    ),
                                    _sizebox(10),
                                    Row(
                                      children: [
                                        _icon(Icons.star_rate, 20,
                                            Colors.deepPurple),
                                        Text(
                                          ' ${restaurant.rating}',
                                          style: myTextTheme.bodyText2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _barrierContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: Text('Description',
                                    style: myTextTheme.headline6),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 20, left: 20, bottom: 20),
                                  width: double.infinity,
                                  child: Text(restaurant.description,
                                      style: myTextTheme.bodyText2)),
                            ],
                          ),
                          _barrierContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: Text('Category',
                                    style: myTextTheme.headline6),
                              ),
                              ListBody(
                                children: restaurant.categories.map((food) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 20, left: 20, bottom: 5),
                                    child: Text(
                                      '- ${food.name}',
                                      style: myTextTheme.bodyText2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          _barrierContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: Text('Menu Food',
                                    style: myTextTheme.headline6),
                              ),
                              ListBody(
                                children:
                                    restaurant.menus.foods.map((categori) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 20, left: 20, bottom: 5),
                                    child: Text(
                                      '- ${categori.name}',
                                      style: myTextTheme.bodyText2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          _barrierContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: Text('Menu Drink',
                                    style: myTextTheme.headline6),
                              ),
                              ListBody(
                                children: restaurant.menus.drinks.map((drink) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 20, left: 20, bottom: 5),
                                    child: Text(
                                      '- ${drink.name}',
                                      style: myTextTheme.bodyText2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          _barrierContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: Text('Comment',
                                    style: myTextTheme.headline6),
                              ),
                              ListBody(
                                children:
                                    restaurant.customerReviews.map((review) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 20, left: 20, bottom: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.deepPurpleAccent),
                                          child: Center(
                                              child: Text(
                                            review.name.characters.elementAt(0),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _sizebox(10),
                                              Row(
                                                children: [
                                                  Text(
                                                    review.name,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    ' ${review.date}',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade500),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 270,
                                                child: Text(
                                                  review.review,
                                                  style: myTextTheme.overline,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          _barrierContent()
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

Widget _barrierContent() {
  return Container(
    height: 10,
    color: Colors.grey.shade200,
  );
}

Widget _sizebox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget _icon(IconData icon, double size, Color color) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}
