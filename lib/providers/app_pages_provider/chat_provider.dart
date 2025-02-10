import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../../config.dart';
import '../../firebase/firebase_api.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  XFile? imageFile;
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();
  final ScrollController scrollController = ScrollController();
  String? chatId, image, name, role, token, phone, code;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allMessages = [];
  List<DateTimeChip> localMessage = [];
  String? userId;
BookingModel? booking;
  String activeStatus = "Offline", bookingId = "";
  QuerySnapshot<Map<String, dynamic>>? agoraData;
  StreamSubscription? messageSub;

  //on page init data fetch
  onReady(context) async {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    log("data :$data");
    if (data != "") {
      userId = data['userId'].toString();
      name = data['name'];
      image = data['image'];
      role = data['role'];
      token = data['token'];
      phone = data['phone'];
      code = data['code'];
      if (data['bookingId'] != null) {
        bookingId = data['bookingId'];
      }
      if (data['chatId'] != null) {
        print("chatIdchatIdsdf:${data['chatId']}");
        chatId = data['chatId'];
      } else {
        chatId = null;
      }
      await Future.wait([getBookingDetailBy(context),getChatData(context) ]);

      getActiveStatus();
    }


    await FirebaseFirestore.instance
        .collection(collectionName.agora)
        .get()
        .then(
      (value) {
        agoraData = value;
      },
    );

    notifyListeners();
  }

  //booking detail by id
  Future getBookingDetailBy(context) async {
    try {
      await apiServices
          .getApi("${api.booking}/$bookingId", [], isToken: true, isData: true)
          .then((value) {
        debugPrint("BOOKING DATA : ${value.data}");
        hideLoading(context);
        if (value.isSuccess!) {
          booking = BookingModel.fromJson(value.data);
          notifyListeners();



        }
        int index = booking!.servicemen!.indexWhere((element) => element.id.toString() == userId.toString());
        if(index >= 0){
          phone = booking!.servicemen![index].phone.toString();
          token = booking!.servicemen![index].fcmToken;
          code = booking!.servicemen![index].code;
        }
        notifyListeners();
      });
      log("STATYS L $booking");
    } catch (e) {
      hideLoading(context);
      notifyListeners();
    }
  }

  //user active status
  getActiveStatus() async {
    await FirebaseFirestore.instance
        .collection(collectionName.users)
        .doc(userId.toString())
        .get()
        .then((value) {
      if (value.exists) {
        activeStatus = value.data()!['status'];
      }
    });
    notifyListeners();
  }

  //get chat data
  Future getChatData(context) async {
    try {
      log("bookingId:$bookingId");
      if (bookingId != "") {

        chatId = bookingId;
      }

      if (bookingId != "") {
        log("userModel!.id :${userModel!.id}");
        log("userModel!.id :$chatId");
        messageSub = FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userModel!.id.toString())
            .collection(collectionName.chatWith)
            .doc(userId.toString())
            .collection(collectionName.booking)
            .doc(chatId.toString())
            .collection(collectionName.chat)
            .snapshots()
            .listen((event) async {
          allMessages = event.docs;
          notifyListeners();

          FirebaseApi().getLocalMessage(context);
          log("allMessages :${event.docs.length}");
          notifyListeners();
        });
      } else if (chatId != "") {
        messageSub = FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userModel!.id.toString())
            .collection(collectionName.messages)
            .doc(chatId.toString())
            .collection(collectionName.chat)
            .snapshots()
            .listen((event) async {
          allMessages = event.docs;
          notifyListeners();

          FirebaseApi().getLocalMessage(context);

          notifyListeners();
        });
      } else {
        FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userModel!.id.toString())
            .collection(collectionName.chats)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            for (var d in value.docs) {
              log("dkjgh :${(d.data()['senderId'].toString() == userModel!.id.toString() && d.data()['receiverId'].toString() == userId) || (d.data()['receiverId'].toString() == userModel!.id.toString() && d.data()['senderId'].toString() == userId)}");

              if ((d.data()['senderId'].toString() ==
                          userModel!.id.toString() &&
                      d.data()['receiverId'].toString() == userId) ||
                  (d.data()['receiverId'].toString() ==
                          userModel!.id.toString() &&
                      d.data()['senderId'].toString() == userId)) {
                log("dkjgh :df${(d.data())}");
                chatId = d.data()['chatId'];
              }
            }
            log("NEW CHAT :$chatId");
            if (chatId != "") {
              messageSub = FirebaseFirestore.instance
                  .collection(collectionName.users)
                  .doc(userModel!.id.toString())
                  .collection(collectionName.messages)
                  .doc(chatId.toString())
                  .collection(collectionName.chat)
                  .snapshots()
                  .listen((event) async {
                allMessages = event.docs;
                notifyListeners();

                FirebaseApi().getLocalMessage(context);

                notifyListeners();
              });
            }
            notifyListeners();
          } else {
            chatId = "0";
            messageSub = null;
            allMessages = [];
            localMessage = [];
          }
        });
      }

      notifyListeners();
    } catch (e) {
      log("EEE: getChatDat :$e");
    }
  }

  //seen all message
  seenMessage(context) async {
    await FirebaseFirestore.instance
        .collection(collectionName.users)
        .doc(userModel!.id.toString())
        .collection(collectionName.messages)
        .doc(chatId ?? bookingId)
        .collection(collectionName.chat)
        .where("receiverId", isEqualTo: userModel!.id.toString())
        .get()
        .then((value) {
      value.docs.asMap().entries.forEach((element) async {
        await FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userModel!.id.toString())
            .collection(collectionName.messages)
            .doc(chatId ?? bookingId)
            .collection(collectionName.chat)
            .doc(element.value.id)
            .update({"isSeen": true});
      });
    });

    await FirebaseFirestore.instance
        .collection(collectionName.users)
        .doc(userModel!.id.toString())
        .collection(collectionName.chats)
        .where("chatId", isEqualTo: chatId ?? bookingId)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        if (value.docs[0].data()['receiverId'] == userModel!.id.toString()) {
          await FirebaseFirestore.instance
              .collection(collectionName.users)
              .doc(userModel!.id.toString())
              .collection(collectionName.chats)
              .doc(value.docs[0].id)
              .update({"isSeen": true});
        }
      }
    });

    await FirebaseFirestore.instance
        .collection(collectionName.users)
        .doc(userId.toString())
        .collection(collectionName.messages)
        .doc(chatId ?? bookingId)
        .collection(collectionName.chat)
        .where("receiverId", isEqualTo: userModel!.id.toString())
        .get()
        .then((value) {
      value.docs.asMap().entries.forEach((element) async {
        await FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userId.toString())
            .collection(collectionName.messages)
            .doc(chatId ?? bookingId)
            .collection(collectionName.chat)
            .doc(element.value.id)
            .update({"isSeen": true});
      });
    });
    await FirebaseFirestore.instance
        .collection(collectionName.users)
        .doc(userId.toString())
        .collection(collectionName.chats)
        .where("chatId", isEqualTo: chatId ?? bookingId)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userId.toString())
            .collection(collectionName.chats)
            .doc(value.docs[0].id)
            .update({"isSeen": true});
      }
    });
    notifyListeners();
  }

// GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    imageFile = (await picker.pickImage(source: source, imageQuality: 70));
    notifyListeners();
    if (imageFile != null) {
      uploadFile(context);
      route.pop(context);
    }
  }

  onBack(context, isBack) {
    chatId = "0";
    messageSub = null;
    allMessages = [];
    localMessage = [];
    bookingId = "";
    chatId = "";
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }

// UPLOAD SELECTED IMAGE TO FIREBASE
  Future uploadFile(context) async {
    showLoading(context);
    notifyListeners();
    FocusScope.of(context).requestFocus(FocusNode());
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    var file = File(imageFile!.path);
    UploadTask uploadTask = reference.putFile(file);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((downloadUrl) {
        String imageUrl = downloadUrl;
        imageFile = null;

        notifyListeners();
        setMessage(imageUrl, MessageType.image, context);
      }, onError: (err) {
        hideLoading(context);
        notifyListeners();
      });
    });
  }

  showLayout(context, cartCtrl) async {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.r12))),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language(context, appFonts.selectOne),
                          style: appCss.dmDenseBold18
                              .textColor(appColor(context).appTheme.darkText)),
                      const Icon(CupertinoIcons.multiply)
                          .inkWell(onTap: () => route.pop(context))
                    ]),
                const VSpace(Sizes.s20),
                ...appArray.selectList
                    .asMap()
                    .entries
                    .map((e) => SelectOptionLayout(
                        data: e.value,
                        index: e.key,
                        list: appArray.selectList,
                        onTap: () {
                          log("dsf :${e.key}");
                          if (e.key == 0) {
                            getImage(context, ImageSource.gallery);
                          } else {
                            getImage(context, ImageSource.camera);
                          }
                        }))
              ]));
        });
  }

  //chat list time layout
  Widget timeLayout(context) {
    return Column(
        children: localMessage.reversed.toList().asMap().entries.map((a) {
      List<MessageModel> newMessageList = a.value.message!.toList();

      return Column(children: [
        Text(
                a.value.time!.contains("-other")
                    ? a.value.time!.split("-other")[0]
                    : a.value.time!,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText))
            .marginSymmetric(vertical: Insets.i5),
        ...newMessageList.reversed.toList().asMap().entries.map((e) {
          return buildItem(
              e.key,
              e.value,
              e.value.docId,
              a.value.time!.contains("-other")
                  ? a.value.time!.split("-other")[0]
                  : a.value.time!);
        })
      ]);
    }).toList());
  }

