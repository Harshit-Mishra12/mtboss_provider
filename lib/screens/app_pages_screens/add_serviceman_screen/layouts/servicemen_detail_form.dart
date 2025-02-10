import '../../../../config.dart';

class ServicemenDetailForm extends StatelessWidget {
  const ServicemenDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddServicemenProvider>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ContainerWithTextLayout(title: appFonts.userName)
          .paddingOnly(bottom: Insets.i8),
      TextFieldCommon(
              focusNode: value.userNameFocus,
              controller: value.userName,
              validator: (name) => validation.nameValidation(context, name),
              hintText: appFonts.enterName,
              prefixIcon: eSvgAssets.user)
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: appFonts.phoneNo)
          .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      RegisterWidgetClass().phoneTextBox(
        dialCode: value.dialCode,
          context, value.number, value.providerNumberFocus,
          onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
          onFieldSubmitted: (values) => validation.fieldFocusChange(
              context, value.providerNumberFocus, value.emailFocus)),
      ContainerWithTextLayout(title: appFonts.email)
          .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      TextFieldCommon(
              focusNode: value.emailFocus,
              keyboardType: TextInputType.emailAddress,
              validator: (name) => validation.emailValidation(context, name),
              controller: value.email,
              hintText: appFonts.enterEmail,
              prefixIcon: eSvgAssets.email)
          .paddingSymmetric(horizontal: Insets.i20),
      if (value.servicemanModel == null)
        ContainerWithTextLayout(title: appFonts.identityType)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      if (value.servicemanModel == null)
        DropDownLayout(
                hintText: appFonts.selectType,
                icon: eSvgAssets.identity,
                doc: value.identityValue,
                isIcon: true,
                document: documentList,
                onChanged: (val) => value.onChangeIdentity(val))
            .paddingSymmetric(horizontal: Insets.i20),
      if (value.servicemanModel == null)
        ContainerWithTextLayout(title: appFonts.identityNo)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      if (value.servicemanModel == null)
        TextFieldCommon(

                focusNode: value.identityNumberFocus,
                controller: value.identityNumber,
                validator: (name) => validation.dynamicTextValidation(
                    context, name, appFonts.pleaseEnterNumber),
                hintText: appFonts.enterIdentityNo,
                prefixIcon: eSvgAssets.identity)
            .paddingSymmetric(horizontal: Insets.i20),
      if (value.servicemanModel == null)
        ContainerWithTextLayout(title: appFonts.identityPhoto)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      if (value.servicemanModel == null)
        appArray.servicemanDocImageList.isNotEmpty
            ? const ServicemanDocImageList()
            : UploadImageLayout(onTap: () => value.onImagePick(context, false))
    ]);
  }
}
