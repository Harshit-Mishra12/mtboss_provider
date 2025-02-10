import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/config.dart';

class ChatHistoryProvider with ChangeNotifier {
  List chatHistory = [];
  AnimationController? animationController;
  List<NotificationModel> notificationList = [];

//on page init data fetch
  onReady(context) async {
if(userModel != null) {
  await FirebaseFirestore.instance
      .collection(collectionName.users)
      .doc(userModel!.id.toString())
      .collection(collectionName.chats).orderBy("updateStamp", descending: true)
      .get()
      .then((value) {
    chatHistory = [];
    if (value.docs.isNotEmpty) {
      chatHistory = value.docs;
    }

    notifyListeners();
  });
}
    log("chatHistory ;${chatHistory.length}");
  }

  //clear chat
  onClearChat(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.clearChat,
        appFonts.clearChat, appFonts.areYouClearChat, () async {
      showLoading(context);
      notifyListeners();
      try {
        await FirebaseFirestore.instance
            .collection(collectionName.users)
            .doc(userModel!.id.toString())
            .collection(collectionName.chats)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            FirebaseFirestore.instance
                .collection(collectionName.users)
                .doc(userModel!.id.toString())
                .collection(collectionName.messages)
                .doc( value.docs[0].data()['chatId'])
                .collection(collectionName.chat)
                .get()
                .then((v) {
              for (var d in v.docs) {
                FirebaseFirestore.instance
                    .collection(collectionName.users)
                    .doc(userModel!.id.toString())
                    .collection(collectionName.messages)
                    .doc(value.docs[0].data()['chatId'])
                    .collection(collectionName.chat)
                    .doc(d.id)
                    .delete();
              }
            }).then((a) {
              FirebaseFirestore.instance
                  .collection(collectionName.users)
                  .doc(userModel!.id.toString())
                  .collection(collectionName.chats)
                  .doc(value.docs[0].id)
                  .delete();
            }).then((value) {
              chatHistory = [];
              hideLoading(context);
            });
          }
          hideLoading(context);
          notifyListeners();
        });
      } catch (e) {
        hideLoading(context);
        notifyListeners();
      }
      
      onReady(context);
      route.pop(context);
      notifyListeners();
      value.onResetPass(context, language(context, appFonts.hurrayChatDelete),
          language(context, appFonts.okay), () => route.pop(context));
    });
    value.notifyListeners();
  }

  //popup menu option selection
  onTapOption(index, context, sync) {
    if (index == 1) {
      onClearChat(context, sync);
      notifyListeners();
    } else {
      onReady(context);
      scaffoldMessage(context, "${language(context, appFonts.refresh)}...");
    }
  }

//in back animation dispose
  onBack() {
    if (animationController != null) {
      if (!animationController!.isDismissed) {
        animationController!.dispose();
      }
    }
    notifyListeners();
  }

  //click on particular chat redirect to chat detail page
  onChatClick(context, data) {
    log("DDD :${data.data()}");
    route.pushNamed(context, routeName.chat, arg: {
      "image": data['receiverImage'],
      "name": data['receiverName'],
      "role": data['role'],
      if(data.data().containsKey('bookingId'))
        "bookingId": data['bookingId'],
      "chatId": data['chatId'],
      "userId": data['senderId'].toString() == userModel!.id.toString() ?  data['receiverId']:data['senderId'],
      "token":  data['senderId'].toString() == userModel!.id.toString() ?  data["receiverToken"]  :data['senderToken'],

    }).then((e) => onReady(context));
  }
}
