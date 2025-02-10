import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fixit_provider/config.dart';

class AddServiceProofProvider with ChangeNotifier {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  BookingModel? bookingModel;
  List proofList = [];
  ServiceProofs? serviceProofs;
  XFile? imageFile;

  //on page init data fetch
  onReady(context) {
    descriptionFocus.addListener(() {
      notifyListeners();
    });
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    bookingModel = data['bookingModel'];
    if (data['data'] != null) {
      serviceProofs = data['data'];
      titleCtrl.text = serviceProofs!.title!;
      descriptionCtrl.text = serviceProofs!.description!;

      log("SER :${serviceProofs!.id}");
    } else {
      titleCtrl.text = "";
      descriptionCtrl.text = "";
      proofList = [];
      serviceProofs = null;
    }
    notifyListeners();
  }

  //on submit api call for add proof
  onSubmit(context) {
    if (formKey.currentState!.validate()) {
      if (descriptionCtrl.text.isNotEmpty &&
          titleCtrl.text.isNotEmpty &&
          (proofList.isNotEmpty ||
              (serviceProofs!.media != null &&
                  serviceProofs!.media!.isNotEmpty))) {
        log("ADDD PROOF");
        addServiceProof(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text("Add all fields and image",
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.whiteColor)),
            backgroundColor: appColor(context).appTheme.red,
            behavior: SnackBarBehavior.floating));
      }
    }
  }

  //on image file path remove tap
  onImageRemove(index) {
    proofList.removeAt(index);
    notifyListeners();
  }

  //on image network remove tap
  removeNetworkImage(index) {
    serviceProofs!.media!.removeAt(index);
    notifyListeners();
  }

  //get image from source
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source,imageQuality: 70))!;
    notifyListeners();
  }

  //after pick image set in value
  onImagePick(context) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery)
            .then((value) => proofList.add(imageFile));

        notifyListeners();
      } else {
        getImage(context, ImageSource.camera)
            .then((value) => proofList.add(imageFile));

        notifyListeners();
      }
    });
  }

//add service proof
  addServiceProof(context) async {
    showLoading(context);
    notifyListeners();

    try {
      var body = {
        if (serviceProofs == null) "booking_id": bookingModel!.id,
        if (serviceProofs != null) "proof_id": serviceProofs!.id,
        "title": titleCtrl.text,
        "description": descriptionCtrl.text
      };
      dio.FormData formData = dio.FormData.fromMap(body);

      for (var file in proofList) {
        formData.files.addAll([
          MapEntry(
              "images_proofs[]",
              await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)),
        ]);
      }
      log("BODU :$body");
      log("BODU :$proofList");
      await apiServices
          .postApi(
              serviceProofs != null
                  ? api.updateserviceProofs
                  : api.addserviceProofs,
              formData,
              isToken: true)
          .then((value) async {
        hideLoading(context);
        notifyListeners();
        log("SHHHH ");
        if (value.isSuccess!) {
          final userApi =
              Provider.of<CompletedBookingProvider>(context, listen: false);
          await userApi.getBookingDetailById(context, bookingModel!.id);
          snackBarMessengers(context,
              message: value.message, color: appColor(context).appTheme.green);

          notifyListeners();

          route.pop(context);
          imageFile = null;

          appArray.serviceImageList = [];
          proofList = [];
          descriptionCtrl.text = "";
          titleCtrl.text = "";
        } else {
          final userApi =
              Provider.of<CompletedBookingProvider>(context, listen: false);
          await userApi.getBookingDetailById(context, bookingModel!.id);
          route.pop(context);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE addServiceProof : $e");
    }
  }

//on back clear and set value
  onBack(context, isBack) {
    proofList = [];
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }
}
