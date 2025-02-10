import 'package:fixit_provider/screens/app_pages_screens/add_new_location/layouts/county_drop_down.dart';
import 'package:fixit_provider/screens/app_pages_screens/add_new_location/layouts/state_drop_down.dart';

import '../../../../config.dart';

class LocationTextFieldLayout extends StatelessWidget {
  const LocationTextFieldLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewLocationProvider>(builder: (context2, value, child) {
      return Consumer<LocationProvider>(
          builder: (context2, locationCtrl, child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.dmSensMediumDark14(context, text: appFonts.street),
          const VSpace(Sizes.s8),
          TextFieldCommon(
              focusNode: value.streetFocus,
              validator: (add) => validation.addressValidation(context, add),
              controller: value.streetCtrl,
              hintText: appFonts.street,
              prefixIcon: eSvgAssets.address),
          const VSpace(Sizes.s15),
          textCommon.dmSensMediumDark14(context, text: appFonts.areaLocality),
          const VSpace(Sizes.s8),
          TextFieldCommon(
              focusNode: value.addressFocus,
              validator: (add) => validation.dynamicTextValidation(context,add, appFonts.pleaseEnterArea),
              controller: value.addressCtrl,
              hintText: appFonts.areaLocality,
              prefixIcon: eSvgAssets.address),
          const VSpace(Sizes.s15),
          RowTextBoxLayoutWithoutContainer(
              focusNode1: value.latitudeFocus,
              focusNode2: value.longitudeFocus,
              icon1: eSvgAssets.locationOut,
              icon2: eSvgAssets.locationOut,
              text1: appFonts.latitude,
              text2: appFonts.longitude,
              textEditingController1: value.latitudeCtrl,
              textEditingController2: value.longitudeCtrl,
              validator1: (val) => validation.dynamicTextValidation(
                  context, val, appFonts.pleaseEnterLatitude),
              validator2: (val) => validation.dynamicTextValidation(
                  context, val, appFonts.pleaseEnterLongitude)),

          const VSpace(Sizes.s15),
          textCommon.dmSensMediumDark14(context, text: appFonts.country),
          const VSpace(Sizes.s8),

         /* StateCountryDropdown(
              items: countryStateList,
              selectedItem: value.country,
              validator: (val) => validation.countryStateValidation(context, val, appFonts.pleaseSelectCountry),
            hint: appFonts.country,
              onChanged: (val) => value.onChangeCountryCompany(val))*/
            CountryDropDown(),
          const VSpace(Sizes.s15),
          textCommon.dmSensMediumDark14(context, text: appFonts.state),

          const VSpace(Sizes.s8),
          StateDropDown(),
          /*StateCountryDropdown(
              icon: eSvgAssets.state,
              items: stateList,
              validator: (val) => validation.countryStateValidation(context, val, appFonts.pleaseSelectState),
              selectedItem: value.state,
              onChanged: (val) => value.onChangeStateCompany(val),hint: appFonts.state)*/
          const VSpace(Sizes.s15),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  textCommon.dmSensMediumDark14(context, text: appFonts.city),
                  const VSpace(Sizes.s8),
                  TextFieldCommon(
                      focusNode: value.cityFocus,
                      validator: (city) =>
                          validation.cityValidation(context, city),
                      controller: value.cityCtrl,
                      hintText: appFonts.city,
                      prefixIcon: eSvgAssets.locationOut)
                ])),
            const HSpace(Sizes.s18),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  textCommon.dmSensMediumDark14(context,
                      text: appFonts.zipCode),
                  const VSpace(Sizes.s8),
                  TextFieldCommon(
                      keyboardType: TextInputType.number,
                      focusNode: value.zipFocus,
                      validator: (zip) =>
                          validation.cityValidation(context, zip),
                      controller: value.zipCtrl,
                      hintText: appFonts.zipCode,
                      prefixIcon: eSvgAssets.zipcode)
                ]))
          ]),
        ]);
      });
    });
  }
}
