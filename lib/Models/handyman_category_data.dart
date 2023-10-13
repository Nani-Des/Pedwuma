class HandymanCategoryData {
  final String pic;
  final String jobID;
  final String jobCategory;
  final String fullName;
  final String jobService;
  final String chargeRate;
  final int charge;
  final String seenBy;
  final bool jobStatus;

  const HandymanCategoryData({
    required this.pic,
    required this.jobID,
    required this.seenBy,
    required this.chargeRate,
    required this.jobCategory,
    required this.fullName,
    required this.jobService,
    required this.charge,
    required this.jobStatus,
  });
}
