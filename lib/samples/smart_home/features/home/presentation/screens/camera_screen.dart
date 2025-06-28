import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/core.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/sample.dart';
import 'package:flutter_samples_main/samples/smart_home/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/presentation/widgets/sh_drawer.dart';
import 'package:ui_common/ui_common.dart';
import 'package:flutter_samples_main/samples/smart_home/core/routes/routes.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final PageController controller = PageController(viewportFraction: .8);
  final ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  @override
  void initState() {
    controller.addListener(pageListener);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeListener(pageListener)
      ..dispose();
    super.dispose();
  }

  void pageListener() {
    pageNotifier.value = controller.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LightedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const SHAppBar(),
        drawer: const SHDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              height32,
              Text('Bedroom camera', style: context.bodyLarge),
              height16,
              Expanded(
                child: Stack(
                  //fit: StackFit.expand,
                  children: [
                    Mjpeg(
                      stream: 'http://192.168.0.19/800x600.mjpeg',
                      isLive: true,
                      error: (context, error, stack) {
                        return Center(
                          child: Text('Error loading MJPEG stream'),
                        );
                      },
                    ),

                    Positioned.fill(
                      top: null,
                      child: Column(
                        children: [
                          _PageIndicators(
                            roomSelectorNotifier: roomSelectorNotifier,
                            pageNotifier: pageNotifier,
                          ),
                          _BottomNavigationBar(
                            roomSelectorNotifier: roomSelectorNotifier,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageIndicators extends StatelessWidget {
  const _PageIndicators({
    required this.roomSelectorNotifier,
    required this.pageNotifier,
  });

  final ValueNotifier<int> roomSelectorNotifier;
  final ValueNotifier<double> pageNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: roomSelectorNotifier,
      builder:
          (_, value, child) => AnimatedOpacity(
            opacity: value != -1 ? 0 : 1,
            duration:
                value != -1
                    ? const Duration(milliseconds: 1)
                    : const Duration(milliseconds: 400),
            child: child,
          ),
      child: ValueListenableBuilder<double>(
        valueListenable: pageNotifier,
        builder:
            (_, value, __) => Center(
              child: PageViewIndicators(
                length: SmartRoom.fakeValues.length,
                pageIndex: value,
              ),
            ),
      ),
    );
  }
}

/// A bottom navigation bar
class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({required this.roomSelectorNotifier});

  final ValueNotifier<int> roomSelectorNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.edgeInsetsA,
      child: ValueListenableBuilder<int>(
        valueListenable: roomSelectorNotifier,
        builder:
            (_, value, child) => AnimatedOpacity(
              duration: kThemeAnimationDuration,
              opacity: value != -1 ? 0 : 1,
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                transform: Matrix4.translationValues(
                  0,
                  value != -1 ? -30.0 : 0.0,
                  0,
                ),
                child: child,
              ),
            ),
        child: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, Sample.smartHome.route);
            } else if (index == 1) {
              // manejar la navegación
            } else if (index == 2) {
              // Manejar la navegación a la pantalla camera
              Navigator.pushNamed(context, Sample.CameraPage.route);
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: 8.edgeInsetsA,
                child: const Icon(SHIcons.home),
              ),
              label: 'MAIN',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: 8.edgeInsetsA,
                child: const Icon(SHIcons.settings),
              ),
              label: 'SETTINGS',
            ),
            //Nuevo ítem para la cámara
            BottomNavigationBarItem(
              icon: Padding(
                padding: 8.edgeInsetsA,
                child: const Icon(Icons.camera_alt),
              ),
              label: 'CAMERA',
            ),
          ],
        ),
      ),
    );
  }
}
