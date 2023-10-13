class CustomerCategoryData {
  final String pic;
  final String jobID;
  final String jobCategory;
  final String fullName;
  final String jobService;
  final String rating;
  final String chargeRate;
  final int charge;
  final String seenBy;

  const CustomerCategoryData({
    required this.pic,
    required this.jobID,
    required this.seenBy,
    required this.chargeRate,
    required this.jobCategory,
    required this.fullName,
    required this.jobService,
    required this.rating,
    required this.charge,
  });
}
