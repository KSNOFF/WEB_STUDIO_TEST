import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';

class LocationLogic {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Geolocator geolocator = Geolocator();
  String locationString = "";
  int notificationId = 0;

  //Инициализация уведомления
  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Стартовое уведомление
  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'Геолокация',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      enableVibration: false,
      onlyAlertOnce: true,
      ongoing: true,
      autoCancel: false,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  //Функция обновления стартового уведомления
  Future<void> updateNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'Геолокация',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      enableVibration: false,
      onlyAlertOnce: true,
      ongoing: true,
      autoCancel: false,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  //Функция закрытия уведомления
  void cancelNotification() {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  //Рекурсивная функция получения местоположения
  void getCurrentLocation() async {
    Position position = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    locationString =
        'Широта: ${position.latitude}, Долгота: ${position.longitude}';
    updateNotification('Текущие координаты:', locationString);
    await Future.delayed(const Duration(seconds: 4));
    if (switchValue == true) {
      getCurrentLocation();
    } else {
      cancelNotification();
    }
  }

  //Функция запроса разрешения на использование геолокации
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      print("Location permission is denied");
    }
  }
}
