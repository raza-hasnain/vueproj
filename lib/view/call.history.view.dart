import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/call_log.controller.dart';
import 'package:test_project/utils/local.storage.dart';
import 'package:test_project/widget/call_log/yesterday.calls.widget.dart';
import '../controller/leads.controller.dart';
import '../theme/p_theme.dart';
import '../widget/call_log/older.callslogs.widget.dart';
import '../widget/call_log/today.calls.widget.dart';
import '../widget/sales_navbar.dart' as nav;
import '../widget/manager_navbar.dart' as nav;

final callLogsStorage = PageStorageBucket();

class CallHistory extends StatefulWidget {
  const CallHistory({super.key});

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  final _localStorage = LocalStorage();

  getPreviousSubmittedCallHistory() async {
    context.read<CallLogController>().getTheSavedList =
        (await _localStorage.getSavedCallHistory())
            .cast<Map<String, dynamic>?>();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CallLogController>().getCalls(context));
    getPreviousSubmittedCallHistory();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final callLogController = Provider.of<CallLogController>(context, listen: true);

    return Scaffold(
      backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
      floatingActionButton: (callLogController.entries.isEmpty ||
              callLogController.selectedIndexes.isEmpty ||
              callLogController.callLogsList.isEmpty)
          ? const SizedBox.shrink()
          : callLogController.isLoading == false
              ? getSubmitButton()
              : const CircularProgressIndicator.adaptive(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        title: Image(
          image: dark
              ? const AssetImage("assets/images/logo/hikallogo.png")
              : const AssetImage("assets/images/logo/fullLogoRE.png"),
          height: 30,
        ),
        backgroundColor: dark ? CustomAppTheme().colorBlack : CustomAppTheme().creamLight,
        iconTheme: IconThemeData(
          color: dark ? CustomAppTheme().redBright : CustomAppTheme().blackFade,
        ),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: dark
                        ? CustomAppTheme().redBright
                        : CustomAppTheme().blackFade,
                  ),
                  onPressed: null,
                ),
                const SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Consumer<LeadController>(builder: (context, role, _) {
        return role.leadModel.user![0].role == 7
            ? nav.NavigationDrawer()
            : role.leadModel.user![0].role == 3
            ? nav.MNavigationDrawer()
            : nav
            .NavigationDrawer();
      }),
      body: (callLogController.todayCalls.isEmpty && callLogController.olderCalls.isEmpty)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text("No call history found"),
              ),
            )
          : PageStorage(
              bucket: callLogsStorage,
              child: SingleChildScrollView(
                key: PageStorageKey<String>("callHistoryKey"),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text(
                                "CALL HISTORY",
                                style: TextStyle(
                                  color: dark
                                      ? CustomAppTheme().colorWhite
                                      : CustomAppTheme().blackFade,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                  checkColor: !dark
                                      ? CustomAppTheme().colorWhite
                                      : CustomAppTheme().blackFade,
                                  onChanged: (value) {
                                    if (callLogController.callLogsList.length !=
                                        callLogController.allCallData.length) {
                                      callLogController.callLogsList.clear();
                                      callLogController.selectedIndexes.clear();
                                      List<Map<String, dynamic>> temp = [];

                                      temp.clear();

                                      temp.addAll(callLogController.allCallData
                                          .map((e) => e));

                                      for (int i = 0; i < temp.length; i++) {
                                        callLogController.selectContact(
                                            "$i",
                                            temp[i]['leadContact'],
                                            callLogController.FormateDate(
                                                callLogController.allCallData[i]
                                                    ['dateTime']),
                                            temp[i]['duration'],
                                            temp[i]['status'] ==
                                                    CallType.outgoing
                                                ? "Dialed call"
                                                : temp[i]['status'] ==
                                                        CallType.incoming
                                                    ? 'Received call'
                                                    : temp[i]['status'] ==
                                                            CallType.missed
                                                        ? 'Missed call'
                                                        : temp[i]['status'] ==
                                                                CallType
                                                                    .rejected
                                                            ? 'Rejected call'
                                                            : 'Unknown call',
                                            context);
                                      }

                                      setState(() {});
                                    } else {
                                      callLogController.callLogsList.clear();
                                      callLogController.selectedIndexes.clear();

                                      setState(() {});
                                    }
                                  },
                                  value: (callLogController
                                              .callLogsList.length ==
                                          callLogController.allCallData.length)
                                      ? true
                                      : false),
                            ),
                          ],
                        ),
                      ),
                      callLogController.todayCalls.isEmpty
                          ? SizedBox()
                          : Text(
                              "Today",
                              style: TextStyle(
                                  color: dark
                                      ? CustomAppTheme().colorWhite
                                      : CustomAppTheme().redBright,
                                  fontWeight: FontWeight.w500),
                            ),
                      SizedBox(height: 10),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: callLogController.todayCalls.length +
                              callLogController.yesterdayCalls.length +
                              callLogController.olderCalls.length,
                          itemBuilder: (context, index) {
                            final data = callLogController.todayCalls;

                            // TODAY CALL HISTORY
                            if (index < callLogController.todayCalls.length) {
                              return TodayCallsWidget(
                                callLogController: callLogController,
                                dark: dark,
                                data: data,
                                index: index,
                              );
                            }

                            // YESTERDAY CALL HISTORY
                            else if (index <
                                callLogController.todayCalls.length +
                                    callLogController.yesterdayCalls.length) {
                              final data1 = callLogController.yesterdayCalls;
                              int indexInList2 =
                                  index - callLogController.todayCalls.length;

                              return YesterdayCallsWidget(
                                index: index,
                                callLogController: callLogController,
                                data: data1,
                                dark: dark,
                                yesteredayListIndex: indexInList2,
                              );
                            }

                            //OLDER CALL HISTORY
                            else {
                              final olderData = callLogController.olderCalls;

                              int indexInList3 = index -
                                  (callLogController.yesterdayCalls.length +
                                      callLogController.todayCalls.length);

                              return OlderCallsWidget(
                                callLogController: callLogController,
                                dark: dark,
                                data: olderData,
                                index: index,
                                olderListIndex: indexInList3,
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  //SUBMIT BUTTON
  Widget getSubmitButton() {
    return ElevatedButton(
      child: const Text("Submit"),
      onPressed: () async {
        //CALLING CALL LOG API TO SUBMIT THE DATA TO THE SERVER
        await context.read<CallLogController>().callLogApi(context);

        //SAVING THE CALL HISTORY LOCALLY
        await _localStorage
            .saveCallHistory(context.read<CallLogController>().callLogsList);

        //CLEARING THE LIST OF CALLS AND SAVE INDEXES AFTER SUBMISSION CALLS LOGS TO THE SERVER
        context.read<CallLogController>().callLogsList.clear();
        context.read<CallLogController>().selectedIndexes.clear();
        setState(() {});
      },
    );
  }
}
