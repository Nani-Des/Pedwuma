class JobItemData {
  final String customerID;
  final String pic;
  final String jobID;
  final String jobCategory;
  final String fullName;
  final String jobService;
  final String chargeRate;
  String? deadline;
  final int charge;
  final String seenBy;
  bool? jobStatus;
  int? peopleApplied;
  String? rating;
  List? portfolio;
  bool? isReferencesPresent;
  bool? isPortfolioPresent;
  List? certification;
  List? experience;
  int? jobsDone;
  List? references;
  JobItemData({
    required this.pic,
    required this.customerID,
    this.peopleApplied,
    required this.jobID,
    required this.seenBy,
    required this.chargeRate,
    required this.jobCategory,
    required this.fullName,
    required this.jobService,
    required this.charge,
    this.isPortfolioPresent,
    this.isReferencesPresent,
    this.jobStatus,
    this.deadline,
    this.portfolio,
    this.rating,
    this.certification,
    this.experience,
    this.references,
    this.jobsDone,
  });
}

//for bookmarks, add isJobBookmarked field in firebase and use that in the 'where' snippet
// to compare and pull matching data to load data for bookmarked items
