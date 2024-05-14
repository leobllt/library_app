import 'package:flutter/material.dart';
import 'package:library_app/widgets/debits_vertical_item.dart';


class DebitsVerticalList extends StatelessWidget {
  final List<Map<String,String>> list;
  const DebitsVerticalList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Container(
        padding: const EdgeInsets.all(8.0),
          child: list.isEmpty ? const Center(child: Text('Nenhum até o momento')) : Scrollbar(
            controller: controller,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return  DebitsVerticalItem(map: list[index]);
                },
            ),
          ),
    );
  }
}