// BUILD ITEM MESSAGE BOX FOR RECEIVER AND SENDER BOX DESIGN
  Widget buildItem(int index, MessageModel document, documentId, title) {
    if (document.senderId.toString() == userModel!.id.toString()) {
      return ChatLayout(document: document, isSentByMe: true);
    } else if (document.senderId != userModel!.id.toString()) {
      // RECEIVER MESSAGE
      return ChatLayout(document: document, isSentByMe: false);
    } else {
      return Container();
    }
  }

  //call tap
  onTapPhone(context) {
    launchCall(context, phone);
    notifyListeners();
  }

  // SEND MESSAGE CLICK
  void setMessage(String content, MessageType type, context) async {
    // isLoading = true;
    log("content :$role $chatId");
    notifyListeners();
    try {
      if (content != '') {
        controller.text = "";
        log("hdhfjhd");
        final now = DateTime.now();
        String? newChatId = chatId ?? now.microsecondsSinceEpoch.toString();
        chatId = newChatId;
        log("chatId :$chatId");
        notifyListeners();
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        MessageModel messageModel = MessageModel(
          chatId: chatId,
          content: content,
          docId: time,
          messageType: "sender",
          receiverId: userId!.toString(),
          senderId: userModel!.id!.toString(),
          timestamp: time,
          type: type.name,
          receiverImage: image,
          receiverName: name,
          senderImage: userModel!.media != null && userModel!.media!.isNotEmpty
              ? userModel!.media![0].originalUrl!
              : null,
          senderName: userModel!.name,
          role: userModel!.role!.name,
        );
        bool isEmpty =
            localMessage.where((element) => element.time == "Today").isEmpty;
        if (isEmpty) {
          List<MessageModel>? message = [];
          if (message.isNotEmpty) {
            message.add(messageModel);
            message[0].docId = time;
          } else {
            message = [messageModel];
            message[0].docId = time;
          }
          DateTimeChip dateTimeChip =
              DateTimeChip(time: getDate(time), message: message);
          localMessage.add(dateTimeChip);
        } else {
          int index =
              localMessage.indexWhere((element) => element.time == "Today");
          localMessage[index].message =
              localMessage[index].message!.reversed.toList();
          if (!localMessage[index].message!.contains(messageModel)) {
            localMessage[index].message!.add(messageModel);
          }
          localMessage[index].message =
              localMessage[index].message!.reversed.toList();
        }
        hideLoading(context);
        notifyListeners();
        if (role == "user") {
          await FirebaseApi()
              .saveMessageByBooking(
                  role: role,
                  receiverName: name,
                  type: type,
                  dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
                  encrypted: content,
                  isSeen: false,
                  newChatId: chatId,
                  collectionId: userId.toString(),
                  pId: userId.toString(),
                  bookingId: chatId,
                  receiverImage: image,
                  senderId: userModel!.id)
              .then((value) async {
            await FirebaseApi()
                .saveMessageByBooking(
                    role: role,
                    receiverName: name,
                    type: type,
                    collectionId: userModel!.id.toString(),
                    bookingId: chatId,
                    dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
                    encrypted: content,
                    isSeen: false,
                    newChatId: chatId,
                    pId: userId.toString(),
                    receiverImage: image,
                    senderId: userId.toString())
                .then((snap) async {
              await FirebaseApi().saveMessageInUserCollectionByBooking(
                  senderId: userModel!.id,
                  rToken: token,
                  sToken: userModel!.fcmToken,
                  receiverImage: image,
                  newChatId: chatId,
                  type: type,
                  receiverName: name,
                  bookingId: chatId,
                  content: content,
                  receiverId: userId.toString(),
                  id: userModel!.id,
                  role: role);
              await FirebaseApi().saveMessageInUserCollectionByBooking(
                  senderId: userModel!.id,
                  receiverImage: image,
                  newChatId: chatId,
                  rToken: token,
                  sToken: userModel!.fcmToken,
                  type: type,
                  bookingId: chatId,
                  receiverName: name,
                  content: content,
                  receiverId: userId.toString(),
                  id: userId.toString(),
                  role: role);
            });
          }).then((value) async {
            controller.text = "";
            notifyListeners();
            getChatData(context);

            if (token != "" && token != null) {
              FirebaseApi().sendNotification(
                  title: "${userModel!.name} send you message",
                  msg: content,
                  chatId: chatId,
                  token: token,
                  pId: userId.toString(),
                  image: image ?? "",
                  name: userModel!.name,
                  phone: phone,
                  code: code,
                  bookingId: chatId);
            }
          });
        } else {
          await FirebaseApi()
              .saveMessage(
                  role: role,
                  receiverName: name,
                  type: type,
                  dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
                  encrypted: content,
                  isSeen: false,
                  newChatId: chatId,
                  pId: userId.toString(),
                  receiverImage: image,
                  senderId: userId.toString())
              .then((value) async {
            await FirebaseApi()
                .saveMessage(
                    role: role,
                    receiverName: name,
                    type: type,
                    dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
                    encrypted: content,
                    isSeen: false,
                    newChatId: chatId,
                    pId: userId.toString(),
                    receiverImage: image,
                    senderId: userModel!.id.toString())
                .then((snap) async {
              await FirebaseApi().saveMessageInUserCollection(
                  senderId: userModel!.id,
                  receiverImage: image,
                  newChatId: chatId,
                  type: type,
                  receiverName: name,
                  content: content,
                  receiverId: userId.toString(),
                  id: userModel!.id,
                  role: role,
                  rToken: token,
                  sToken: userModel!.fcmToken,
                  phone: phone,
                  code: code);
              await FirebaseApi().saveMessageInUserCollection(
                  senderId: userModel!.id,
                  receiverImage: image,
                  newChatId: chatId,
                  type: type,
                  receiverName: name,
                  content: content,
                  receiverId: userId.toString(),
                  id: userId.toString(),
                  role: role,
                  rToken: token,
                  sToken: userModel!.fcmToken,
                  phone: phone,
                  code: code);
            });
          }).then((value) async {
            getChatData(context);
            //FirebaseApi().getLocalMessage(context);
            log("token :$token");
            if (token != "" && token != null) {
              FirebaseApi().sendNotification(
                  title: "${userModel!.name} send you message",
                  msg: content,
                  chatId: chatId,
                  token: token,
                  pId: userId.toString(),
                  image: image ?? "",
                  name: userModel!.name,
                  phone: phone,
                  code: code);
            }
            //await saveNotificationApi(context, content, userId);
          });
        }
      }
    } catch (e) {
      log("Send :$e");
    }
  }

  //on clear chat
  onClearChat(context, sync, chatCtrl) {
    showLoading(context);
    notifyListeners();
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.clearChat,
        appFonts.clearChat, appFonts.areYouClearChat, () async {
      route.pop(context);
      await FirebaseApi().clearChat(context);
      value.onResetPass(context, language(context, appFonts.hurrayChatDelete),
          language(context, appFonts.okay), () => Navigator.pop(context));
    });
    hideLoading(context);
    value.notifyListeners();
  }
}
