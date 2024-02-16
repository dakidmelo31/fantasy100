import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/transactions/credit_card_form.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:hospital/widgets/payment_tile.dart';

import '../../utils/globals.dart';
import '../../widgets/saved_payments.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  String choice = "";

  final TextEditingController _amountController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: Column(children: [
        Expanded(
            child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: kToolbarHeight),
            const Text("Top Up", style: Globals.heading),
            const SizedBox(height: kToolbarHeight * .7),
            TextField(
              controller: _amountController,
              style: GoogleFonts.orbitron(color: Globals.black),
              maxLines: 1,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.dollarSign,
                    color: Globals.primaryColor),
                label: Text(
                  "N\$",
                  style: GoogleFonts.lato(color: Globals.primaryColor),
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: kToolbarHeight * .7),
            const Text("Choose Option", style: Globals.heading),
            const SizedBox(height: kToolbarHeight * .7),
            PaymentTile(
                onPressed: () {
                  setState(() {
                    choice = 'cash';
                  });
                  Globals.toast("changing option");
                },
                title: "Cash",
                fees: "Free / ETA: Immediate",
                subtitle: "Add funds at any store.",
                icon: FontAwesomeIcons.dollarSign),
            PaymentTile(
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  Navigator.push(
                      context, LeftTransition(child: CreditCardForm()));
                },
                title: "Debit Card",
                fees: "Fee: 0 - 3% / ETA: Immediate",
                subtitle: "Load Up with your Card.",
                icon: FontAwesomeIcons.creditCard),
            PaymentTile(
                onPressed: () {
                  Globals.toast("msg");
                },
                title: "Bank",
                fees: "Free / ETA: up to 3-5 business days",
                subtitle: "Top Up with Your Bank.",
                icon: FontAwesomeIcons.buildingColumns),
            const SizedBox(
              height: kToolbarHeight,
            ),
            const Text(
              "Saved Options",
              style: Globals.heading,
            ),
            const SizedBox(
              height: kToolbarHeight * .7,
            ),
            const SavedPayments(),
            const SizedBox(
              height: 70,
            )
          ],
        )),
        SizedBox(
          child: Row(
            children: [
              const SizedBox(width: 15),
              Card(
                elevation: 05,
                shadowColor: Globals.primaryColor.withOpacity(.25),
                color: Globals.white,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Icon(
                      FontAwesomeIcons.arrowLeftLong,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 33),
              SizedBox(
                height: kToolbarHeight,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  textColor: Globals.primaryColor,
                  color: Colors.white,
                  elevation: 0,
                  enableFeedback: true,
                  focusElevation: 30,
                  hoverElevation: 30,
                  highlightElevation: 37,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {},
                  child: SizedBox(
                      width: size.width * .65,
                      child: const Center(
                          child: Text(
                        "Proceed to Pay",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kToolbarHeight,
        )
      ]),
    );
  }
}
