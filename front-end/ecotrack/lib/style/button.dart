import 'package:ecotrack/style/colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle mainButtton = ElevatedButton.styleFrom(
  minimumSize: const Size(352, 50), 
  backgroundColor: mainButtonColor,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)
  )
);

final ButtonStyle secondMainButton = OutlinedButton.styleFrom(
  minimumSize:const Size(352, 50),
  backgroundColor: Colors.white,
  side:const  BorderSide(color: Color(0xff46A74A),width: 2),
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)
  ),
);