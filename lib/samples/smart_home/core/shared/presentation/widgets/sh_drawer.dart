import 'package:flutter/material.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/domain/entities/sample.dart';
import 'package:flutter_samples_main/samples/smart_home/core/shared/service/auth_service.dart';
import 'package:flutter_samples_main/samples/smart_home/core/theme/sh_colors.dart';
import 'package:flutter_samples_main/samples/smart_home/core/theme/sh_icons.dart';

class SHDrawer extends StatelessWidget {
  const SHDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: SHColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const SHDrawerHeader(),
            const SizedBox(height: 24),
            SHDrawerItem(
              icon: SHIcons.settings,
              title: 'Settings',
              onTap: () => Navigator.pushNamed(context, Sample.smartHome.route),
            ),
            SHDrawerItem(
              icon: SHIcons.help,
              title: 'Help',
              onTap: () => Navigator.pushNamed(context, Sample.smartHome.route),
            ),
            SHDrawerItem(
              icon: SHIcons.logout,
              title: 'Logout',
              onTap: () => AuthService().signout(context: context),
            ),
          ],
        ),
      ),
    );
  }
}

class SHDrawerHeader extends StatelessWidget {
  const SHDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://previews.123rf.com/images/aprillrain/aprillrain2212/aprillrain221200638/196354278-imagen-de-caricatura-de-un-astronauta-sentado-en-una-luna-ilustraci%C3%B3n-de-alta-calidad.jpg',
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Nombre de Usuario',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: SHColors.textColor),
          ),
        ],
      ),
    );
  }
}

class SHDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SHDrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: SHColors.textColor),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: SHColors.textColor),
      ),
      onTap: onTap,
      hoverColor: SHColors.cardColor.withOpacity(0.2),
      splashColor: SHColors.cardColor.withOpacity(0.2),
    );
  }
}
