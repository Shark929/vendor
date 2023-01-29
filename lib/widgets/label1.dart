import 'package:flutter/material.dart';

class Label1 extends StatelessWidget {
  final String label, data;
  const Label1({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )),
        Text(
          data,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
