import 'dart:developer';

import 'package:dio/dio.dart' as dio;

import '../../config.dart';

class UserDataApiProvider extends ChangeNotifier {
  //home statistic
  homeStatisticApi() async {
    try {
      await apiServices
          .getApi(api.statisticCount, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          statisticModel = StatisticModel.fromJson(value.data);
          log("statisticModel :${value.data}");
          if (isServiceman) {
            appArray.serviceManEarningList.asMap().entries.forEach((element) {
              if (element.value['title'] == appFonts.totalEarning) {
                element.value["price"] =
                    statisticModel!.totalRevenue!.toString();
              }
              if (element.value['title'] == appFonts.totalBooking) {
                element.value["price"] =
                    statisticModel!.totalBookings.toString();
              }
              if (element.value['title'] == appFonts.totalService) {
                element.value["price"] =
                    statisticModel!.totalServices.toString();
              }

              log("HOME L${element.value["price"]}");
              notifyListeners();
            });
          } else {
            appArray.earningList.asMap().entries.forEach((element) {
              if (element.value['title'] == appFonts.totalEarning) {
                element.value["price"] =
                    statisticModel!.totalRevenue!.toString();
                log("element.value['title']::${element.value['title']}");
                log("element.value['title']::${element.value["price"]}");
              }
              if (element.value['title'] == appFonts.totalBooking) {
                element.value["price"] =
                    statisticModel!.totalBookings.toString();
              }
              if (element.value['title'] == appFonts.totalService) {
                element.value["price"] =
                    statisticModel!.totalServices.toString();
              }
              if (element.value['title'] == appFonts.totalCategory) {
                element.value["price"] =
                    statisticModel!.totalCategories.toString();
              }
              if (element.value['title'] == appFonts.totalServiceman) {
                element.value["price"] =
                    statisticModel!.totalCategories.toString();
              }
              notifyListeners();
            });
          }
          notifyListeners();
        }
      });
    } catch (e) {
      log("EEE homeStatisticApi :$e");
      notifyListeners();
    }
  }

//get serviceman by provider
  getServicemenByProviderId() async {
    try {
      await apiServices.getApi(
          "${api.serviceman}?provider_id=${userModel!.id}", []).then((value) {
        if (value.isSuccess!) {
          List data = value.data;
          // log("data : $data");

          servicemanList = [];
          for (var list in data) {
            if (!servicemanList.contains(ServicemanModel.fromJson(list))) {
              servicemanList.add(ServicemanModel.fromJson(list));
            }
            notifyListeners();
          }
        }
        notifyListeners();
        log("serviceManList : ${servicemanList.length}");
      });
    } catch (e) {
      log("ERRROEEE getServicemenByProviderId : $e");
      notifyListeners();
    }
  }

