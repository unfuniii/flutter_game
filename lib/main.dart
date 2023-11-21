import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'node.dart';

List<Node> gameData = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String csv = 'assets/game_data.csv';
  String fileData = await rootBundle.loadString(csv);

  List<String> rows = fileData.split("\n");
  for (int i = 0; i < rows.length; i++) {
    String row = rows[i];
    List<String> itemInRow = row.split(",");

    Node node = Node(
      int.parse(itemInRow[0]),
      int.parse(itemInRow[1]),
      itemInRow[2],
      int.parse(itemInRow[3]),
      itemInRow[4],
    );

    gameData.add(node);
  }

  runApp(
    const MaterialApp(
      home: MyGameApp(),
    ),
  );
}

class MyGameApp extends StatefulWidget {
  const MyGameApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyGameState();
  }
}

class MyGameState extends State<MyGameApp> {
  late int iD;
  late int nextID;
  String description = '';


  void buttonHandler(bool isChoiceTrue) {
    print('Button pressed');
    setState(() {
      for (Node nextNode in gameData) {
        if (nextNode.iD == nextID) {
          iD = nextNode.iD;

          if (isChoiceTrue) {
            nextID = nextNode.nextIDTrue;
            description = nextNode.choiceTrue;
          } else {
            nextID = nextNode.nextIDFalse;
            description = nextNode.choiceFalse;
          }

          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd7b516),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        buttonHandler(true); // Represents choosing the first option
                      },
                      color: const Color(0xff019fa1),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      textColor: const Color(0xfffffdfd),
                      height: 40,
                      minWidth: 140,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        "Option 1",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MaterialButton(
                      onPressed: () {
                        buttonHandler(false); // Represents choosing the second option
                      },
                      color: const Color(0xff019fa1),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      textColor: const Color(0xfffffdfd),
                      height: 40,
                      minWidth: 140,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        "Option 2",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.3),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 56,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => const GamePage()),
  //               );
  //             },
  //             child: const Text('Start'),
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Exit'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// }
//
// class GamePage extends StatelessWidget {
//   const GamePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Game Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Choose Your Gender'),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SecondGamePage()),
//                 );
//                 // Handle Female selection
//                 print('Female selected');
//               },
//               child: const Text('Female'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SecondGamePage()),
//                 );
//                 // Handle Male selection
//                 print('Male selected');
//               },
//               child: const Text('Male'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class SecondGamePage extends StatelessWidget {
//   const SecondGamePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ThirdGamePage()),
//                 );
//               },
//               child: const Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ThirdGamePage extends StatelessWidget {
//   const ThirdGamePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Third Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SecondGamePage()),
//                 );
//               },
//                 child: const Text('Blabla'),)
//           ],
//         )
//       )
//     );
//   }
//
// }