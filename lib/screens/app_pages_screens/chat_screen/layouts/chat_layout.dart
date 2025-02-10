import 'package:fixit_provider/widgets/common_photo_view.dart';
import 'package:intl/intl.dart';

import '../../../../config.dart';

class ChatLayout extends StatelessWidget {
  final MessageModel? document;
  final AlignmentGeometry? alignment;
  final bool? isSentByMe;

  const ChatLayout({super.key, this.document, this.alignment, this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isSentByMe == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.i15, vertical: Insets.i15),
            decoration: ShapeDecoration(
                color: isSentByMe == true
                    ? appColor(context).appTheme.primary
                    : appColor(context).appTheme.fieldCardBg,
                shape: SmoothRectangleBorder(
                    borderRadius: rtl(context)
                        ? SmoothBorderRadius.only(
                        topRight: const SmoothRadius(
                            cornerRadius: 20, cornerSmoothing: 1),
                        topLeft: const SmoothRadius(
                            cornerRadius: 20, cornerSmoothing: 1),
                        bottomRight: SmoothRadius(
                            cornerRadius:
                            isSentByMe == true ? Insets.i20 : 0,
                            cornerSmoothing: 1),
                        bottomLeft: SmoothRadius(
                            cornerRadius:
                            isSentByMe == true ? 0 : Insets.i20,
                            cornerSmoothing: 1))
                        : SmoothBorderRadius.only(
                        topRight: const SmoothRadius(
                            cornerRadius: 20, cornerSmoothing: 1),
                        topLeft: const SmoothRadius(
                            cornerRadius: 20, cornerSmoothing: 1),
                        bottomRight: SmoothRadius(
                            cornerRadius:
                            isSentByMe == true ? 0 : Insets.i20,
                            cornerSmoothing: 1),
                        bottomLeft: SmoothRadius(
                            cornerRadius:
                            isSentByMe == true ? Insets.i20 : 0,
                            cornerSmoothing: 1)))),
            child:
            Column(crossAxisAlignment: isSentByMe == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MessageType.image.name == document!.type
                      ? CachedNetworkImage(
                      imageUrl: document!.content!,
                      imageBuilder: (context, imageProvider) =>
                          CachedNetworkImage(
                              imageUrl: document!.content!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      height: Sizes.s200,
                                      width: Sizes.s200,
                                      decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                              borderRadius: SmoothBorderRadius(
                                                  cornerRadius: 20,
                                                  cornerSmoothing: 1)),
                                          image: DecorationImage(
                                              image: imageProvider, fit: BoxFit
                                              .cover))
                                  ).inkWell(onTap: ()=> route.push(context, CommonPhotoView(image: document!.content)))

                          ),
                      placeholder: (context, url) =>
                          Container(
                              height: Sizes.s200,
                              width: Sizes.s200,
                              decoration: ShapeDecoration(
                                  shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                          cornerRadius: 20,
                                          cornerSmoothing: 1)),
                                  image: DecorationImage(
                                      image: AssetImage(eImageAssets.noImageFound2), fit: BoxFit
                                      .cover))
                          ),
                      errorWidget: (context, url, error) =>
                          Container(
                              height: Sizes.s200,
                              width: Sizes.s200,
                              decoration: ShapeDecoration(
                                  shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                          cornerRadius: 20,
                                          cornerSmoothing: 1)),
                                  image: DecorationImage(
                                      image: AssetImage(eImageAssets.noImageFound2), fit: BoxFit
                                      .cover))
                          ))
                      : Text(document!.content.toString(),
                      style: appCss.dmDenseMedium14.textColor(isSentByMe == true
                          ? appColor(context).appTheme.whiteColor
                          : appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s5),
                  Row(children: [

                    Text(
                        DateFormat('hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(document!.timestamp!))),
                        style: appCss.dmDenseRegular12.textColor(
                            isSentByMe == true
                                ? appColor(context).appTheme.whiteColor
                                : appColor(context).appTheme.lightText))
                  ])
                ])).paddingSymmetric(
            horizontal: Insets.i20, vertical: Insets.i10),
      ],
    );
  }
}