//provider bank detail
  getBankDetails() async {
    try {
      log("BANK DETAIL");
      await apiServices.getApi(api.bankDetail, [], isToken: true).then((value) {
        bankDetailModel = null;
        if (value.isSuccess!) {
          log("BACKNK :${value.data}");
          if (value.data != null) {
            bankDetailModel = BankDetailModel.fromJson(value.data);
          }
          notifyListeners();
        }
        notifyListeners();
      });
    } catch (e) {
      log("ERRROEEE getBankDetails : $e");
      notifyListeners();
    }
  }

  //all job request list
  getJobRequest() async {
    // notifyListeners();
    try {
      await apiServices
          .getApi(api.serviceRequest, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          List category = value.data;
          jobRequestList = [];
          for (var data in category.reversed.toList()) {
            JobRequestModel jobRequestModel = JobRequestModel.fromJson(data);
            if (!jobRequestList.contains(jobRequestModel)) {
              jobRequestList.add(jobRequestModel);
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE AllCategory:::$e");
      notifyListeners();
    }
  }

//provider document detail
  getDocumentDetails() async {
    log("getDocumentDetails harshit id: ${userModel!.id}");
    try {
      await apiServices
          .getApi("${api.userDocuments}/${userModel!.id}", [], isToken: true)
          .then((value) {
        providerDocumentList = [];
        notUpdateDocumentList = [];
        notifyListeners();
        log("value.isSuccess getDocumentDetails ::${value.isSuccess}");
        if (value.isSuccess!) {
          for (var data in value.data) {
            providerDocumentList.add(ProviderDocumentModel.fromJson(data));
          }
          log("providerDocumentList ::${value.isSuccess}");
          log("providerDocumentList ::${providerDocumentList.length}");
          log("documentList ::${documentList.length}");
          notifyListeners();

          for (var d in documentList) {
            int index = providerDocumentList.indexWhere(
                (element) => element.documentId.toString() == d.id.toString());
            log("index :$index");
            if (index == -1) {
              notUpdateDocumentList.add(d);
            }
          }
          notifyListeners();

          log("notUpdateDocumentLists :$notUpdateDocumentList");
        }
        notifyListeners();
      });
    } catch (e, stacktrace) {
      log("ERROR in getDocumentDetails: $e");
      log("Stack Trace: $stacktrace"); // Optional for more debugging info
      notifyListeners();
    }
  }

  //notification list
  getNotificationList() async {
    try {
      await apiServices
          .getApi(api.notifications, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          List address = value.data;

          notificationList = [];
          for (var data in address.toList()) {
            if (!notificationList.contains(NotificationModel.fromJson(data))) {
              notificationList.add(NotificationModel.fromJson(data));
              log("noti : ${value.data}");
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE Notification::$e");
      notifyListeners();
    }
  }

// provider address List
  getAddressList(context) async {
    try {
      await apiServices.getApi(api.address, [], isToken: true).then((value) {
        if (value.isSuccess!) {
          addressList = [];

          List address = value.data['data'];
          //   log("address :$address");
          final locationVal =
              Provider.of<NewLocationProvider>(context, listen: false);
          locationVal.locationList = [];
          for (var data in address.reversed.toList()) {
            if (!addressList.contains(PrimaryAddress.fromJson(data))) {
              addressList.add(PrimaryAddress.fromJson(data));
            }

            notifyListeners();
          }

          for (var d in addressList) {
            var body = {
              "latitude": d.latitude,
              "longitude": d.longitude,
              "type": d.type,
              "address": d.address,
              "country_id": d.countryId,
              "state_id": d.stateId,
              "city": d.city,
              "area": d.area,
              "postal_code": d.code,
              "is_primary": d.isPrimary,
              "role_type": "provider",
              "status": d.status,
              "availability_radius": d.availabilityRadius
            };

            locationVal.locationList.add(body);
          }
          log("addressList 1:$addressList");
          notifyListeners();
        }
      });
    } catch (e) {
      notifyListeners();
      log("EEEE getLocationList: $e");
    }
  }

  //get popular service list
  getPopularServiceList({search, isPopular = 1}) async {
    // notifyListeners();
    try {
      String apiUrl = api.providerServices;
      if (search != null) {
        apiUrl = "${api.providerServices}?search=$search";
      } else if (search != null && isPopular == 1) {
        apiUrl =
            "${api.providerServices}?search=$search&popular_service=$isPopular";
      } else {
        apiUrl = "${api.providerServices}?popular_service=$isPopular";
      }

      await apiServices.getApi(apiUrl, [], isToken: true).then((value) {
        popularServiceList = [];
        if (value.isSuccess!) {
          List service = value.data;
          for (var data in service.reversed.toList()) {
            if (!popularServiceList.contains(Services.fromJson(data))) {
              popularServiceList.add(Services.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE getPopularServiceList: $e");
      notifyListeners();
    }
  }

  //update active status of service
  updateActiveStatusService(context, id, val, index) async {
    showLoading(context);

    popularServiceList[index].status = val == true ? 1 : 0;
    notifyListeners();

    var body = {"status": val == true ? "1" : 0, "_method": "PUT"};
    dio.FormData formData = dio.FormData.fromMap(body);
    try {
      await apiServices
          .postApi("${api.service}/$id", formData, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getPopularServiceList();
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE updateActiveStatusService : $e");
    }
  }

  //delete Address
  deleteAddress(context, id, {isBack = false}) async {
    showLoading(context);
    route.pop(context);

    log("DELETE ADDRESSS ::::");

    try {
      await apiServices
          .deleteApi("${api.address}/$id", {}, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getAddressList(context);
          final delete =
              Provider.of<DeleteDialogProvider>(context, listen: false);
          delete.onResetPass(
              context,
              language(context, appFonts.hurrayLocationDelete),
              language(context, appFonts.okay), () {
            route.pop(context);
          }, title: appFonts.deleteSuccessfully);
          final userApi =
              Provider.of<UserDataApiProvider>(context, listen: false);
          userApi.getAddressList(context);
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE deleteAddress : $e");
    }
  }

  //get service package list
  getServicePackageList({search}) async {
    // notifyListeners();
    try {
      String apiUrl = api.servicePackages;
      if (search != null) {
        apiUrl = "${api.servicePackages}?search=$search";
      } else {
        apiUrl = api.servicePackages;
      }

      await apiServices.getApi(apiUrl, [], isToken: true).then((value) {
        servicePackageList = [];
        if (value.isSuccess!) {
          List service = value.data;
          for (var data in service.reversed.toList()) {
            log("VALUE :${data['provider_id']}");
            if (!servicePackageList
                .contains(ServicePackageModel.fromJson(data))) {
              servicePackageList.add(ServicePackageModel.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE getServicePackageList: $e");
      notifyListeners();
    }
  }

  //get all service list
  getAllServiceList({search}) async {
    // notifyListeners();
    try {
      String apiUrl = api.providerServices;
      if (search != null) {
        apiUrl = "${api.providerServices}?search=$search";
      } else {
        apiUrl = api.providerServices;
      }

      await apiServices.getApi(apiUrl, [], isToken: true).then((value) {
        allServiceList = [];
        if (value.isSuccess!) {
          List service = value.data;
          for (var data in service.reversed.toList()) {
            if (!allServiceList.contains(Services.fromJson(data))) {
              allServiceList.add(Services.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log("EEEE getAllServiceList: $e");
      notifyListeners();
    }
  }

  //booking history list
  getBookingHistory(context, {search, pageKey = 1}) async {
    final booking = Provider.of<BookingProvider>(context, listen: false);
    dynamic data;

    if (search != null) {
      data = {"search": search};
    } else if (booking.selectedCategoryList.isNotEmpty &&
        booking.rangeStart != null &&
        booking.statusIndex != null) {
      data = {
        "status": bookingStatusList[booking.statusIndex!].name,
        "start_date": booking.rangeStart,
        "end_date": booking.rangeEnd,
        "category_ids": booking.selectedCategoryList,
        "search": search
      };
    } else if (booking.selectedCategoryList.isNotEmpty &&
        booking.rangeStart != null) {
      data = {
        "start_date": booking.rangeStart,
        "end_date": booking.rangeEnd,
        "category_ids": booking.selectedCategoryList,
        "search": search
      };
    } else if (booking.selectedCategoryList.isNotEmpty) {
      data = {"category_ids": booking.selectedCategoryList};
    } else if (booking.selectedCategoryList.isNotEmpty &&
        booking.statusIndex != null) {
      data = {
        "status": bookingStatusList[booking.statusIndex!].name,
        "category_ids": booking.selectedCategoryList,
        "search": search
      };
    } else if (booking.statusIndex != null) {
      data = {
        "status": bookingStatusList[booking.statusIndex!].name,
      };
    } else if (booking.rangeStart != null && booking.statusIndex != null) {
      data = {
        "status": bookingStatusList[booking.statusIndex!].name,
        "start_date": booking.rangeStart,
        "end_date": booking.rangeEnd,
        "search": search
      };
    } else if (booking.rangeStart != null) {
      data = {
        "start_date": booking.rangeStart,
        "end_date": booking.rangeEnd,
        "search": search
      };
    }

    try {
      log("BODU :$data");
      await apiServices
          .getApi(api.booking, data ?? [], isToken: true)
          .then((value) {
        log("value.isSuccess!:${value.isSuccess!} || ${value.data!}");
        if (value.isSuccess!) {
          booking.bookingList = [];
          for (var data in value.data) {
            if (!booking.bookingList.contains(BookingModel.fromJson(data))) {
              booking.bookingList.add(BookingModel.fromJson(data));
            }
            booking.notifyListeners();
          }
          if (booking.bookingList.isEmpty) {
            booking.isSearchData = true;
            booking.searchCtrl.text = "";
            booking.notifyListeners();
          } else {
            booking.isSearchData = false;
          }
          booking.notifyListeners();
        }
      });

      log("STATYS BIIk L ${booking.bookingList.length}");
    } catch (e) {
      log("EEEE getBookingHistory ::$e");
      notifyListeners();
    }
  }

  //getWallet list
  getWalletList(context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    try {
      await apiServices
          .getApi(api.walletProvider, [], isToken: true, isData: true)
          .then((value) {
        //log("WALLLL :${value.data} //${value.message}");
        log("walletProvider::${walletProvider.wallet}");
        if (value.isSuccess!) {
          walletProvider.providerWalletModel =
              ProviderWalletModel.fromJson(value.data);
          walletProvider.balance =
              double.parse(value.data['balance'].toString());
          notifyListeners();
          walletProvider.notifyListeners();
        } else {}
      });
    } catch (e) {
      log("ERRROEEE getWalletList : $e");
      notifyListeners();
    }
  }

  //getWallet list
  getServicemanWalletList(context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    try {
      await apiServices
          .getApi(api.walletServiceman, [], isToken: true, isData: true)
          .then((value) {
        //log("WALLLL :${value.data} //${value.message}");
        log("walletProvider::${walletProvider.wallet}");
        if (value.isSuccess!) {
          walletProvider.servicemanWalletModel =
              ServicemanWalletModel.fromJson(value.data);
          walletProvider.balance =
              double.parse(value.data['balance'].toString());
          notifyListeners();
          walletProvider.notifyListeners();
        } else {}
      });
    } catch (e) {
      log("ERRROEEE getWalletList : $e");
      notifyListeners();
    }
  }

  //statistic detail chart list
  statisticDetailChart() async {
    try {
      await apiServices
          .getApi(api.homeChart, [], isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          revenueModel = RevenueModel.fromJson(value.data);
          notifyListeners();
          appArray.weekData = [];
          appArray.monthData = [];
          appArray.yearData = [];
          for (var d in revenueModel!.weekdayRevenues) {
            appArray.weekData.add(ChartData(x: d.x, y: d.y!));
          }
          for (var d in revenueModel!.monthlyRevenues) {
            appArray.monthData.add(ChartData(x: d.x, y: d.y!));
          }
          for (var d in revenueModel!.yearlyRevenues) {
            appArray.yearData.add(ChartData(x: d.x, y: d.y!));
          }
          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE statisticDetailChart : $e");
      notifyListeners();
    }
  }

  //total earning by category
  getTotalEarningByCategory() async {
    try {
      await apiServices
          .getApi(api.getTotalEarningByCategory, [],
              isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          log("VALUES ::${value.data} // ${value.message}");
          totalEarningModel = TotalEarningModel.fromJson(value.data);
          notifyListeners();
          totalEarningModel!.categoryEarnings!.asMap().entries.forEach((d) {
            appArray.earningChartData.add(ChartDataColor(
                d.value.categoryName!,
                d.value.percentage!,
                d.key == 0
                    ? const Color(0xFF5465FF)
                    : d.key == 1
                        ? const Color(0xFF7482FD)
                        : d.key == 2
                            ? const Color(0xFF949FFC)
                            : d.key == 3
                                ? const Color(0xFFB5BCFA)
                                : const Color(0xFFB5BCFA)));
          });

          notifyListeners();
        } else {
          notifyListeners();
        }
      });
    } catch (e) {
      log("EEEE getTotalEarningByCategory: $e");
      notifyListeners();
    }
  }

  //commission history
  commissionHistory(isCompletedMe) async {
    try {
      await apiServices
          .getApi(
              "${api.commissionHistory}?completed_by_me=${isCompletedMe == true ? 1 : 0}",
              [],
              isData: true,
              isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          commissionList = null;
          log("commissionList:: ${api.commissionHistory}?completed_by_me=${isCompletedMe == true ? 1 : 0}");
          commissionList = CommissionHistoryModel.fromJson(value.data);
          notifyListeners();
          // log("commissionList ${commissionList!.total}");
        }
        notifyListeners();
      });
    } catch (e) {
      log("EEEE commissionHistory :$e");
      notifyListeners();
    }
  }

  getMyReview() async {
    try {
      await apiServices.getApi(api.review, [], isToken: true).then((value) {
        if (value.isSuccess!) {
          List list = value.data;
          if (list.isNotEmpty) {
            reviewList = [];
          }
          for (var data in value.data) {
            if (!reviewList.contains(Reviews.fromJson(data))) {
              reviewList.add(Reviews.fromJson(data));
            }
            notifyListeners();
          }
          log("reviews :${reviewList.length}");
        }
      });
    } catch (e) {
      log("getMyReview :$e");
      notifyListeners();
    }
  }

  //category list
  getCategory({search}) async {
    // notifyListeners();
    try {
      String apiUrl = "${api.category}?providerId=${userModel!.id}";
      if (search != null) {
        apiUrl = "${api.category}?providerId=${userModel!.id}&search=$search";
      } else {
        apiUrl = "${api.category}?providerId=${userModel!.id}";
      }

      await apiServices.getApi(apiUrl, []).then((value) {
        if (value.isSuccess!) {
          categoryList = [];
          List category = value.data;
          log("categorycategory :${category.length}");
          for (var data in category.reversed.toList()) {
            if (!categoryList.contains(CategoryModel.fromJson(data))) {
              categoryList.add(CategoryModel.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }

  commonCallApi(context) {
    homeStatisticApi();
    getCategory();
    statisticDetailChart();
    getAllServiceList();
    getPopularServiceList();
    getDocumentDetails();
    getBankDetails();
    getJobRequest();
    getServicemenByProviderId();
    getServicePackageList();
    getNotificationList();
    getAddressList(context);
    getBookingHistory(context);
    getWalletList(context);
    getServicemanWalletList(context);
    getTotalEarningByCategory();
    getMyReview();
    commissionHistory(false);
    if (isServiceman) {
      if (userModel != null) {
        getProviderById(context, userModel!.providerId);
      }
    }
  }

  //get provider detail id
  getProviderById(context, id) async {
    try {
      await apiServices
          .getApi("${api.provider}/$id", [], isData: true)
          .then((value) {
        if (value.isSuccess!) {
          provider = ProviderModel.fromJson(value.data);
          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getProviderById : $e");
      notifyListeners();
    }
  }
}
