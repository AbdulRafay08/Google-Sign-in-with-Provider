import 'dart:ffi';

import 'package:chat_app/Providers/auth_provider.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../models/popup_choices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitincremenet = 20;
  String _textSearch = "";
  bool isLoading = false;

  late String currentUserId;
  late AuthProvider authProvider;
  // late HomeProvider homeProvider;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(icon: Icons.settings, title: "Settings")
  ];

  void handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void scrolListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        listScrollController.position.outOfRange) {
      setState(() {
        _limit = 20;
        
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == "Sign out") {
      handleSignOut();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingPage(),
        ),
      );
    }
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
      onSelected: onItemMenuPress,
      itemBuilder: ((BuildContext context) {
        return choices.map((PopupChoices choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(width: 10),
                  Text(choice.title,
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                      )),
                ],
              ));
        });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
    listScrollController.addListener(scrolListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black45,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        actions: [
          buildPopupMenu(),
        ],
      ),
    );
  }
}
