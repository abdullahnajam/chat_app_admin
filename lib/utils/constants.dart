import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFe9e9e9);
const storageBucketPath='gs://accesfy-882e6.appspot.com';


const defaultPadding = 16.0;

const serverToken="AAAACfUoj6w:APA91bG8CBaXLESOehpvpFc6et30knT0ha9OrkKe3UK2FHQ3t5c8MeJdrpx9dRk8JCvMFuSEMO3oC5vDBMfzWQD955lRV63_dR308LHXavwLlkAUKYzuIcKX6_v_LYWKcttuGWjc1iCp";



const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));