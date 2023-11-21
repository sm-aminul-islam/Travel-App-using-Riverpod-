import 'package:dartz/dartz.dart';
import 'package:travel_app_riverpod/features_trip/core.error/failure.dart';
import 'package:travel_app_riverpod/features_trip/domain/entities/trip.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();
  Future<void> addTrip(Trip trip);
  Future<void> deleteTrip(int index);
}
