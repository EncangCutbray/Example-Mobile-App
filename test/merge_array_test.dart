import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  group('Test Merge Array :', () {
    test('First Array', () {
      int listGenerate = 4;
      List hello1  = List.generate(listGenerate, (index) => 'Hello 1');
      List hello2  = List.generate(listGenerate, (index) => 'Hello 2');
      List hello3 = [...hello1, ...hello2];
      debugPrint(hello3.toString());
      expect(hello3.length > listGenerate, true);
      expect(hello3.length, listGenerate * 2);

    });
  });
}