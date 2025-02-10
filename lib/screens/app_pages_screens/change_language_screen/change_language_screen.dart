import '../../../config.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context1, languageCtrl, child) {
      return LoadingComponent(
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  leadingWidth: 80,
                  leading: CommonArrow(
                      arrow: languageCtrl.getLocal() == "ar"
                          ? eSvgAssets.arrowRight
                          : eSvgAssets.arrowLeft,
                      onTap: () => route.pop(context)).paddingAll(Insets.i8),
                  title: Text(
                      language(
                          context, language(context, appFonts.changeLanguage)),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText))),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RadioLayout(),
                    ButtonCommon(
                      title: appFonts.update,
                      onTap: () => languageCtrl
                          .changeLocale(languageCtrl.selectLanguage),
                    ).paddingAll(Insets.i20)
                  ])));
    });
  }
}
