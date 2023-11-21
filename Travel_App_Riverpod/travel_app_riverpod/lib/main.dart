import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_app_riverpod/features_trip/data/models/trip_model.dart';
import 'package:travel_app_riverpod/features_trip/data/models/trip_model_adapter.dart';
import 'package:travel_app_riverpod/features_trip/presentation/pages/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationCacheDirectory()).path);
  Hive.registerAdapter(TripModelAdapter());

  await Hive.openBox<TripModel>('trips');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      home: MainScreen(),
    );
  }
}
