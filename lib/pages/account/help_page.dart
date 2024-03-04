import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late final List<Map<String, String>> faqList = [
    {
      'question': 'How do I create an account on the app?',
      'answer':
          'To create an account, simply navigate to the registration page and provide the required information. Once submitted, your account will be created.'
    },
    {
      'question': 'Can I add multiple vehicles to my account?',
      'answer':
          'Yes, you can add multiple vehicles to your account. In the app settings, you will find an option to add and manage your vehicles.'
    },
    {
      'question': 'How do I top up my balance in the app?',
      'answer':
          'To top up your balance, go to the "Balance" or "Wallet" section in the app. There, you will find options to add funds using various payment methods.'
    },
    {
      'question':
          'What payment methods are accepted for topping up my balance?',
      'answer':
          'We accept bank transfers, debit cards, and payments made at physical stores.'
    },
    {
      'question': 'Can I top up my balance at a physical store?',
      'answer':
          'Yes, you can top up your balance at physical stores. Simply visit the nearest authorized store and provide them with your account details.'
    },
    {
      'question': 'How do I show my QR code at the entrance to gain access?',
      'answer':
          'When you arrive at the parking area, open the app and navigate to the homepage. Display the QR code on your phone to the designated scanner or staff at the entrance.'
    },
    {
      'question':
          'What should I do if I encounter issues with accessing the parking area?',
      'answer':
          'If you encounter any issues while accessing the parking area, please seek assistance from the parking staff or contact our customer support for further guidance.'
    },
    {
      'question': 'How do I scan my QR code to exit the parking area?',
      'answer':
          'To exit the parking area, simply scan your QR code at the designated scanner or staff near the exit gate. This will indicate that you are leaving.'
    },
    {
      'question': 'How is the cost calculated for parking?',
      'answer':
          'The cost for parking is calculated based on the duration of your stay. It may vary depending on the parking rates set by the business.'
    },
    {
      'question':
          'Can I view my parking history and associated costs in the app?',
      'answer':
          'Yes, you can view your parking history and associated costs in the app. Go to the "History" or "Transactions" section to access this information.'
    },
    {
      'question':
          'What happens if my balance is insufficient to exit the parking area?',
      'answer':
          'If your balance is insufficient to exit the parking area, you will need to top up your account balance using one of the available payment methods.'
    },
    {
      'question':
          'How can I pay physically at the shop counter if my balance is low?',
      'answer':
          'If your balance is low and you are unable to exit, you can visit the shop counter at the parking area and make a payment to cover the outstanding amount.'
    },
    {
      'question': 'Is my personal and payment information secure in the app?',
      'answer':
          'Yes, we prioritize the security of your personal and payment information. We use encryption and follow industry best practices to ensure your data is protected.'
    },
    {
      'question': 'Can I update my car details in the app?',
      'answer':
          'Yes, you can update your car details in the app. Navigate to the Cars section in "My Account" page to make changes to your vehicle information.'
    },
    {
      'question':
          'How can I contact customer support for any issues or questions?',
      'answer':
          'If you have any issues or questions, you can reach out to our customer support team. Contact details can be found in the "Help" or "Contact Us" section of the app.'
    },
    // Add more Q&As in the same format
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      appBar: AppBar(
        title: Text("Help"),
        foregroundColor: Globals.primaryBackground,
        backgroundColor: Globals.backgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          final Map<String, dynamic> faq = faqList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              title: Text(
                faq["question"],
                style: Globals.title,
              ),
              subtitle: Text(
                faq['answer'],
                style: TextStyle(fontFamily: "Lato", fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
