import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/person.dart';
import '../../utils/globals.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key, required this.me}) : super(key: key);
  final Person me;
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(color: Globals.primaryColor),
            actions: [
              IconButton(
                icon: Icon(Icons.add_a_photo_rounded,
                    color: Globals.primaryColor),
                onPressed: () {
                  Globals.toast("Move to upload screen");
                },
              )
            ],
            title: Hero(
              tag: me.name,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  me.name,
                  style: Globals.title,
                ),
              ),
            )),
        backgroundColor: Globals.transparent,
        body: Center(
          child: Hero(
            tag: me.image.toUpperCase(),
            child: CachedNetworkImage(
              imageUrl: me.image,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) => placeholder,
              errorWidget: (context, url, error) => mainLoader,
              width: size.width * .9,
              height: size.width * .9,
            ),
          ),
        ));
  }
}
