import '../../../config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context1, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context,false);
          if(didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 100), () => value.onReady(context)),
            child: LoadingComponent(
              child: Scaffold(
                  body: Column(children: [
                ChatAppBarLayout(onSelected: (index) {
                  if (index == 1) {
                    value.onClearChat(context, this, value);
                  } else {
                    value.onTapPhone(context);
                  }
                }),
                Expanded(
                    child: ListView(
                  reverse: true,
                  children: [
                    value.timeLayout(context).marginOnly(bottom: Insets.i18)
                  ],
                )),
                    if (value.booking != null)
                      if (value.booking!.bookingStatus!.slug !=
                          appFonts.completed)
                Row(children: [
                  // Text Field
                  Expanded(
                      child: TextFormField(
                          controller: value.controller,
                          style: appCss.dmDenseMedium14
                              .textColor(appColor(context).appTheme.darkText),
                          cursorColor: appColor(context).appTheme.darkText,
                          decoration: InputDecoration(
                              fillColor: appColor(context).appTheme.whiteBg,
                              filled: true,
                              isDense: true,
                              disabledBorder: CommonWidgetLayout().noneDecoration(),
                              focusedBorder: CommonWidgetLayout().noneDecoration(),
                              enabledBorder: CommonWidgetLayout().noneDecoration(),
                              border:CommonWidgetLayout().noneDecoration(),
                              contentPadding: const EdgeInsets.symmetric(horizontal: Insets.i15, vertical: Insets.i15),
                              prefixIcon: SvgPicture.asset(eSvgAssets.gallery, colorFilter: ColorFilter.mode(appColor(context).appTheme.lightText, BlendMode.srcIn)).paddingSymmetric(horizontal: Insets.i20).inkWell(onTap: () => value.showLayout(context, value)),
                              hintStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText),
                              hintText: language(context, "Type here..."),
                              errorMaxLines: 2))),

                  // Send button
                  SizedBox(
                          child: SvgPicture.asset(eSvgAssets.send)
                              .paddingAll(Insets.i8))
                      .decorated(
                          color: appColor(context).appTheme.primary,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppRadius.r6)))
                      .marginSymmetric(horizontal: Insets.i20)
                      .inkWell(
                          onTap: () => value.setMessage(
                                value.controller.text,
                                MessageType.text,
                                context,
                              ))
                ]).boxBorderExtension(context, isShadow: true, radius: 0)
              ])),
            )),
      );
    });
  }
}
