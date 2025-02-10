import 'dart:developer';

import '../../../config.dart';

class AddNewServiceScreen extends StatefulWidget {
  const AddNewServiceScreen({super.key});

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen>  with WidgetsBindingObserver {
  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {

    if (state == AppLifecycleState.resumed) {

      final allUserApi = Provider.of<UserDataApiProvider>(context,listen: false);
      allUserApi.commonCallApi(context);
      final all = Provider.of<CommonApiProvider>(context,listen: false);
      all.commonApi(context);
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      final allUserApi = Provider.of<UserDataApiProvider>(context,listen: false);
      allUserApi.commonCallApi(context);
      final all = Provider.of<CommonApiProvider>(context,listen: false);
      all.commonApi(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 20), () => value.onReady(context)),
        child: PopScope(
          canPop: true,
          onPopInvoked: (bool? didPop) => value.onBack(false),
          child: LoadingComponent(
            child: Scaffold(
                appBar: AppBarCommon(
                    title: value.isEdit
                        ? appFonts.editService
                        : appFonts.addNewService,
                    onTap: () => value.onBackButton(context)),
                body: SingleChildScrollView(
                    child: Column(children: [
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
                              ? appFonts.update
                              : appFonts.addService,
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
