import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vendor/controllers/auth_controller.dart';
import 'package:vendor/screens/home.dart';
import 'package:vendor/screens/order_screen.dart';
import 'package:vendor/screens/profile_screen.dart';
import 'package:vendor/screens/wallet_screen.dart';

final primaryColor = Color.fromARGB(255, 255, 168, 7);

//auth
var authController = AuthController.instance;

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

//list of screens
List screens = [
  Home(),
  OrderScreen(),
  Wallet(),
  ProfileScreens(
    uid: authController.user.uid,
  ),
];

//list of menus
List menus = [
  {
    "item_name": "Chicken Burger",
    "item_price": "RM 23.90",
    "item_description": "Chicken burger",
    "category": "Burger",
    "item_image":
        "https://firebasestorage.googleapis.com/v0/b/foodie-app-30c78.appspot.com/o/images%2FImage%201?alt=media&token=18a15370-4598-4aad-8f90-adc3eb7d7de7"
  },
  {
    "item_name": "Garlic Bread",
    "item_price": "RM 13.90",
    "item_description": "Garlic bread",
    "category": "Burger",
    "item_image":
        "https://firebasestorage.googleapis.com/v0/b/foodie-app-30c78.appspot.com/o/profilePicture%2FGcrDw8bSIGSiuNjvWX53rXuLfXE2?alt=media&token=2a8203a1-68bd-4a0f-a893-f053ff5b5b94"
  }
];

//Cuisines
const cuisines = [
  "Western",
  "Chinese",
  "Malay",
  "Indian",
  "Korean",
  "Japanese",
  "Indonesian",
  "Hawaian",
];

//Category
const category = [
  "Burger",
  "Soup Noodle",
  "Spaggheti",
  "Fried Rice",
];

//order
List orders = [
  {
    "item_name": "Chicken Burger",
    "item_description": "Chicken Burger",
    "quantity": "2",
    "item_price": "23.90",
    "order_number": "997",
  },
  {
    "item_name": "Chicken Burger",
    "item_description": "Chicken Burger",
    "quantity": "2",
    "item_price": "23.90",
    "order_number": "998",
  }
];

List transactions = [
  {
    "code": "1",
    "amount": "10.00",
    "time": "29/01/2023 15:45",
  },
  {
    "code": "0",
    "amount": "13.00",
    "time": "29/01/2023 15:45",
  },
];
