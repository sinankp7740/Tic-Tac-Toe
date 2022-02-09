import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Screens/gameScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Are you sure want to leave?'),
                  actions: [
                    ElevatedButton(
                        // onPressed:
                        onPressed: () => exit(0),
                        child: const Text('Yes'),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                        ),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No',style: TextStyle(color: Colors.white),),
                         style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                        )
                  ],
                ));
        return willLeave;
      },
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: height,
          width: width,
          color: Colors.brown.shade900,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.15,
              ),
              const Text(
                "Tic Tac Toe",
                style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Center(
                child: SizedBox(
                  width: width * 0.5,
                  height: height * 0.1,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.greenAccent.shade700)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Game()));
                    },
                    child: Text(
                      "Start Game",
                      style: TextStyle(
                          color: Colors.purple.shade50, fontSize: 30.0),
                    ),
                  ),
                ),
              ),
               SizedBox(height: height*0.02,),
               Center(child: Text("lets begin the fun!!!",style: TextStyle(color:Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600),),)
            ],
          ),
        )),
      ),
    );
  }
}
