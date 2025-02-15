import 'dart:developer';

import '../../../config.dart';

class AddNewServiceScreen extends StatefulWidget {
  const AddNewServiceScreen({super.key});

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  var storedLocale;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);

      // Fetch stored locale
      storedLocale =
          languageProvider.sharedPreferences.getString("selectedLocaleService");

      log("Stored Locale: $storedLocale");

      // Update the selected language if it has changed
      if (storedLocale != null &&
          storedLocale != languageProvider.selectedLocaleService) {
        int index = languageProvider.languageList
            .indexWhere((e) => e.locale == storedLocale);

        if (index != -1) {
          languageProvider.setSelectedIndex(index, storedLocale);
        }
      }

      final allUserApi =
          Provider.of<UserDataApiProvider>(context, listen: false);
      allUserApi.commonCallApi(context);

      final all = Provider.of<CommonApiProvider>(context, listen: false);
      all.commonApi(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, AddNewServiceProvider>(
        builder: (context1, languageCtrl, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(const Duration(milliseconds: 150), () {
          value.onReady(context);
        }),
        child: PopScope(
          canPop: true,
          onPopInvoked: (bool? didPop) => value.onBack(false),
          child: LoadingComponent(
            child: Scaffold(
                appBar: AppBarCommon(
                    title: value.isEdit
                        ? translations!.editService
                        : translations!.addNewService,
                    onTap: () => value.onBackButton(context)),
                body: SingleChildScrollView(
                    child: Column(children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...languageCtrl.languageList.asMap().entries.map((e) {
                            int index = e.key;
                            bool isSelected =
                                languageCtrl.addSelectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                languageCtrl.setSelectedIndex(
                                    index, e.value.locale.toString());
                                log("Selected Language: ${languageCtrl.selectedLocaleService}");
                                // Save the selected language persistently
                                languageCtrl.sharedPreferences.setString(
                                    "selectedLocaleService",
                                    e.value.locale.toString());

                                // Notify listeners to update the UI
                                languageCtrl.notifyListeners();
                              },
                              child: Row(children: [
                                Container(
                                    height: Sizes.s16,
                                    width: Sizes.s24,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                e.value.flag.toString())))),
                                const HSpace(Sizes.s6),
                                Text(e.value.name.toString(),
                                    style: appCss.dmDenseRegular14.textColor(
                                        isSelected
                                            ? appColor(context)
                                                .appTheme
                                                .whiteColor // Change color when selected
                                            : appColor(context)
                                                .appTheme
                                                .darkText))
                              ])
                                  .padding(
                                      vertical: Sizes.s11,
                                      horizontal: Sizes.s15)
                                  .decorated(
                                    color: isSelected
                                        ? appColor(context)
                                            .appTheme
                                            .primary // Highlight border
                                        : appColor(context).appTheme.whiteBg,
                                    border: Border.all(
                                      color: appColor(context).appTheme.stroke,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(Sizes.s8),
                                  )
                                  .padding(
                                      horizontal: Sizes.s5, bottom: Sizes.s15),
                            );
                          })
                        ],
                      )),
                  Stack(children: [
                    const FieldsBackground(),
                    Form(
                      key: value.addServiceFormKey,
                      child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormServiceImageLayout(),
                            FormCategoryLayout(),
                            FormPriceLayout()
                          ]).paddingSymmetric(vertical: Insets.i20),
                    )
                  ]),
                  ButtonCommon(
                          title: value.services != null
                              ? translations!.update
                              : translations!.addService,
                          onTap: () => value.services != null
                              ? value.editData(context)
                              : value.addData(context))
                      .paddingOnly(top: Insets.i40, bottom: Insets.i30)
                ]).paddingSymmetric(horizontal: Insets.i20))),
          ),
        ),
      );
    });
  }
}
