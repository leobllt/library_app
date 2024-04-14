import 'package:flutter/material.dart';


// Classe que cria um título grande (header) e uma linha horizontal
class SectionHeading extends StatelessWidget {
  final String headTitle;
  final IconData icondata;
  const SectionHeading({super.key, required this.headTitle, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        const Padding(padding: EdgeInsets.all(8)),
        Icon(icondata),
        const Padding(padding: EdgeInsets.all(8)),
        Text(
          headTitle,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 20,
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