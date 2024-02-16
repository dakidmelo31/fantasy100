import 'package:flutter/material.dart';

class HubbleTermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hubble Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hubble Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Last Updated: January 1, 2022',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By using our Hubble application, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Use of the Hubble Application',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You may use the Hubble application for personal and non-commercial purposes. You must not use the application in any way that violates any applicable laws or regulations.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. User Accounts for Hubble',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'To access certain features of the Hubble application, you may be required to create a user account. You are responsible for maintaining the confidentiality of your Hubble account credentials and for all activities that occur under your account.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Intellectual Property Rights for Hubble',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'All intellectual property rights in the Hubble application and its content are owned by us. You may not use, reproduce, or distribute any part of the application without our prior written consent.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Limitation of Liability for Hubble',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the Hubble application or these Terms and Conditions.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Governing Law and Jurisdiction for Hubble',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'These Terms and Conditions for the Hubble application shall be governed by and construed in accordance with the laws of [Your Country/State]. Any disputes arising out of or in connection with these terms shall be submitted to the exclusive jurisdiction of the courts in [Your Country/State].',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Changes to Terms and Conditions for Hubble',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update these Terms and Conditions for the Hubble application from time to time. Any changes will be reflected on this page, and the revised Terms and Conditions will be effective immediately upon posting.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or concerns about our Terms and Conditions for the Hubble application, please contact us at terms@example.com.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: kToolbarHeight * 1.4,
            )
          ],
        ),
      ),
    );
  }
}
