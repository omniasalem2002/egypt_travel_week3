import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guru/core/component/form_for_tourist.dart';
import 'package:guru/data/models/tour_guide/TourGuideModel.dart';

class TourGuideDetail extends StatefulWidget {
  final TourGuideRequestBody tourGuide;

  const TourGuideDetail({super.key, required this.tourGuide});

  @override
  State<TourGuideDetail> createState() => _TourGuideDetailState();
}

class _TourGuideDetailState extends State<TourGuideDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tourGuide.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(flex: 1),
                Expanded(
                  flex: 18,
                  child: Card(
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.network(
                          widget.tourGuide.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Experience",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(widget.tourGuide.workExperiences),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FormForTourist(
                          tourGuideName: widget.tourGuide.name);
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 61, 58),
              ),
              child: const Text(
                "Book Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Rating",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              itemSize: 20,
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) {
                return const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 17, 1),
                );
              },
              onRatingUpdate: (rating) {
                // Handle rating update
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
