part of 'home_bloc.dart';

class HomeEvent {}

class GetProfileGalleryEvent extends HomeEvent {
  final NoParams params;
  GetProfileGalleryEvent({required this.params});
}

class GetProfileCameraEvent extends HomeEvent {
  final NoParams params;
  GetProfileCameraEvent({required this.params});
}

class GetHouseDocumentCameraEvent extends HomeEvent {
  final NoParams params;
  GetHouseDocumentCameraEvent({required this.params});
}

class GetHouseDocumentGalleryEvent extends HomeEvent {
  final NoParams params;
  GetHouseDocumentGalleryEvent({required this.params});
}

class AddMultipleImageEvent extends HomeEvent {
  final NoParams params;

  AddMultipleImageEvent({required this.params});
}

class AddHomeEvent extends HomeEvent {
  final Map<String, dynamic> params;
  AddHomeEvent({required this.params});
}

class GetAllHousesEvent extends HomeEvent {
  final Map<String, dynamic> params;
  GetAllHousesEvent({required this.params});
}

class UpLoadMultipleImageEvent extends HomeEvent {
  final Map<String, dynamic> params;
   UpLoadMultipleImageEvent({required this.params});
}

class UpdateHouseEvent extends HomeEvent {
  final Map<String,dynamic> params;
  UpdateHouseEvent({required this.params});
}

class PlaceSearchEvent extends HomeEvent {
  final Map<String,dynamic> params;
  PlaceSearchEvent({required this.params});
}


class GetPlaceByLatLngEvent extends HomeEvent {
  final Map<String,dynamic> params;
  GetPlaceByLatLngEvent({required this.params});
}

class AddLocationEvent extends HomeEvent{
  final Map<String,dynamic> params;
  AddLocationEvent({required this.params});
}
