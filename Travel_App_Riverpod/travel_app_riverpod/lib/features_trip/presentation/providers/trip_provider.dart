import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_app_riverpod/features_trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_riverpod/features_trip/data/models/trip_model.dart';
import 'package:travel_app_riverpod/features_trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app_riverpod/features_trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features_trip/domain/repositories/trip_repository.dart';
import 'package:travel_app_riverpod/features_trip/domain/usescases/add_trips.dart';
import 'package:travel_app_riverpod/features_trip/domain/usescases/delete_trips.dart';
import 'package:travel_app_riverpod/features_trip/domain/usescases/get_trips.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrips>(
  (ref) {
    final repository = ref.read(tripRepositoryProvider);
    return AddTrips(repository);
  },
);

final getTripsProvider = Provider<GetTrips>(
  (ref) {
    final repository = ref.read(tripRepositoryProvider);
    return GetTrips(repository);
  },
);

final deleteTripProvider = Provider<DeleteTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrips(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrips _addTrips;
  final DeleteTrips _deleteTrips;

  TripListNotifier(this._getTrips, this._addTrips, this._deleteTrips)
      : super([]);
  Future<void> addNewTrip(Trip trip) async {
    await _addTrips(trip);
  }

  Future<void> removeTrip(int trip) async {
    await _deleteTrips(trip);
  }

  Future<void> loadTrip() async {
    final tripOrFailure = await _getTrips();
    tripOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
}
