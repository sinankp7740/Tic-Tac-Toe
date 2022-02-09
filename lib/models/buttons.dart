import 'package:flutter/material.dart';

class Buttons{
  int id;
  String text;
  Color color= Colors.grey.shade700 ;
  bool enabled;
  Buttons({
    required this.id ,this.enabled=true,this.text=""
  });
}