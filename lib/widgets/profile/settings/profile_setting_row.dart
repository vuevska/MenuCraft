import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ProfileSettingRow extends StatefulWidget {
  const ProfileSettingRow(
      {super.key,
      required this.title,
      this.logout = false,
      required this.onTap});

  final bool logout;
  final String title;
  final Function onTap;

  @override
  State<ProfileSettingRow> createState() => _ProfileSettingRowState();
}

class _ProfileSettingRowState extends State<ProfileSettingRow> {
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      from: 10,
      duration: const Duration(milliseconds: 500),
      child: TextButton(
        onPressed: () {
          widget.onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromRGBO(92, 86, 103, 1.0);
              }
              return null; // Use the component's default.
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  style: TextStyle(
                      color: widget.logout ? Colors.red : Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
              Icon(
                widget.logout ? Icons.logout : Icons.arrow_forward_ios,
                color: widget.logout ? Colors.red : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
