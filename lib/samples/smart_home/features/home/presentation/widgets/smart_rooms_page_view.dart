import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/smart_room.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/presentation/widgets/room_card.dart';
import 'package:flutter_samples_main/samples/smart_home/features/smart_room/presentation/screens/room_detail_screen.dart';
import 'package:ui_common/ui_common.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/firebase_service.dart';

class SmartRoomsPageView extends StatefulWidget {
  const SmartRoomsPageView({
    required this.pageNotifier,
    required this.controller,
    required this.roomSelectorNotifier,
    super.key,
  });

  final ValueNotifier<double> pageNotifier;
  final ValueNotifier<int> roomSelectorNotifier;
  final PageController controller;

  @override
  State<SmartRoomsPageView> createState() => _SmartRoomsPageViewState();
}

class _SmartRoomsPageViewState extends State<SmartRoomsPageView> {
  Map<String, dynamic> _data = {}; // Datos recibidos de Firebase como un Map
  FirebaseService firebaseService =
      FirebaseService(); // Usar el servicio FirebaseService/ Estado del relé

  /* @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  // Inicializar Firebase y escuchar los cambios en la ruta 'Home/stream'
  Future<void> _initializeFirebase() async {
    await firebaseService.initializeFirebase(); // Inicializamos Firebase

    String sensorPath = 'Home/stream/';
    firebaseService.listenStatus(sensorPath, (status) {
      setState(() {
        // Actualizamos los datos recibidos como un Map
        _data = Map<String, dynamic>.from(status);
      });
      print("Datos recibidos de Firebase: $_data");
    });
  }*/

  StreamSubscription<DatabaseEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await firebaseService.initializeFirebase();
    String sensorPath = 'Home/stream/';
    _subscription = firebaseService.listenStatus(sensorPath, (status) {
      if (status is Map) {
        setState(() {
          _data = Map<String, dynamic>.from(status);
        });
      } else {
        print('Datos no válidos recibidos: $status');
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  double _getOffsetX(double percent) => percent.isNegative ? 30.0 : -30.0;

  Matrix4 _getOutTranslate(double percent, int selected, int index) {
    final x = selected != index && selected != -1 ? _getOffsetX(percent) : 0.0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.pageNotifier,
      builder: (_, page, __) {
        return ValueListenableBuilder<int>(
          valueListenable: widget.roomSelectorNotifier,
          builder: (_, selected, ___) {
            return PageView.builder(
              controller: widget.controller,
              physics:
                  selected != -1
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              itemCount: SmartRoom.fakeValues.length,
              itemBuilder: (__, index) {
                final percent = page - index;
                final isSelected = selected == index;

                //Obtencion de los valores de la habitacion
                final room = SmartRoom.fakeValues[index];
                final roomUpdate = room.copyWith(
                  id: room.id,
                  name: room.name,
                  temperature:
                      (_data['temperature'] as num?)?.toDouble() ??
                      room.temperature,
                  airHumidity:
                      (_data['humidity'] as num?)?.toDouble() ??
                      room.airHumidity,
                  monoxido:
                      (_data['monoxide_sensor'] as num?)?.toDouble() ??
                      room.monoxido,
                  voltage:
                      (_data['voltage_sensor'] as num?)?.toDouble() ??
                      room.voltage,
                  imageUrl: room.imageUrl,
                );

                return AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  curve: Curves.fastOutSlowIn,
                  transform: _getOutTranslate(percent, selected, index),
                  padding: 16.edgeInsetsH,
                  child: RoomCard(
                    percent: percent,
                    expand: isSelected,
                    room: roomUpdate,
                    onSwipeUp: () => widget.roomSelectorNotifier.value = index,
                    onSwipeDown: () => widget.roomSelectorNotifier.value = -1,
                    onTap: () async {
                      if (isSelected) {
                        await Navigator.push(
                          context,
                          PageRouteBuilder<void>(
                            transitionDuration: const Duration(
                              milliseconds: 800,
                            ),
                            reverseTransitionDuration: const Duration(
                              milliseconds: 800,
                            ),
                            pageBuilder:
                                (_, animation, __) => FadeTransition(
                                  opacity: animation,
                                  child: RoomDetailScreen(room: room),
                                ),
                          ),
                        );
                        widget.roomSelectorNotifier.value = -1;
                      }
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
