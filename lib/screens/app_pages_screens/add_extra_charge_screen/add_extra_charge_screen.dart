
import '../../../config.dart';

class AddExtraChargeScreen extends StatelessWidget {
  const AddExtraChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddExtraChargesProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(Durations.short3).then((_) => value.onInit(context)),
        child: Scaffold(
            appBar: ActionAppBar(title: appFonts.addExtraCharges),
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(clipBehavior: Clip.none, children: [
                  const FieldsBackground(),
                  Form(
                    key: value.formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContainerWithTextLayout(
                              title: language(context, appFonts.chargesTitle)),
                          const VSpace(Sizes.s8),
                          TextFieldCommon(
                            focusNode: value.chargeTitleFocus,
                                  hintText:
                                      language(context, appFonts.enterServiceTitle),
                                  validator: (val)=> validation.commonValidation(context, val),
                                  controller: value.chargeTitleCtrl,
                                  prefixIcon: eSvgAssets.description)
                              .paddingSymmetric(horizontal: Insets.i20),
                          const VSpace(Sizes.s15),
                          ContainerWithTextLayout(
                              title: language(context, appFonts.perServiceAmount)),
                          const VSpace(Sizes.s8),
                          TextFieldCommon(
                            validator: (val)=> validation.commonValidation(context, val),
                            keyboardType: TextInputType.number,
                            focusNode: value.perServiceAmountFocus,
                                  hintText: language(context, appFonts.addAmount),
                                  controller: value.perServiceAmountCtrl,
                                  prefixIcon: eSvgAssets.dollar)
                              .paddingSymmetric(horizontal: Insets.i20),
                          const VSpace(Sizes.s15),
                          ContainerWithTextLayout(
                              title: language(context, appFonts.noOfServiceDone)),
                          const VSpace(Sizes.s8),
                          const ServiceDoneLayout(),
                          const VSpace(Sizes.s40),
                          ButtonCommon(title: appFonts.addCharges,onTap: ()=> value.onAddCharge(context)).paddingSymmetric(horizontal: Insets.i20)
                        ]).paddingSymmetric(vertical: Insets.i20),
                  )
                ])
              ]).paddingSymmetric(horizontal: Insets.i20),
            )),
      );
    });
  }
}
