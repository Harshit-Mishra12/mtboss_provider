import '../../../../config.dart';

class LanguageDropDownLayout extends StatelessWidget {
  const LanguageDropDownLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, langProvider, child) {
      return SizedBox(
          width: Sizes.s80,
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  child: DropdownButton(
                      value: langProvider.selectLanguage,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppRadius.r8)),
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.lightText),
                      icon: SvgPicture.asset(eSvgAssets.dropDown,
                          colorFilter: ColorFilter.mode(
                              appColor(context).appTheme.darkText,
                              BlendMode.srcIn)),
                      isDense: true,
                      isExpanded: true,
                      hint: langProvider.sharedPreferences
                                      .getString("selectedLocale") ==
                                  null ||
                              langProvider.currentLanguage == null
                          ? Text(langProvider.sharedPreferences
                              .getString("selectedApi")
                              .toString())
                          : Text(langProvider.selectLanguage
                              .substring(0, 2)
                              .toString()),
                      selectedItemBuilder: (context) {
                        int index = appArray.languageList.indexWhere(
                            (element) =>
                                element['title'] ==
                                langProvider.currentLanguage);
                        return LanguageList().langList(index, context);
                      },
                      items: appArray.languageList.asMap().entries.map((e) {
                        return DropdownMenuItem(
                          value: e.value[
                              'title'], // Use the 'title' field as the value
                          child: Text(e.value['title'].toString()),
                        );
                        //log("adfljghADGHSfhjadsfad ${e.value["title"].toString()}");
                        // return LanguageList().dropDown(e.value, context,
                        //     onTap: () =>
                        //         langProvider.onBoardLanguageChange(
                        //             e.value["title"].toString()));
                      }).toList(),
                      onChanged: (val) async {
                        langProvider.currentLanguage = val.toString();
                        langProvider.onBoardLanguageChange(
                            langProvider.currentLanguage!);
                      })))).paddingAll(Insets.i7).decorated(
          color: appColor(context).appTheme.whiteBg,
          borderRadius: BorderRadius.circular(AppRadius.r6),
          boxShadow: isDark(context)
              ? []
              : [
                  BoxShadow(
                      color: appColor(context).appTheme.fieldCardBg,
                      blurRadius: AppRadius.r10,
                      spreadRadius: AppRadius.r5)
                ],
          border: Border.all(color: appColor(context).appTheme.fieldCardBg));
    });
  }
}
