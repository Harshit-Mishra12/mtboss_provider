import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/widgets/country_picker_custom/country_picker_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdVerificationProvider extends ChangeNotifier {
  XFile? imageFile;
  GlobalKey<FormState> idKey = GlobalKey<FormState>();
  ProviderDocumentModel? providerDocumentModel;
  TextEditingController numberText = TextEditingController();
  TextEditingController noteText = TextEditingController();

  final FocusNode noteFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();

  // GET IMAGE FROM GALLERY
  Future getImage(context, source, DocumentModel doc) async {

    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source,imageQuality: 70))!;

    providerDocumentModel = ProviderDocumentModel(
        document: doc,
        documentId: doc.id.toString(),
        isVerified: false,
        status: "pending",

        media: [Media(originalUrl: imageFile!.path.toString())]);

    providerDocumentList.add(providerDocumentModel!);

    notUpdateDocumentList.removeWhere((element) => element.id == doc.id);
    notifyListeners();


    getIdentityNumber(context, doc);
    //uploadDocumentApi(context);
  }


  //image fetch as par image source
  onImagePick(context, DocumentModel doc) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery, doc);
      } else {
        getImage(context, ImageSource.camera, doc);
      }
      notifyListeners();
    });
  }


  //add identity number with popup
  getIdentityNumber(context,DocumentModel doc) {
    showDialog(
        context: context,
        builder: (context1) => AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: Insets.i20),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:const SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius.all(SmoothRadius(cornerRadius: AppRadius.r10, cornerSmoothing: 1))),
            backgroundColor: appColor(context).appTheme.whiteBg,
            content: Stack(alignment: Alignment.topRight, children: [
              Column(
                  mainAxisSize: MainAxisSize.min, children: [

                Form(
                  key: idKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language(context, appFonts.reason), style: appCss.dmDenseMedium15
                            .textColor(appColor(context).appTheme.darkText)),
                        const VSpace(Sizes.s8),
                        TextFieldCommon(
                            focusNode: numberFocus,
                            validator: (value) => Validation().commonValidation(context, appFonts.enterIdentityNo),
                            fillColor: appColor(context).appTheme.fieldCardBg,
                            controller: numberText,
                            hintText: appFonts.identityNo,
                            prefixIcon: eSvgAssets.identity
                        ),
                        const VSpace(Sizes.s20),
                        Text(language(context, appFonts.reason), style: appCss.dmDenseMedium15
                            .textColor(appColor(context).appTheme.darkText)),
                        const VSpace(Sizes.s8),
                        TextFieldCommon(
                            focusNode: noteFocus,
validator: (value) => Validation().commonValidation(context, appFonts.enterMessage),
                            fillColor: appColor(context).appTheme.fieldCardBg,
                            controller: noteText,
                            hintText: appFonts.writeANote,
                            maxLines: 3,
                            minLines: 3,
                            isNumber: true
                        )
                      ]
                  ),
                ),
                // Sub text

                const VSpace(Sizes.s20),
                ButtonCommon(

                    onTap: (){
                      if(idKey.currentState!.validate()){
                        providerDocumentModel!.identityNo = numberText.text;
                        providerDocumentModel!.notes = noteText.text;
                        notifyListeners();
                        route.pop(context);
                        uploadDocumentApi(context);
                      }
                    }, title: language(context, appFonts.uploadImageProof))
              ]).padding(
                  horizontal: Insets.i20, top: Insets.i60, bottom: Insets.i20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Title
                Expanded(
                  child: Text(language(context, appFonts.idVerification),
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmDenseMedium18
                          .textColor(appColor(context).appTheme.darkText)),
                ),
                Icon(CupertinoIcons.multiply,
                    size: Sizes.s20, color: appColor(context).appTheme.darkText)
                    .inkWell(onTap: () => route.pop(context))
              ]).paddingAll(Insets.i20)
            ]))).then((e){
              if(numberText.text.isEmpty){
                providerDocumentList.removeWhere((element) => element.documentId.toString() == doc.id.toString(),);
                final userApi = Provider.of<UserDataApiProvider>(context,listen: false);
                userApi.getDocumentDetails();
                notifyListeners();
              }
    });
  }

//upload document api
  uploadDocumentApi(context) async {

    try {
      showLoading(context);
      notifyListeners();
      var body = {
        'document_id': providerDocumentModel!.documentId,
        'identity_no':numberText.text,
        'notes':noteText.text,

      };
      dio.FormData formData = dio.FormData.fromMap(body);

      if (imageFile != null) {
        formData.files.addAll([
          MapEntry(
              "images[]",
              await MultipartFile.fromFile(imageFile!.path,
                  filename: imageFile!.path.split('/').last)),
        ]);
      }

      await apiServices
          .postApi(api.uploadProviderDocument, formData, isToken: true)
          .then((value) async {
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getDocumentDetails();
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.green);

          notifyListeners();


          imageFile = null;
          appArray.serviceImageList = [];
        } else {
          hideLoading(context);
          notifyListeners();
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          await userApi.getDocumentDetails();
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE addServiceman : $e");
    }
  }
}
