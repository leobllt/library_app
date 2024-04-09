import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String headTitle;
  const SectionHeading({super.key, required this.headTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        const Padding(padding: EdgeInsets.all(8)),
        Text(
          headTitle,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 18,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}