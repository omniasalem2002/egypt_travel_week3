import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:guru/core/utils/colors_app.dart';

class ContactTourWithPhone extends StatelessWidget {
  final String tourGuideName;
  final String tourGuidePhoneNumber;

  const ContactTourWithPhone({
    Key? key,
    required this.tourGuideName,
    required this.tourGuidePhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contact"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "CONTACT ${tourGuideName} WITH PHONE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
             const SizedBox(height: 20),
             Center(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     tourGuidePhoneNumber,
                     style: TextStyle(fontSize: 16),
                   ),
                  const  SizedBox(width: 20),
                   IconButton(
                     icon: Icon(Icons.phone, color: ColorsApp.primaryColor),
                     onPressed: () {
                       _launchPhoneCall(tourGuidePhoneNumber);
                     },
                   ),
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

  // Function to launch phone call using url_launcher package
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
