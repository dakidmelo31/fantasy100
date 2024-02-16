import 'package:flutter/material.dart';

class AddCarDetailsPage extends StatefulWidget {
  @override
  _AddCarDetailsPageState createState() => _AddCarDetailsPageState();
}

class _AddCarDetailsPageState extends State<AddCarDetailsPage> {
  late String make;
  late String model;
  late int year;
  late String color;
  late String licensePlate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Make',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  make = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Model',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  model = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Year',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  year = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Color',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'License Plate',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  licensePlate = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save the car details to the user's account
                saveCarDetails();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveCarDetails() {
    // TODO: Implement the logic to save the car details to the user's account
    // You can use the variables 'make', 'model', 'year', 'color', and 'licensePlate' to save the data
  }
}
