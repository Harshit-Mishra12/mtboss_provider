import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../config.dart';

class JobRequestListProvider extends ChangeNotifier {
  List<JobRequestModel> jobRequestList = [];
  bool isPositionedRight = false;
  bool isAnimateOver = false;
  AnimationController? controller;
  Animation<Offset>? offsetAnimation;


  onInit(context) async {
   try{
     showLoading(context);
     /*jobRequestList = appArray.jobRequestList
         .map((e) => JobRequestModel.fromJson(e))
         .toList();*/
     notifyListeners();
     hideLoading(context);
     notifyListeners();
log("JOBB :${jobRequestList.length}");
   }catch(e){
log("EEEE JobRequest: $e");
    }
  }

  onRefresh(context) async {
    showLoading(context);
    notifyListeners();
    final dash = Provider.of<UserDataApiProvider>(context,listen: false);
    dash.getJobRequest();
    hideLoading(context);
    notifyListeners();
  }


}
