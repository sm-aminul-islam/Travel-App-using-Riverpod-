import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_riverpod/features_trip/presentation/providers/trip_provider.dart';
import 'package:travel_app_riverpod/features_trip/presentation/widgets/custom_search_bar.dart';
import 'package:travel_app_riverpod/features_trip/presentation/widgets/travel_card.dart';

class MyTripScreen extends ConsumerWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trijpList = ref.watch(tripListNotifierProvider);
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          CustomSearchBar(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: trijpList.length,
            itemBuilder: (context, index) {
              final trip = trijpList[index];
              return TravelCard(
                imageUrl: trip.photos[0],
                title: trip.title,
                description: trip.description,
                date: DateFormat.yMMMEd().format(trip.date).toString(),
                location: trip.location,
                onDelete: () {
                  ref.read(tripListNotifierProvider.notifier).removeTrip(index);
                  ref.read(tripListNotifierProvider.notifier).loadTrip();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
