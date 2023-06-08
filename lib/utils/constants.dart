import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFe9e9e9);
const storageBucketPath='gs://accesfy-882e6.appspot.com';

const List<String> list = <String>['Male', 'Female'];

const defaultPadding = 16.0;

const serverToken="AAAACfUoj6w:APA91bG8CBaXLESOehpvpFc6et30knT0ha9OrkKe3UK2FHQ3t5c8MeJdrpx9dRk8JCvMFuSEMO3oC5vDBMfzWQD955lRV63_dR308LHXavwLlkAUKYzuIcKX6_v_LYWKcttuGWjc1iCp";

final dfampm = new DateFormat('dd/MM/yyyy HH:mm');


const profileImage="https://firebasestorage.googleapis.com/v0/b/chat-app-2ea88.appspot.com/o/profile.png?alt=media&token=4ce57725-0113-48d9-a6f7-cea8f4e9f076";


const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));