// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:test_project/utils/global.util.dart';
//
// class AppPopUps {
//   showDialogue({required Widget child}) {
//     return showGeneralDialog(
//         context: navigatorKey.currentState!.context,
//         pageBuilder: (BuildContext context, Animation<double> animation,
//             Animation<double> secondayAnimation) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: AlertDialog(
//               backgroundColor: Colors.transparent,
//               contentPadding: EdgeInsets.zero,
//               content: ClipRRect(
//                   borderRadius: BorderRadius.circular(8), child: child),
//             ),
//           );
//         });
//   }
//   //NO INTERNET DIALOGUE BOX
//   noInternetConnectionDialogue() {
//     showDialogue(
//         child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircleAvatar(
//             radius: 15,
//             backgroundColor: Colors.red,
//             child: IconButton(
//                 padding: EdgeInsets.zero,
//                 onPressed: () => navigatorKey.currentState!.pop(),
//                 icon: Icon(
//                   Icons.close,
//                   color: Colors.white,
//                 ))),
//         SizedBox(
//           height: 20,
//         ),
//         Lottie.asset(noInternet),
//       ],
//     ));
//   }
//
//   //SOMETHING WENT WRONG
//   someThingWentWrongDialogue() {
//     showDialogue(
//         child: Container(
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(8)),
//       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Something went wrong!",
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () => navigatorKey.currentState!.pop(),
//               child: Text(
//                 "OK",
//                 style: TextStyle(fontSize: 15),
//               ))
//         ],
//       ),
//     ));
//   }
//
//   //ERROR DIALOGUE BOX
//   errorDialogueBox() {
//     showDialogue(
//         child: Container(
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(8)),
//       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(height: 30, child: Image.asset(errorIcon)),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "An Error occured!!",
//             style: TextStyle(fontSize: 20, color: Colors.black),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () => navigatorKey.currentState!.pop(),
//               child: Text(
//                 "OK",
//                 style: TextStyle(fontSize: 15),
//               ))
//         ],
//       ),
//     ));
//   }
// }



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/utils/global.util.dart';
import '../utils/assets.dart';


class AppPopUps {
  showDialogue({required Widget child}) {
    return showGeneralDialog(
        context: navigatorKey.currentState!.context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondayAnimation) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: ClipRRect(
                  borderRadius: BorderRadius.circular(8), child: child),
            ),
          );
        });
  }
  //NO INTERNET DIALOGUE BOX
  noInternetConnectionDialogue() {
    showDialogue(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => navigatorKey.currentState!.pop(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ))),
            SizedBox(
              height: 20,
            ),
            Lottie.asset(noInternet),
          ],
        ));
  }

  //SOMETHING WENT WRONG
  someThingWentWrongDialogue() {
    showDialogue(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Something went wrong!",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => navigatorKey.currentState!.pop(),
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
        ));
  }

  //ERROR DIALOGUE BOX
  errorDialogueBox() {
    showDialogue(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(height: 30, child: Image.asset(errorIcon)),
              SizedBox(
                height: 20,
              ),
              Text(
                "An error occurred!",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => navigatorKey.currentState!.pop(),
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
        ));
  }
}
