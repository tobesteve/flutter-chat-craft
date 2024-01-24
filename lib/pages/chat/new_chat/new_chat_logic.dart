import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_craft/models/user_info.dart';
import 'package:flutter_chat_craft/routes/app_navigator.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../models/contact.dart';

class NewChatLogic extends GetxController {
  late SliverObserverController observerController;
  bool isShowListMode = true;
  ScrollController scrollController = ScrollController();
  List<ContactModel> contactList = [];
  Map<int, BuildContext> sliverContextMap = {};
  ValueNotifier<CursorInfoModel?> cursorInfo = ValueNotifier(null);
  double indexBarWidth = 20;
  final indexBarContainerKey = GlobalKey();

  List<String> get symbols => contactList.map((e) => e.section).toList();

  @override
  onInit() {
    super.onInit();
    observerController = SliverObserverController(controller: scrollController);
    generateContactData();
  }

  generateContactData() {
    final a = const Utf8Codec().encode("A").first;
    final z = const Utf8Codec().encode("Z").first;
    int pointer = a;
    while (pointer >= a && pointer <= z) {
      final character = const Utf8Codec().decode(Uint8List.fromList([pointer]));
      contactList.add(
        ContactModel(
          section: character,
          users: List.generate(Random().nextInt(8), (index) {
            return UserInfo(
                userID: 1,
                userName: "hello",
                email: "email",
                phone: "phone",
                avatar: "https://img2.woyaogexing.com/2024/01/22/3dba841413d4342aca5a8b33aaba3be8.jpeg",
                motto: "当生活给你柠檬时，做柠檬水。",
                clientIp: "",
                clientPort: "");
          }),
        ),
      );
      pointer++;
    }
  }

  void startNewChat() {
    AppNavigator.startNewChat();
  }
}
