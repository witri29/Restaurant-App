import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/scheduling_provider.dart';

class RestaurantSettingPage extends StatefulWidget {
  const RestaurantSettingPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSettingPage> createState() => _RestaurantSettingPageState();
}

class _RestaurantSettingPageState extends State<RestaurantSettingPage> {
  String counterNumberPrefs = 'counterNumber';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Scheduling Resto'),
      trailing: Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
        return Switch.adaptive(
          value: scheduled.isScheduled,
          onChanged: (value) async {
            scheduled.enableDailyRestaurant(value);
            scheduled.scheduledRestaurant(value);
          },
        );
      }),
    );
  }
}
