import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreditCard {
  final Color? color;
  final String? number;
  final String? ccv;
  final double? amount;

  CreditCard({
    this.color,
    this.number,
    this.ccv,
    this.amount,
  });
}

final Random random = new Random();

double doubleInRange(Random source, int start, int end) =>
    source.nextDouble() * (end - start) + start;

int _intInRange(Random source, int start, int end) =>
    start + source.nextInt(end - start);

String _getFourNumbers() => _intInRange(random, 1000, 9999).toString();

final creditCards = List.generate(
  20,
  (index) => CreditCard(
    amount: doubleInRange(random, 500, 20000),
    ccv: _getFourNumbers(),
    color: Colors.primaries[index % Colors.primaries.length],
    number:
        "${_getFourNumbers()} ${_getFourNumbers()} ${_getFourNumbers()} ${_getFourNumbers()}",
  ),
);
