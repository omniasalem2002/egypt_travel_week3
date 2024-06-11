
class TourGuideRequestBody {
  final String name;
  final String phoneNumber;
  final String birthDate;
  final String selectedCity;
  final String image;
  final String email;
  final String personalWebsite;
  final String professionalSummary;
  final String workExperiences;

  TourGuideRequestBody({
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
    required this.selectedCity,
    required this.image,
    required this.email,
    required this.personalWebsite,
    required this.professionalSummary,
    required this.workExperiences,
  });

  factory TourGuideRequestBody.fromJson(Map<String, dynamic> json) {
    return TourGuideRequestBody(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'],
      selectedCity: json['selectedCity'],
      image: json['image'],
      email: json['email'],
      personalWebsite: json['personalWebsite'],
      professionalSummary: json['professionalSummary'],
      workExperiences: json['workExperiences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'selectedCity': selectedCity,
      'image': image,
      'email': email,
      'personalWebsite': personalWebsite,
      'professionalSummary': professionalSummary,
      'workExperiences': workExperiences,
    };
  }
}
