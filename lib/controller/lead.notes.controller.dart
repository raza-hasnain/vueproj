import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:test_project/model/lead.notes.model.dart';
import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class LeadsNotesController extends ChangeNotifier implements TickerProvider {
  List<Ticker> _tickers = [];

  @override
  Ticker createTicker(TickerCallback onTick) {
    final ticker = Ticker(onTick, debugLabel: 'TickerProvider');
    _tickers.add(ticker);
    return ticker;
  }

  late AnimationController bottomSheetController;

  LeadsNotesController() {
    intiallizeBottomSheetAnimationController();
  }
  @override
  void dispose() {
    super.dispose();
    for (final ticker in _tickers) {
      ticker.dispose();
    }
    _tickers.clear();
  }

  bool _loadMore = true;
  bool _isLoading = false;
  LeadNotesModel? _apiModel;
  late String loginToken;
  LeadNotesModel? get apiModel => _apiModel;
  final LocalStorage _localStorage = LocalStorage();

  intiallizeBottomSheetAnimationController() {
    bottomSheetController = BottomSheet.createAnimationController(this);
    bottomSheetController.duration = const Duration(milliseconds: 500);
    bottomSheetController.reverseDuration = const Duration(milliseconds: 500);
  }

  Future<String?> getloginToken() async {
    loginToken = (await _localStorage.getLoginToken())!;

    return loginToken;
  }

  Future fetchLeadsNotes(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false,
      required int id}) async {
    await getloginToken().then((value) {
      loginToken = value!;

      notifyListeners();
    });
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    LeadNotesModel? response = await RemoteServices.noteLeads(
        query: loadMoreUrl ?? "?page=pagenumber",
        loginToken: loginToken,
        id: id);
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.posts?.nextPageUrl == null) {
        _loadMore = true;

        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.posts?.data != null) {
        //paginate data with existing model.
        apiModel?.posts?.data?.addAll(response.posts!.data!);
        //change next page url for another iterate.
        apiModel?.posts?.nextPageUrl = response.posts?.nextPageUrl;
        //removing duplicate values
        _apiModel?.posts?.data?.distinctBy((e) => e.id);
      } else {
        //means first time.
        _apiModel = response;
      }

      notifyListeners();
    } else {}
  }

  EasyRefreshController controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  void onLoading(int id) async {
    if (_loadMore == false || _apiModel?.posts?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
      log("can we load correctly?");
    }
    fetchLeadsNotes(
        id: id, isInitial: false, loadMoreUrl: _apiModel?.posts?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
