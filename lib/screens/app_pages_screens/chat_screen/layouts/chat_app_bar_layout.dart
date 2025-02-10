
import '../../../../config.dart';

class ChatAppBarLayout extends StatelessWidget {
  final PopupMenuItemSelected? onSelected;


  const  ChatAppBarLayout({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context1, value, child) {
      return Container(
          height: Sizes.s108,
          decoration: ShapeDecoration(
              color: appColor(context).appTheme.fieldCardBg,
              shape: SmoothRectangleBorder(
                  side: BorderSide(color: appColor(context).appTheme.stroke),
                  borderRadius: const SmoothBorderRadius.vertical(
                      bottom: SmoothRadius(
                          cornerRadius: AppRadius.r20, cornerSmoothing: 1)))),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  // Arrow
                  CommonArrow(
                      onTap: () => value.onBack(context, true),
                      arrow: rtl(context)
                          ? eSvgAssets.arrowRight
                          : eSvgAssets.arrowLeft,
                      color: appColor(context).appTheme.whiteBg),
                  const HSpace(Sizes.s15),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(value.name ?? "",
                            style: appCss.dmDenseMedium14.textColor(
                                appColor(context).appTheme.darkText)),
                        const VSpace(Sizes.s2),
                        // Status
                          Text(language(context, value.activeStatus),
                              style: appCss.dmDenseMedium12
                                  .textColor( value.activeStatus == "Online" ? appColor(context).appTheme.online:appColor(context).appTheme.red))
                      ])
                ]),


                SizedBox(
                    height: Sizes.s40,
                    width: Sizes.s40,
                    child: PopupMenuButton(
                        color: appColor(context).appTheme.whiteBg,
                        constraints: const BoxConstraints(
                            minWidth: Sizes.s87, maxWidth: Sizes.s87),
                        position: PopupMenuPosition.under,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppRadius.r8))),
                        onSelected: onSelected,
                        padding: const EdgeInsets.all(0),
                        iconSize: Sizes.s20,
                        offset: const Offset(5, 20),
                        icon: SvgPicture.asset(eSvgAssets.more,
                            height: Sizes.s20,
                            colorFilter: ColorFilter.mode(
                                appColor(context).appTheme.darkText,
                                BlendMode.srcIn)),
                        itemBuilder: (context) => [
                              ...appArray.optionList.asMap().entries.map((e) =>
                                  buildPopupMenuItem(
                                      context, appArray.optionList,
                                      position: e.key,
                                      data: e.value,
                                      index: e.key))
                            ]).decorated(
                        color: appColor(context).appTheme.whiteBg,
                        shape: BoxShape.circle))
              ]).paddingOnly(
              right: Insets.i20, left: Insets.i20, top: Insets.i35));
    });
  }
}
