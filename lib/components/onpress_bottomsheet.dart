import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controller/lead.notes.controller.dart';
import '../theme/p_theme.dart';
import '../utils/assets.dart';
import '../widget/new.leads.widget/notes.card.widget.dart';

class BottomSheetClass {
  static Future<dynamic> leadNotesBottomSheet(
    BuildContext context,
    bool dark,
    String leadName,
    String feedback,
    String project,
    String enquiry,
    AnimationController bottomSheetController,
    int lid
  ) {
    final notesController = Provider.of<LeadsNotesController>(context, listen: false);
    final apiCalling = notesController.apiModel?.posts?.data;
    return showModalBottomSheet(
      transitionAnimationController: bottomSheetController,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
          color: dark ? CustomAppTheme().darkBg : CustomAppTheme().creamLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: EasyRefresh(
          onLoad: () => notesController.onLoading(lid),
          simultaneously: true,
          controller: context.read<LeadsNotesController>().controller,
          header: const ClassicHeader(
            processedDuration: Duration(milliseconds: 100),
          ),
          footer: const ClassicFooter(noMoreText: "Lead notes ended"),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          leadName,
                          softWrap: false,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: dark
                                ? CustomAppTheme().colorWhite
                                : CustomAppTheme().redBright,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Spacer(),
                            Card(
                              color: CustomAppTheme().redBright,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  feedback,
                                  style: TextStyle(
                                    color: CustomAppTheme().colorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Contact: ', // TODO MOBILE NUMBER AND EMAIL ADDRESS
                    style: TextStyle(
                      color: dark
                          ? CustomAppTheme().colorLightGrey
                          : CustomAppTheme().blackFade,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Project: $project',
                    style: TextStyle(
                      color: dark
                          ? CustomAppTheme().colorLightGrey
                          : CustomAppTheme().blackFade,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Enquiry: $enquiry',
                    style: TextStyle(
                      color: dark
                          ? CustomAppTheme().colorLightGrey
                          : CustomAppTheme().blackFade,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Agent: ', // TODO NAME OF SALES AGENT AND MANAGER
                    style: TextStyle(
                      color: dark
                          ? CustomAppTheme().colorLightGrey
                          : CustomAppTheme().blackFade,
                    ),
                  ),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    children: [
                      Spacer(),
                      // SizedBox(width: 5.0),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            color: CustomAppTheme().redBright,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: CustomAppTheme().colorWhite,
                          ),
                        ),
                        onTap: () {},
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: apiCalling?.length ?? 0,
                  itemBuilder: (context, index) {
                    return NotesCard(
                      creationTime: apiCalling![index].creationDate,
                      notes: apiCalling[index].leadNote.toString(),
                      salesAgentname: "sales agent name",
                      salesManagerName: 'sales manager name',
                      salesName: 'sales name',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  static Future onpress(BuildContext context, int id, dynamic data, bool dark,
      AnimationController bottomSheetController) async {
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                child: Lottie.asset(lottieLoading),
              ),
            ],
          );
        });
    await context.read<LeadsNotesController>().fetchLeadsNotes(id: id);
    Navigator.pop(context);

    leadNotesBottomSheet(
      context,
      dark,
      data.leadName!,
      data.feedback ?? "",
      data.project ?? "",
      data.enquiryType ?? "",
      // data.leadTye ?? "",
      // data.leadFor ?? "",
      bottomSheetController,
      data.lid!,
    );
  }
}
