import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/buttons.dart';
import 'package:tic_tac_toe/widgets/dialogBox.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var player1;
  var player2;
  var activePlayer;
  bool isButtonEnabled = true;
  late List<Buttons> gridList;
  @override
  void initState() {
    super.initState();
    gridList = doInit();
  }

  List<Buttons> doInit() {
    player1 = List.empty(growable: true);
    player2 = List.empty(growable: true);
    activePlayer = 1;
    var buttons = <Buttons>[
      Buttons(id: 1),
      Buttons(id: 2),
      Buttons(id: 3),
      Buttons(id: 4),
      Buttons(id: 5),
      Buttons(id: 6),
      Buttons(id: 7),
      Buttons(id: 8),
      Buttons(id: 9),
    ];
    return buttons;
  }

  //function to run the game
  void PlayGame(Buttons bt) {
    setState(() {
      if (activePlayer == 1) {
        bt.text = "X";
        bt.color = Colors.blue;
        activePlayer = 2;
        player1.add(bt.id);
      } else {
        bt.text = "O";
        bt.color = Colors.red;
        activePlayer = 1;
        player2.add(bt.id);
      }
      bt.enabled = false;

      int winner = Result();
      if (winner == -1) {
        if (gridList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (context) => DialogBox(
                    title: "Draw",
                    content: "press restart to start again",
                    callback: reset,
                  ));
        } else {
          activePlayer == 2 ? autoplay() : null;
        }
      }
    });
  }

  //autoplay
  void autoplay() {
    var emptyCells = List.empty(growable: true);
    var list = List.generate(9, (index) => index + 1);
    for (var buttonId in list) {
      if (!(player1.contains(buttonId) || player2.contains(buttonId))) {
        emptyCells.add(buttonId);
      }
    }
    var r = Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randIndex];
    int i = gridList.indexWhere((p) => p.id == cellId);
    PlayGame(gridList[i]);
  }

  //function for result
  int Result() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (context) => DialogBox(
                  title: "Player1 Won",
                  content: "Press restart button to start again",
                  callback: reset,
                ));
      } else if (winner == 2) {
        showDialog(
            context: context,
            builder: (context) => DialogBox(
                  title: "Player 2 Won",
                  content: "Press restart button to start again",
                  callback: reset,
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => DialogBox(
                  title: "Draw!",
                  content: "Press restart button to start again",
                  callback: reset,
                ));
      }
    }
    return winner;
  }

  //function for reset the game
  void reset() {
    if (Navigator.canPop(context)) Navigator.pop(context);

    setState(() {
      gridList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade700,
        title: const Center(
          child: Text(
            "Tic Tac Toe",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.brown.shade900,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: ElevatedButton(
                        onPressed: gridList[index].enabled
                            ? () {
                                PlayGame(gridList[index]);
                              }
                            : null,
                        child: Text(gridList[index].text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              gridList[index].color),
                        ),
                      ),
                    );
                  },
                  itemCount: gridList.length,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  color: Colors.red,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        /// reset();
                        showDialog(
                            context: context,
                            builder: (context) => DialogBox(
                                  title: "Alert",
                                  content: "Are you sure to restart the game",
                                  callback: reset,
                                ));
                      },
                      child: const Text(
                        "Restart",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                ))
          ],
        ),
      )),
    );
  }
}
