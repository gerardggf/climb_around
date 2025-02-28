import 'package:flutter/material.dart';

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({
    super.key,
    required this.title,
    required this.values,
  });
  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              ...values.map((value) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
