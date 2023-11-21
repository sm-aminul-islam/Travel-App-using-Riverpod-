import 'package:travel_app_riverpod/features_trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features_trip/domain/repositories/trip_repository.dart';

class AddTrips {
  final TripRepository repository;

  AddTrips(this.repository);
  Future<void> call(Trip trip) {
    return repository.addTrip(trip);
  }
}
