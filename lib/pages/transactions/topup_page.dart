import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/globals.dart';
import '../../utils/transitions.dart';
import '../../widgets/saved_payments.dart';

import 'credit_card_form.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.fees,
      required this.subtitle,
      required this.icon});
  final VoidCallback onPressed;
  final String title;
  final String fees;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      surfaceTintColor: Globals.white,
      shadowColor: Colors.black.withOpacity(.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(0))),
                  elevation: 0,
                  color: Globals.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 26),
                    child: Icon(
                      icon,
                      size: 20,
                      color: Globals.white,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 6.0, bottom: 2.0),
                      child: Text(
                        title,
                        style: Globals.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 0),
                      child: Text(
                        subtitle,
                        style: Globals.subtitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 6.0, bottom: 2.0),
                      child: Text(
                        fees,
                        style: Globals.feeText,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Card(
              surfaceTintColor: Globals.primaryColor,
              shape: const CircleBorder(),
              color: Globals.white,
              elevation: 6,
              shadowColor: Globals.primaryColor.withOpacity(.09),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Globals.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  final TextEditingController _textController = TextEditingController();

  bool makingDeposit = false;
  String choice = "";

  final TextEditingController _amountController =
      TextEditingController(text: '');

  int amount = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final me = provider.me;

    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(children: [
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
                  autofocus: true,
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        int.tryParse(_textController.text.trim()) != null) {
                      amount = int.tryParse(_textController.text.trim()) ?? 0;
                      setState(() {});
                      return;
                    }
                  },
                  controller: _amountController,
                  style: GoogleFonts.orbitron(color: Globals.black),
                  maxLines: 1,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(FontAwesomeIcons.dollarSign,
                        color: Globals.primaryColor),
                    label: Text(
                      "CFA ",
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
                    onPressed: () async {
                      int? amt =
                          int.tryParse(_amountController.text.trim()) ?? 0;

                      if (amt <= 0) {
                        setState(() {
                          makingDeposit = true;
                        });
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          toast(message: "Unsupported amount entered");
                          setState(() {
                            makingDeposit = false;
                          });
                        });
                        return;
                      }

                      amount = amt;
                      // return;

                      setState(() {
                        makingDeposit = true;
                      });
                      await messaging
                          .subscribeToTopic("${auth.currentUser!.uid}_momo");
                      if (amount > 0) {
                        await Globals.makeDeposit(amount: amt)
                            .then((value) => Navigator.pop(context))
                            .catchError((onError) {
                          debugPrint("error occured");
                          setState(() {
                            makingDeposit = false;
                          });
                        });
                      } else {
                        toast(
                            message:
                                "We cannot deposit ${prettyNumber(amount)} CFA");
                      }
                      setState(() {
                        makingDeposit = false;
                      });
                    },
                    title: "Mobile Money",
                    fees: "MTN / Orange: Immediate",
                    subtitle: "Fees: 2%.",
                    icon: FontAwesomeIcons.dollarSign),
                Opacity(
                  opacity: .5,
                  child: PaymentTile(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        toast(message: "Not Available now");
                        if (false) {
                          Navigator.push(context,
                              LeftTransition(child: const CreditCardForm()));
                        }
                      },
                      title: "Debit Card",
                      fees: "Fee: 0 - 3% / ETA: Immediate",
                      subtitle: "Load Up with your Card.",
                      icon: FontAwesomeIcons.creditCard),
                ),
                Opacity(
                  opacity: .5,
                  child: PaymentTile(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        toast(message: "Not Available now");
                      },
                      title: "Bank",
                      fees: "Free / ETA: up to 3-5 business days",
                      subtitle: "Top Up with Your Bank.",
                      icon: FontAwesomeIcons.buildingColumns),
                ),
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
                const Opacity(opacity: .5, child: SavedPayments()),
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
                    surfaceTintColor: Globals.white,
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
                      onPressed: () async {
                        int? amt =
                            int.tryParse(_amountController.text.trim()) ?? 0;

                        if (amt <= 0) {
                          setState(() {
                            makingDeposit = true;
                          });
                          Future.delayed(const Duration(milliseconds: 1500),
                              () {
                            toast(message: "Unsupported amount entered");
                            setState(() {
                              makingDeposit = false;
                            });
                          });
                          return;
                        }

                        amount = amt;
                        // return;

                        setState(() {
                          makingDeposit = true;
                        });
                        await messaging
                            .subscribeToTopic("${auth.currentUser!.uid}_momo");
                        if (amount > 0) {
                          await Globals.makeDeposit(amount: amt)
                              .catchError((onError) {
                            debugPrint("error occured");
                            setState(() {
                              makingDeposit = false;
                            });
                          });
                        } else {
                          toast(
                              message:
                                  "We cannot deposit ${prettyNumber(amount)} CFA");
                        }
                        setState(() {
                          makingDeposit = false;
                        });
                      },
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
              height: kToolbarHeight * .36,
            )
          ]),
          AnimatedPositioned(
            curve: Curves.fastLinearToSlowEaseIn,
            left: makingDeposit ? 0 : size.width / 2,
            top: 0,
            width: makingDeposit ? size.width : 0,
            height: size.height,
            duration: Globals.mainDurationLonger,
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              color: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(""),
                        placeholder,
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                toast(
                                    message:
                                        "Please Cancel this request if it finally comes",
                                    length: Toast.LENGTH_LONG);
                                makingDeposit = false;
                              });
                            },
                            shape: const CircleBorder(),
                            backgroundColor: Globals.white,
                            child: const Icon(FontAwesomeIcons.xmark,
                                size: 20, color: Globals.primaryColor),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
