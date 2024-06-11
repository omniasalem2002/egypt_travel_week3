
class Touristmodel{
  final String name;
  final String phoneNumber;
  final String selectedPayment;
  final String country;
  final String placesWantToVisit;

  Touristmodel({
    required this.name,
    required this.phoneNumber,
    required this.selectedPayment,
    required this.country,
    required this.placesWantToVisit,
  });

  factory Touristmodel.fromJson(Map<String, dynamic> json) {
    return Touristmodel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      selectedPayment: json['selectedPayment'],
      country: json['country'],
      placesWantToVisit: json['placesWantToVisit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'selectedPayment': selectedPayment,
      'Country': country,
      'PlacesWantToVisit': placesWantToVisit,
    };
  }
}
