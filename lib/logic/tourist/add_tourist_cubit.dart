import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guru/data/models/tourist/TouristModel.dart';
import 'package:guru/data/repos/fire_store_services_for_tourist.dart';
import 'package:guru/logic/tourist/add_tourist_state.dart';

class AddTouristCubit extends Cubit<TouristState> {
  final FireStoreServicesForTourist _fireStoreServices;

  AddTouristCubit(this._fireStoreServices) :super(TouristInitial());

  TextEditingController touristNameController = TextEditingController();
  TextEditingController touristPhoneNumberController = TextEditingController();
  TextEditingController selectedPaymentController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController placesWantToVisitController = TextEditingController();



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void addTourist() async {
    emit(TouristLoading());

    try{
      // Check if the tour guide already exists
     /* bool exists = await _fireStoreService.tourGuideExists(tourGuidePhoneNumberController.text);
      if (exists) {
        emit(TourGuideFailure(error: 'Tour guide with this phone number already exists'));
        return;
      }*/

      final response = await _fireStoreServices.addTourist(Touristmodel(name: touristNameController.text,
          phoneNumber: touristPhoneNumberController.text, selectedPayment: selectedPaymentController.text,
          country: countryController.text, placesWantToVisit: placesWantToVisitController.text));
      emit(TouristSuccess());
    }
    catch(e) {
      emit(TouristFailure(error: e.toString()));
    }}
  /*void getTourGuides(String city) async {
    emit(TouristLoading());

    try {
      final List<TourGuideRequestBody> tourGuides = await _fireStoreService.getTourGuides(city);
      emit(GetTourGuideSuccess(tourGuides: tourGuides));
    } catch (e) {
      emit(TourGuideFailure(error: e.toString()));
    }
  }*/




}
