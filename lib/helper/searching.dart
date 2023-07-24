class HelperFunctions {
  // SEARCH THE NEW LEADS
  static searching(String query, List<dynamic> modelList,
      List<dynamic> searchList, Function() notifyListener) {
    final suggestion = modelList.where((element) {
      final leadNames = element.newLeads!.data![0].leadName!.toLowerCase();
      final input = query.toLowerCase();
      return leadNames.contains(input);
    }).toList();
    searchList = suggestion;
    searchList.clear();
    notifyListener();
  }
}
