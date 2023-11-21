import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'location_logic.dart';

//Глобальная переменная
bool switchValue = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocationLogic locationLogic = LocationLogic();
  //Вызов функций при запуске приложения
  @override
  void initState() {
    super.initState();
    locationLogic.initNotifications(); //Инициализация уведомления
    locationLogic
        .requestLocationPermission(); //Функция запроса разрешения на использование геолокации
  }

  //Функция для обновления состояния переключателя
  void _toggleSwitch(bool value) {
    setState(() {
      switchValue = value;
      if (switchValue == false) {
        locationLogic.cancelNotification();
      } else {
        locationLogic.showNotification(
            'Текущие координаты:', "Определяем местоположение....");
        locationLogic.getCurrentLocation();
      }
    });
  }

  //Функция для обновления состояния переключателя при нажатии плашки(кнопки)
  void _toggleSwitchState() {
    setState(() {
      if (switchValue == true) {
        switchValue = false;
        locationLogic.cancelNotification();
      } else {
        switchValue = true;
        locationLogic.showNotification(
            'Текущие координаты:', "Определяем местоположение....");
        locationLogic.getCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80.0, bottom: 60.0),
                child: const Text(
                  'YOUR ACCOUNT',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Druk Text Wide Cyr',
                  ),
                ),
              ),
              SizedBox(
                width: 360,
                height: 60,
                child: ElevatedButton(
                  onPressed: _toggleSwitchState,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 36, 31),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset("assets/notyfi.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ]),
                      FlutterSwitch(
                        toggleSize: 22.0,
                        padding: 6.0,
                        duration: const Duration(milliseconds: 250),
                        activeColor: Colors.orange,
                        toggleColor: const Color.fromARGB(255, 0, 0, 0),
                        inactiveToggleColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        value: switchValue,
                        onToggle: _toggleSwitch,
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
