import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Function()? onTap;
  final Icon icon;

  const StyledButton({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: OutlinedButton.icon(
          icon: icon,
          label: const Text('Upload watermark'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: onTap),
    );
  }
}
