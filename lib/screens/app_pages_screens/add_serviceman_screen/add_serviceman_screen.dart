
import '../../../config.dart';

class AddServicemenScreen extends StatelessWidget {
  const AddServicemenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddServicemenProvider>(builder: (context1, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if(didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 100), () => value.onReady(context)),
            child: LoadingComponent(
                child: Scaffold(
                    appBar: AppBarCommon(
                      onTap: ()=>value.onBack(context, true),
                        title: value.servicemanModel != null
                            ? appFonts.editServicemen
                            : appFonts.addServicemen),
                    body: SingleChildScrollView(
                        child: Form(
                            key: value.addServiceManFormKey,
                            child: Column(children: [
                              const Column(children: [
                                AddServicemenProfileLayout(),
                                VSpace(Sizes.s35),
                               ServicemanOtherDetail()
                              ])
                                  .paddingSymmetric(vertical: Insets.i20)
                                  .boxShapeExtension(
                                      color:
                                          appColor(context).appTheme.fieldCardBg,
                                      radius: AppRadius.r12),
                              ButtonCommon(
                                  title: value.servicemanModel != null
                                      ? appFonts.update
                                      : appFonts.addServicemen,
                                  onTap: () => value.servicemanModel != null
                                      ? value.editData(context)
                                      : value.addData(context)).paddingOnly(
                                  top: Insets.i40, bottom: Insets.i10)
                            ]).paddingAll(Insets.i20)))))),
      );
    });
  }
}
