import 'package:intl/intl.dart';

import '../../../../config.dart';

class ChatHistoryLayout extends StatelessWidget {
  final dynamic data;
  final List? list;
  final int? index;
  final GestureTapCallback? onTap;

  const ChatHistoryLayout(
      {super.key, this.data, this.list, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
            data['senderId'].toString() != userModel!.id.toString() ? Container(
                  height: Sizes.s45,
                  width: Sizes.s45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:data['senderImage'] != null? DecorationImage(
                          image: NetworkImage(data['senderImage']),
                          fit: BoxFit.cover): DecorationImage(
                          image: AssetImage(eImageAssets.noImageFound3),
                          fit: BoxFit.cover))): Container(
                height: Sizes.s45,
                width: Sizes.s45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:data['receiverImage'] != null? DecorationImage(
                        image: NetworkImage(data['receiverImage']),
                        fit: BoxFit.cover): DecorationImage(
                        image: AssetImage(eImageAssets.noImageFound3),
                        fit: BoxFit.cover))),
              const HSpace(Sizes.s10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text( data['senderId'].toString() != userModel!.id.toString() ? data["senderName"] ?? "":data['receiverName'],
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s2),
                Text(
                    data['messageType'] == "image"
                        ? data['senderId'] == userModel!.id
                            ? "\u{1F4F8} You send the image"
                            : "\u{1F4F8} ${data['senderName']} send you the image"
                        : data["lastMessage"],
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.lightText))
              ])
            ]),
            Text(
                DateFormat('HH:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(data["updateStamp"].toString()))),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
          ]).inkWell(onTap: onTap),
      if (index != list!.length - 1)
        const DividerCommon().paddingSymmetric(vertical: Insets.i15)
    ]);
  }
}
