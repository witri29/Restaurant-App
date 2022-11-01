import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/navigation.dart';
import 'package:resto_app/common/style.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/db/database_helper.dart';
import 'package:resto_app/data/model/restaurant_list.dart';
import 'package:resto_app/data/preferences/preferences_helper.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/provider/restaurant_list.dart';
import 'package:resto_app/provider/scheduling_provider.dart';
import 'package:resto_app/provider/search_restaurant.dart';
import 'package:resto_app/ui/home_page.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/ui/restaurant_list_page.dart';
import 'package:resto_app/utils/background_service.dart';
import 'package:resto_app/utils/notification_helper.dart';
import 'package:resto_app/widget/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => SearchRestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: secondaryColor,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          RestaurantHomePage.routeName: (context) => const RestaurantHomePage(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurantlist: ModalRoute.of(context)?.settings.arguments
                    as Restaurantlist,
              ),
        },
      ),
    );
  }
}
