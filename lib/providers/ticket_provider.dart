import 'package:bus_ticket_register/common/common_functions.dart';
import 'package:bus_ticket_register/models/error_response_model.dart';
import 'package:bus_ticket_register/models/reports_model.dart';
import 'package:bus_ticket_register/models/save_ticket_body.dart';
import 'package:bus_ticket_register/models/save_ticket_response.dart';
import 'package:bus_ticket_register/services/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:bus_ticket_register/models/places_model.dart';
import 'package:bus_ticket_register/screens/billing/place_picker_screen.dart';
import 'package:bus_ticket_register/services/provider_helper_class.dart';

class PlacesInitialData {
  final List<PlaceOption> places;
  PlacesInitialData({required this.places});
}

class TicketProvider extends ChangeNotifier with ProviderHelperClass {
  PlacesModel? placesResponse;
  PlacesInitialData? initialDataList;



  int? fromPlaceId;
  int? toPlaceId;
  String? fromPlaceName;
  String? toPlaceName;

  bool isPlacesLoading = false;
  String? placesErrorMessage;

  SaveTicketResponse? saveTicketResponse;
  String? errorMessage;

  ReportsModel? reportsResponse;
  String? reportErrorMessage;

  bool isReportsLoading = false;

  Future<bool> getInitialDataList() async {
    isPlacesLoading = true;
    placesErrorMessage = null;
    notifyListeners();

    try {
      final res = await serviceConfig.getPlaces();
      if (res.isValue) {
        final List<FromPlace> stops = res.asValue!.value;
        initialDataList = PlacesInitialData(
          places:
              stops.map((s) => PlaceOption(id: s.id, name: s.name)).toList(),
        );
      } else {
        initialDataList = null;
        placesErrorMessage = 'Unable to load places';
      }
    } catch (e) {
      debugPrint('TicketProvider getInitialDataList error: $e');
      initialDataList = null;
      placesErrorMessage = 'Something went wrong while loading places';
    } finally {
      isPlacesLoading = false;
      notifyListeners();
    }
    return initialDataList?.places.isNotEmpty ?? false;
  }

  Future<PlacesModel?> getPlaces({
    required int fromplace,
    required int toplace,
  }) async {
    isPlacesLoading = true;
    placesErrorMessage = null;
    notifyListeners();

    try {
      final res = await serviceConfig.getFareDetails(
        fromplace: fromplace,
        toplace: toplace,
      );

      if (res.isValue) {
        placesResponse = res.asValue!.value as PlacesModel;
        placesErrorMessage = null;
        return placesResponse;
      } else {
        placesResponse = null;
        placesErrorMessage = 'Unable to fetch fare details';
        return null;
      }
    } catch (e) {
      debugPrint('getPlaces provider error: $e');
      placesResponse = null;
      placesErrorMessage = 'Something went wrong while fetching fare details';
      return null;
    } finally {
      isPlacesLoading = false;
      notifyListeners();
    }
  }



Future<void> saveTicket({
  required int fromPlaceId,
  required int toPlaceId,
  required int passengers,
  required double fare,
  required DateTime date,
  Function? onSuccess,
  Function? onFailure,
}) async {
  updateLoadState(LoaderState.loading);
  try {
    final body = SaveTicketBody(
      fromPlaceId: fromPlaceId,
      toPlaceId: toPlaceId,
      passengers: passengers,
      fare: fare.round(),
      totalAmount: (fare * passengers).round(),
      date: date,
    );
    final res = await serviceConfig.saveTicket(body);
    if (res.isValue) {
      saveTicketResponse = res.asValue!.value;
      onSuccess?.call();
    } else {
      final err = res.asError!.error;
      errorMessage = err is ErrorResponseModel
          ? (err.errorMessage ?? 'Unable to save ticket')
          : 'Unable to save ticket';
      onFailure?.call();
    }
  } on AppException catch (e) {
    errorMessage = e.message ?? 'Something went wrong';
    onFailure?.call();
  } finally {
    updateLoadState(LoaderState.loaded);
  }
}

  Future<ReportsModel?> getReports({required String fromDate, required String toDate}) async {
    isReportsLoading = true;
    reportErrorMessage = null;
    notifyListeners();

    try {
      final res = await serviceConfig.getReport(fromDate,toDate);

      if (res.isValue) {
        reportsResponse = res.asValue!.value as ReportsModel;
        reportErrorMessage = null;
        return reportsResponse;
      } else {
        reportsResponse = null;
        reportErrorMessage = 'Unable to fetch report details';
        return null;
      }
    } catch (e) {
      debugPrint('getReports provider error: $e');
      reportsResponse = null;
      reportErrorMessage = 'Something went wrong while fetching report details';
      return null;
    } finally {
      isReportsLoading = false;
      notifyListeners();
    }
  }








  void clearPlaces() {
    placesResponse = null;
    fromPlaceId = null;
    toPlaceId = null;
    fromPlaceName = null;
    toPlaceName = null;
    placesErrorMessage = null;
    isPlacesLoading = false;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
