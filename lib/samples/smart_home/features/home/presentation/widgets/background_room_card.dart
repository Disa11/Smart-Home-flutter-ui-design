import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_common/ui_common.dart';

class BackgroundRoomCard extends StatelessWidget {
  const BackgroundRoomCard({
    required this.room,
    required this.translation,
    super.key,
  });

  final SmartRoom room;
  final double translation;

  List<Widget> _buildRoomInfo() {
    final info = <Widget>[];

    void addRow(IconData icon, String label, String value) {
      info.add(_RoomInfoRow(icon: Icon(icon), label: Text(label), data: value));
      info.add(height4);
    }

    switch (room.id) {
      case '1':
        addRow(
          SHIcons.thermostat,
          'Temperature',
          '${room.temperature.toStringAsFixed(2)}°C',
        );
        addRow(
          SHIcons.waterDrop,
          'Air Humidity',
          '${room.airHumidity.toStringAsFixed(2)}%',
        );
        addRow(
          SHIcons.voltage,
          'Voltage',
          '${room.voltage.toStringAsFixed(2)}V',
        );
        break;
      case '2':
      case '5':
        addRow(
          SHIcons.waterDrop,
          'Air Humidity',
          '${room.airHumidity.toStringAsFixed(2)}%',
        );
        break;
      case '3':
        addRow(
          SHIcons.thermostat,
          'Temperature',
          '${(room.temperature + 0.5).toStringAsFixed(2)}°C',
        );
        addRow(
          SHIcons.waterDrop,
          'Air Humidity',
          '${room.airHumidity.toStringAsFixed(2)}%',
        );
        addRow(
          SHIcons.monoxide,
          'Air Monoxide',
          '${room.monoxido.toStringAsFixed(4)}%',
        );
        break;
      case '4':
        addRow(
          SHIcons.thermostat,
          'Temperature',
          '${(room.temperature - 0.35).toStringAsFixed(2)}°C',
        );
        addRow(
          SHIcons.waterDrop,
          'Air Humidity',
          '${(room.airHumidity + 0.1).toStringAsFixed(2)}%',
        );
        break;
    }

    if (info.isNotEmpty) {
      info.removeLast(); // Elimina el último height4 sobrante
    }
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 80.h * translation),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SHColors.cardColor,
          borderRadius: 12.borderRadiusA,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(-7, 7),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._buildRoomInfo(),
            height12,
            const SHDivider(),
            Padding(
              padding: EdgeInsets.all(12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _DeviceIconSwitcher(
                    onTap: (value) {
                      // Implementa la función aquí
                    },
                    icon: const Icon(SHIcons.lightBulbOutline),
                    label: const Text('Lights'),
                    value: room.lights.isOn,
                  ),
                  _DeviceIconSwitcher(
                    onTap: (value) {},
                    icon: const Icon(SHIcons.fan),
                    label: const Text('Air-conditioning'),
                    value: room.airCondition.isOn,
                  ),
                  _DeviceIconSwitcher(
                    onTap: (value) {},
                    icon: const Icon(SHIcons.music),
                    label: const Text('Music'),
                    value: room.musicInfo.isOn,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceIconSwitcher extends StatelessWidget {
  const _DeviceIconSwitcher({
    required this.onTap,
    required this.label,
    required this.icon,
    required this.value,
  });

  final Text label;
  final Icon icon;
  final bool value;
  final ValueChanged<bool> onTap;

  @override
  Widget build(BuildContext context) {
    final color = value ? SHColors.selectedColor : SHColors.textColor;
    //print(value);
    return InkWell(
      onTap: () => onTap(!value),
      child: Column(
        children: [
          IconTheme(
            data: IconThemeData(color: color, size: 24.sp),
            child: icon,
          ),
          height4,
          DefaultTextStyle(
            style: context.bodySmall.copyWith(color: color),
            child: label,
          ),
          Text(
            value ? 'ON' : 'OFF',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomInfoRow extends StatelessWidget {
  const _RoomInfoRow({
    required this.icon,
    required this.label,
    required this.data,
  });

  final Icon icon;
  final Text label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        width32,
        IconTheme(data: context.iconTheme.copyWith(size: 18.sp), child: icon),
        width4,
        Expanded(
          child: DefaultTextStyle(
            style: context.bodySmall.copyWith(
              color: data == null ? context.textColor.withOpacity(.6) : null,
            ),
            child: label,
          ),
        ),
        if (data != null)
          Text(
            data!,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          )
        else
          Row(
            children: [
              const BlueLightDot(),
              width4,
              Text(
                'OFF',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp,
                  color: SHColors.textColor.withOpacity(.6),
                ),
              ),
            ],
          ),
        width32,
      ],
    );
  }
}
