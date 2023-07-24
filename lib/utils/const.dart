class Urls {
  static String baseUri = 'https://api.hikalcrm.com/';
  static String loginUri = '${baseUri}api/login';
  static String callLogs = '${baseUri}api/upsert';
  static String leads = '${baseUri}api/profile';
  static String logout = '${baseUri}api/logout';
  static String allUsers = '${baseUri}api/users';
  static String coldleads = "${baseUri}api/coldLeads";
  static String personalleads = "${baseUri}api/coldLeads?coldCall=2";
  static String thirdpartyleads = "${baseUri}api/coldLeads?coldCall=3";
  static String newLeads = "${baseUri}api/newLeads";
  static String followUp = "${baseUri}api/followup";
  static String meetings = "${baseUri}api/meeting";
  static String closedDeals = "${baseUri}api/closedDeals";
  static String updatePassword = "${baseUri}api/updatePassword";
    static String leadNotes = "${baseUri}api/leadNotes";

}

  late String bearerToken = "";
