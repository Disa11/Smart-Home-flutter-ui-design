import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/core.dart';
import 'package:flutter_samples_main/samples/smart_home/features/smart_room/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_common/ui_common.dart';

class RoomDetailsPageView extends StatelessWidget {
  const RoomDetailsPageView({
    required this.animation,
    required this.room,
    super.key,
  });

  final Animation<double> animation;
  final SmartRoom room;

  Animation<double> get _interval1 => CurvedAnimation(
    parent: animation,
    curve: const Interval(0.4, 1, curve: Curves.easeIn),
  );

  Animation<double> get _interval2 => CurvedAnimation(
    parent: animation,
    curve: const Interval(0.6, 1, curve: Curves.easeIn),
  );

  Animation<double> get _interval3 => CurvedAnimation(
    parent: animation,
    curve: const Interval(0.8, 1, curve: Curves.easeIn),
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            SlideTransition(
              position: Tween(
                begin: const Offset(-1, 1),
                end: Offset.zero,
              ).animate(animation),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: 8.edgeInsetsA.copyWith(bottom: 0),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_left),
                  label: const Text('BACK'),
                ),
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: 20.edgeInsetsA.copyWith(top: 12.h),
                  children: [
                    SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 2),
                        end: Offset.zero,
                      ).animate(_interval1),
                      child: FadeTransition(
                        opacity: _interval1,
                        child: Row(
                          children: [
                            Expanded(
                              child: LightsAndTimerSwitchers(room: room),
                            ),
                            width20,
                            Expanded(child: MusicSwitchers(room: room)),
                          ],
                        ),
                      ),
                    ),
                    height20,
                    SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 2),
                        end: Offset.zero,
                      ).animate(_interval2),
                      child: FadeTransition(
                        opacity: _interval2,
                        child: LightIntensitySliderCard(room: room),
                      ),
                    ),
                    height20,
                    SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 2),
                        end: Offset.zero,
                      ).animate(_interval1),
                      child: FadeTransition(
                        opacity: _interval3,
                        child: AirConditionerControlsCard(room: room),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
