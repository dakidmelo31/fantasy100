import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../utils/card_number_formatter.dart';
import '../../utils/globals.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController =
          TextEditingController(text: ''),
      _monthController = TextEditingController(text: ''),
      _nameController = TextEditingController(text: ''),
      _codeController = TextEditingController(text: ''),
      _yearController = TextEditingController(text: '');

  String digits = '';

  bool _hide = false;

  bool _save = true;

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      appBar: AppBar(
        shadowColor: Globals.primaryColor.withOpacity(.08),
        backgroundColor: Globals.primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Card Information"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6),
                          elevation: 10,
                          shadowColor: Colors.black.withOpacity(.09),
                          color: Globals.white,
                          surfaceTintColor: Globals.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 16),
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  obscureText: _hide,
                                  obscuringCharacter: "=",
                                  autofocus: true,
                                  onChanged: (value) {
                                    setState(() {
                                      digits = value.split(" ").join("");
                                    });
                                  },
                                  maxLength: 19,
                                  style: const TextStyle(
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w300),
                                  cursorColor: Globals.primaryColor,
                                  validator: (value) {
                                    debugPrint(digits);
                                    if (value == null || value.isEmpty) {
                                      return "Invalid name ❌";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Card Holder Name",
                                    label: const Text("Full Name",
                                        style: TextStyle(
                                            color: Globals.primaryColor)),
                                    border: InputBorder.none,
                                    filled: false,
                                  ),
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  controller: _numberController,
                                  textInputAction: TextInputAction.next,
                                  obscureText: _hide,
                                  obscuringCharacter: "=",
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false, signed: false),
                                  onChanged: (value) {
                                    setState(() {
                                      digits = value.split(" ").join("");
                                    });
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CardNumberFormatter()
                                  ],
                                  maxLength: 19,
                                  style: const TextStyle(
                                      fontFamily: "Lato",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300),
                                  cursorColor: Globals.primaryColor,
                                  validator: (value) {
                                    debugPrint(digits);
                                    if (digits.length != 16 ||
                                        int.tryParse(digits) == null) {
                                      return "Invalid number ❌";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        icon: const Icon(FontAwesomeIcons.eye),
                                        color: Globals.primaryColor,
                                        iconSize: 18,
                                        onPressed: () {
                                          setState(() {
                                            _hide = !_hide;
                                          });
                                        },
                                      ),
                                      hintText: "0000 0000 0000 0000",
                                      label: const Text("Card Number",
                                          style: TextStyle(
                                              color: Globals.primaryColor)),
                                      border: InputBorder.none,
                                      filled: false,
                                      counter: digits.length == 16
                                          ? const Icon(
                                              FontAwesomeIcons.check,
                                              size: 18,
                                              color: Globals.primaryColor,
                                            )
                                          : Text("${16 - digits.length} left")),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          if (int.parse(value[0]) > 1 ||
                                              int.parse(value) == 0) {
                                            Globals.toast(
                                                "Lead with Zero for single month");
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              (int.tryParse(value) ?? 20) >
                                                  12) {
                                            return "❌";
                                          }
                                          return null;
                                        },
                                        controller: _monthController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 2,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Globals.white,
                                          filled: true,
                                          hintText: "MM",
                                          label: Text(
                                            "Month",
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                color: Globals.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        controller: _yearController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          String year = '${DateTime.now().year}'
                                              .substring(2);
                                          debugPrint("Year: $year");
                                          if (value == null ||
                                              value.isEmpty ||
                                              (int.tryParse(value) ?? 100) <
                                                  int.parse(year)) {
                                            return "❌";
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 2,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Globals.white,
                                          filled: true,
                                          hintText: "YY",
                                          label: Text(
                                            "Year",
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                color: Globals.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller: _codeController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    String year =
                                        '${DateTime.now().year}'.substring(2);
                                    debugPrint("Year: $year");
                                    if (value == null || value.isEmpty) {
                                      return "Invalid number";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 3,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Globals.white,
                                    filled: true,
                                    hintText: "Code",
                                    label: Text(
                                      "3 Digit Code",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          color: Globals.primaryColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SwitchListTile.adaptive(
                          title: const Text(
                            "Save Card Details",
                            style: Globals.title,
                          ),
                          subtitle: const Text("Save for future use"),
                          value: _save,
                          inactiveThumbColor: Colors.pink,
                          activeColor: Globals.primaryColor,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          onChanged: (value) {
                            setState(() {
                              _save = value;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    color: Globals.primaryColor,
                    textColor: Colors.white,
                    elevation: 10,
                    enableFeedback: true,
                    focusElevation: 30,
                    hoverElevation: 30,
                    highlightElevation: 37,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () {
                      HapticFeedback.heavyImpact();

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        makePayment();
                      }
                    },
                    child: SizedBox(
                        width: size.width * .9,
                        child: const Center(
                            child: Text(
                          "Proceed to Pay",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ))),
                  ),
                ),
                const SizedBox(
                  height: kToolbarHeight,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: _makingPayment ? 1 : .5,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: _makingPayment ? 8 : 0,
                    sigmaY: _makingPayment ? 8 : 0),
                child: AnimatedContainer(
                  width: _makingPayment ? size.width : 0,
                  height: _makingPayment ? size.height : 0,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 300),
                  color: Globals.white.withOpacity(.15),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Lottie.asset(
                      "$dir/loading5.json",
                      repeat: true,
                      reverse: true,
                      options: LottieOptions(
                        enableMergePaths: true,
                      ),
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _makingPayment = false;
  Future<void> makePayment() async {
    setState(() {
      _makingPayment = true;
    });
    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _makingPayment = false;
        Globals.toast("Payment Successful");
      });
    });
  }
}
