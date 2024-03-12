import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/globals.dart';

class ProfilerPage extends StatelessWidget {
  const ProfilerPage({
    Key? key,
    required this.value,
    required this.maxheight,
    required this.maxWidth,
    this.isView = false,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onTapBtnClose,
  }) : super(key: key);
  final double value;
  final double maxheight;
  final double maxWidth;
  final bool isView;

  final void Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final void Function(DragEndDetails details)? onVerticalDragEnd;
  final VoidCallback? onTapBtnClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: lerpDouble(50, 0, value)!),
      child: SizedBox(
        height: maxheight,
        width: maxWidth,
        child: Material(
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(lerpDouble(20, 0, value)!),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Globals.transparent,
                  borderRadius:
                      BorderRadius.circular(lerpDouble(30, 0, value)!),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Material(
                  shape: Globals.radius(26),
                  color: Colors.white,
                  elevation: 0,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      //HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Hello ',
                              style: Helpers.txtNameUser,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'Mr Melo FC',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: lerpDouble(75, 50, value),
                            height: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      width: 50,
                                      height: 50,
                                      imageUrl: Globals.photoPlaceholder,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Opacity(
                                    opacity: lerpDouble(1, 0, value)!,
                                    child: CircleAvatar(
                                      minRadius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Flexible(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: User.listUser.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemExtent: (MediaQuery.of(context).size.width / 5) -
                              lerpDouble(0, 10, value)!,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemBuilder: (__, item) {
                            final widthChild =
                                (MediaQuery.of(context).size.width / 5) -
                                    lerpDouble(0, 10, value)!;
                            return FittedBox(
                              child: ItemCircleUser(
                                name: User.listUser[item].name,
                                width: widthChild,
                              ),
                            );
                          },
                        ),
                      ),
                      if (value >= .3) const SizedBox(height: 20),

                      Flexible(
                        flex: 1,
                        child: value <= 0.20
                            ? const SizedBox.shrink()
                            : Opacity(
                                opacity: value,
                                child: Container(
                                  // height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue.shade300,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Helpers.purpleLigth_color,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    Helpers.purpleLigth_color,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                'Holiday goal',
                                                style: Helpers.txtHoliday,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '100 5000',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Helpers.purpleColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    Helpers.fontPrincipal,
                                                fontSize: 25,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      if (value >= .3) const SizedBox(height: 20),
                      Flexible(
                        flex: 3,
                        child: value <= 0.20
                            ? const SizedBox.shrink()
                            : Opacity(
                                opacity: value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (value >= .60) ...[
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.credit_card,
                                                  size: 50,
                                                  color: Helpers.purpleColor,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Pay for services',
                                                  style: Helpers.txtList,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.credit_card,
                                                  size: 50,
                                                  color: Helpers.purpleColor,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'TaKE A LOAN ',
                                                  style: Helpers.txtList,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '4%',
                                                  style: Helpers.txtList,
                                                ),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onVerticalDragUpdate:
                                                onVerticalDragUpdate,
                                            onVerticalDragEnd:
                                                onVerticalDragEnd,
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: onTapBtnClose,
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Helpers
                                                        .purpleLigth_color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    color: Helpers.purpleColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Helpers {
  static const _konnectFont = 'Konnect';

  static String get fontPrincipal => _konnectFont;

  static const Color purpleLigth_color = Color(0xffdddffe);
  static const Color blueColor = Color(0xff0a094b);
  static const Color blueColor2 = Color(0xff020080);

  static Color purpleColor = Colors.purple.shade900;

  static TextStyle txtNameUser = TextStyle(
    color: purpleColor,
    fontWeight: FontWeight.normal,
    fontFamily: _konnectFont,
    fontSize: 25,
  );

  static TextStyle txtName = TextStyle(
    color: purpleColor,
    fontWeight: FontWeight.normal,
    fontFamily: _konnectFont,
  );

  static TextStyle txtHoliday = TextStyle(
    color: purpleColor.withOpacity(0.50),
    fontWeight: FontWeight.bold,
    fontFamily: _konnectFont,
  );

  static TextStyle txtList = TextStyle(
    color: purpleColor,
    fontWeight: FontWeight.normal,
    fontFamily: _konnectFont,
    fontSize: 15,
  );
}

class User {
  final int id;
  final String img;
  final String imgProfile;
  final bool status;
  final String name;
  final String surname;

  User({
    required this.id,
    required this.img,
    required this.name,
    required this.surname,
    required this.imgProfile,
    required this.status,
  });

  static const _path = 'assets/images/2_challenge_whatsapp';
  static List<User> get listUser => [
        User(
          id: 1,
          img: '$_path/p1_1.jpg',
          imgProfile: '$_path/p1_2.jpg',
          name: 'Jean',
          surname: 'Roldan',
          status: true,
        ),
        User(
          id: 2,
          img: '$_path/p2_1.jpg',
          imgProfile: '$_path/p2_2.jpg',
          name: 'Mika',
          surname: 'Bettosini',
          status: true,
        ),
        User(
          id: 3,
          img: '$_path/p3_1.jpg',
          imgProfile: '$_path/p3_2.jpg',
          name: 'Mauricio',
          surname: 'Lopez',
          status: true,
        ),
        User(
          id: 4,
          img: '$_path/p4_1.jpg',
          imgProfile: '$_path/p4_2.jpg',
          name: 'Brayan',
          surname: 'Cantos',
          status: true,
        ),
        User(
          id: 5,
          img: '$_path/p5_1.jpg',
          imgProfile: '$_path/p5_2.jpg',
          name: 'Jose',
          surname: 'Loor',
          status: true,
        ),
        User(
          id: 6,
          img: '$_path/p6_1.jpg',
          imgProfile: '$_path/p6_2.jpg',
          name: 'Darwin',
          surname: 'Morocho',
          status: true,
        ),
        User(
          id: 7,
          img: '$_path/p7_1.jpg',
          imgProfile: '$_path/p7_2.jpg',
          name: 'Brian',
          surname: 'Castillo',
          status: true,
        ),
        User(
          id: 8,
          img: '$_path/p8_1.jpg',
          imgProfile: '$_path/p8_2.jpg',
          name: 'Lis',
          surname: 'Rengifo',
          status: true,
        ),
        User(
          id: 9,
          img: '$_path/p9_1.jpg',
          imgProfile: '$_path/p9_2.jpg',
          name: 'Jeanmartin',
          surname: 'Pachas',
          status: true,
        ),
        User(
          id: 10,
          img: '$_path/p10_1.jpg',
          imgProfile: '$_path/p10_2.jpg',
          name: 'Diego',
          surname: 'Velasquez',
          status: true,
        ),
      ];
}

class Bank {
  final int id;
  final String img;
  final String pricing;

  Bank({
    required this.id,
    required this.img,
    required this.pricing,
  });

  static const _path = 'assets/images/3_challenge_diego';
  static List<Bank> get listBank => [
        Bank(id: 1, img: '$_path/1.jpg', pricing: '\$10346'),
        Bank(id: 2, img: '$_path/2.jpg', pricing: '\$1036'),
        Bank(id: 3, img: '$_path/3.jpg', pricing: '\$102'),
      ];
}

class ItemCircleUser extends StatelessWidget {
  const ItemCircleUser({
    Key? key,
    required this.name,
    required this.width,
    this.backgroundImage,
    this.child,
  }) : super(key: key);
  final String name;
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: Globals.photoPlaceholder,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Helpers.txtName,
            ),
          )
        ],
      ),
    );
  }
}
