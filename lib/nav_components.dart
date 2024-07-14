import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed,
    required this.textColor,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: textColor, // Use the provided textColor
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: textColor, // Use the provided textColor
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
