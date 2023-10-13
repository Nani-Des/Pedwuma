class CustomerJobUploadItemData {
  final String seenBy;
  final String deadlineDay;
  final String deadlineMonth;
  final String deadlineYear;
  final String serviceCat;
  final String serviceProvided;
  final String charge;
  final String chargeRate;
  String? expertise;
  List? portfolio;
  final String rating;
  final String houseNum;
  final String region;
  final String town;
  final String street;
  final bool portfolioOption;
  final bool referenceOption;
  final String jobUploadId;
  String? uploadDate;
  String? name;
  String? uploadTime;
  String? pic;
  CustomerJobUploadItemData({
    this.expertise,
    this.portfolio,
    required this.jobUploadId,
    required this.serviceProvided,
    required this.seenBy,
    required this.deadlineDay,
    required this.deadlineMonth,
    required this.deadlineYear,
    required this.serviceCat,
    required this.charge,
    required this.chargeRate,
    required this.rating,
    required this.houseNum,
    required this.region,
    required this.town,
    required this.street,
    required this.portfolioOption,
    required this.referenceOption,
    this.uploadDate,
    this.uploadTime,
    this.name,
    this.pic,
  });
}
