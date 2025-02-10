class ActiveSubscription {
  int? id;
  String? userId;
  String? userPlanId;
  String? startDate;
  String? endDate;
  String? total;
  String? allowedMaxServices;
  String? allowedMaxAddresses;
  String? allowedMaxServicemen;
  String? allowedMaxServicePackages;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  ActiveSubscription(
      {this.id,
        this.userId,
        this.userPlanId,
        this.startDate,
        this.endDate,
        this.total,
        this.allowedMaxServices,
        this.allowedMaxAddresses,
        this.allowedMaxServicemen,
        this.allowedMaxServicePackages,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  ActiveSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userPlanId = json['user_plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    total = json['total'];
    allowedMaxServices = json['allowed_max_services'];
    allowedMaxAddresses = json['allowed_max_addresses'];
    allowedMaxServicemen = json['allowed_max_servicemen'];
    allowedMaxServicePackages = json['allowed_max_service_packages'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_plan_id'] = userPlanId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['total'] = total;
    data['allowed_max_services'] = allowedMaxServices;
    data['allowed_max_addresses'] = allowedMaxAddresses;
    data['allowed_max_servicemen'] = allowedMaxServicemen;
    data['allowed_max_service_packages'] = allowedMaxServicePackages;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}