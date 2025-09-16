import 'package:flutter/material.dart';

Widget dottedDivider(length) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      length,
      (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Container(
          width: 2,
          height: 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
