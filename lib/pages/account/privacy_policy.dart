import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Last Updated: January 1, 2024',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We value the privacy of our users and are committed to protecting their personal information. This Privacy Policy explains how we collect, use, and disclose information when you use our application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Information Collection',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may collect personal information from you when you create an account, make a payment, or communicate with our customer support. The information we collect may include your name, email address, phone number, and payment details.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Information Use',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We use the collected information to provide and improve our services, process payments, communicate with you, and personalize your experience. We may also use the information for analytics and research purposes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Information Sharing',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may share your personal information with trusted third-party service providers who assist us in operating our application and providing our services. We may also share information in response to legal requests or to protect our rights and safety.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Security',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. However, please note that no method of transmission over the internet or electronic storage is 100% secure.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Changes to Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our Privacy Policy from time to time. Any changes will be reflected on this page, and the revised Privacy Policy will be effective immediately upon posting.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or concerns about our Privacy Policy, please contact us at privacy@hubbleparking.com.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: kToolbarHeight * 1.5,
            )
          ],
        ),
      ),
    );
  }
}
