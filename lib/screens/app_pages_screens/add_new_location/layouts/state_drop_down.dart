import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../config.dart';

class StateDropDown extends StatelessWidget {
  final bool isAddLocation,isUpdate;
  const StateDropDown({super.key,this.isAddLocation =false,this.isUpdate =false});

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewLocationProvider,SignUpCompanyProvider,CompanyDetailProvider>(builder: (context2, value,signup,company, child) {
      return Consumer<LocationProvider>(
          builder: (context2, locationCtrl, child) {

        return Stack(alignment: Alignment.centerLeft, children: [
          DropdownButton2<StateModel>(
              underline: Container(),
              dropdownStyleData: DropdownStyleData(
                  maxHeight: Sizes.s400,
                  decoration:
                      BoxDecoration(color: appColor(context).appTheme.whiteBg)),
              isExpanded: true,
              isDense: true,
              iconStyleData: IconStyleData(icon:SvgPicture.asset(eSvgAssets.dropDown,

                  colorFilter: ColorFilter.mode(
                   isUpdate ?value.state == null
                       ? appColor(context).appTheme.lightText
                       : appColor(context).appTheme.darkText :   !isAddLocation
                          ? value.state == null
                          ? appColor(context).appTheme.lightText
                          : appColor(context).appTheme.darkText
                          : signup.state == null
                          ? appColor(context).appTheme.lightText
                          : appColor(context).appTheme.darkText,
                      BlendMode.srcIn))),
              //searchable IconStyle
              hint: Text(
                language(context, appFonts.selectState),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText),
              ),
              //Searchable DropDown Title Text
              items: isUpdate?company.statesList
                  .map((e) => DropdownMenuItem(
                  value: e,
                  //Searchable DropDown SubTitle Text
                  child: Text(
                    e.name!,
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                  )))
                  .toList() : !isAddLocation? value.statesList
                  .map((e) => DropdownMenuItem(
                      value: e,
                      //Searchable DropDown SubTitle Text
                      child: Text(
                        e.name!,
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.darkText),
                      )))
                  .toList(): signup.statesList
                  .map((e) => DropdownMenuItem(
                  value: e,
                  //Searchable DropDown SubTitle Text
                  child: Text(
                    e.name!,
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                  )))
                  .toList(),
              value: isUpdate ? company.state: !isAddLocation? value.state:signup.state,
              onChanged: (val) {
                StateModel? country = val;
                if(isUpdate){
                  company.onChangeStateCompany(country!.id, country);
                }else {
                  if (!isAddLocation) {
                    value.onChangeStateCompany(country!.id, country);
                  } else {
                    signup.onChangeStateCompany(country!.id, country);
                  }
                }
              },
              buttonStyleData: ButtonStyleData(
                elevation: 0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    color: appColor(context).appTheme.whiteBg,
                    border:
                        Border.all(color: appColor(context).appTheme.trans)),
                padding: EdgeInsets.only(left: rtl(context)? Insets.i20:Sizes.s30,right: rtl(context)? Sizes.s30:Sizes.s20),
                height: Sizes.s52,
              ),
              //search ButtonStyle Data
              menuItemStyleData: const MenuItemStyleData(
                height: Sizes.s40,
              ),
              dropdownSearchData: DropdownSearchData(
                  searchController: isUpdate ?company.stateCtrl : !isAddLocation ?  value.countryCtrl:signup.stateCtrl,
                  searchInnerWidgetHeight: Sizes.s60,
                  searchInnerWidget:  Container(
                      height: Sizes.s60,
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s10,vertical: Sizes.s10),
                      child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller:isUpdate ?company.stateCtrl : !isAddLocation ?  value.countryCtrl:signup.stateCtrl,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding:  EdgeInsets.symmetric(horizontal: 15),
                              hintText: language(context, appFonts.searchHere),
                              hintStyle: const TextStyle(fontSize: 12),enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))))),
                  //searchable layout container
                  searchMatchFn: (item, searchValue) {
                    return item.value!.name
                        .toString()
                        .toLowerCase()
                        .contains(searchValue);
                  }),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  if(isUpdate){
                    company.stateCtrl.clear();
                  }else{
                    if(!isAddLocation){
                      value.countryCtrl.clear();
                    }else{
                      signup.countryCtrl.clear();
                    }
                  }

                }
              }),
          SvgPicture.asset(eSvgAssets.country,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
      isUpdate?  company.state == null
          ? appColor(context).appTheme.lightText
          : appColor(context).appTheme.darkText:      !isAddLocation ?  value.state == null
                          ? appColor(context).appTheme.lightText
                          : appColor(context).appTheme.darkText: signup.state == null
                ? appColor(context).appTheme.lightText
                : appColor(context).appTheme.darkText,
                      BlendMode.srcIn))
              .paddingSymmetric(horizontal: Insets.i15)
        ]);
      });
    });
  }
}
