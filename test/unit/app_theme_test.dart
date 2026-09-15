import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/core/constants/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('should have light theme defined', () {
      expect(AppTheme.lightTheme, isNotNull);
      expect(AppTheme.lightTheme.brightness, Brightness.light);
    });

    test('should have dark theme defined', () {
      expect(AppTheme.darkTheme, isNotNull);
      expect(AppTheme.darkTheme.brightness, Brightness.dark);
    });

    test('light theme should have primary color', () {
      expect(AppTheme.lightTheme.primaryColor, isNotNull);
    });

    test('dark theme should have primary color', () {
      expect(AppTheme.darkTheme.primaryColor, isNotNull);
    });

    test('light theme should have scaffold background color', () {
      expect(AppTheme.lightTheme.scaffoldBackgroundColor, isNotNull);
    });

    test('dark theme should have scaffold background color', () {
      expect(AppTheme.darkTheme.scaffoldBackgroundColor, isNotNull);
    });

    test('light theme should have card theme', () {
      expect(AppTheme.lightTheme.cardTheme, isNotNull);
    });

    test('dark theme should have card theme', () {
      expect(AppTheme.darkTheme.cardTheme, isNotNull);
    });

    test('light theme should have text theme', () {
      expect(AppTheme.lightTheme.textTheme, isNotNull);
    });

    test('dark theme should have text theme', () {
      expect(AppTheme.darkTheme.textTheme, isNotNull);
    });
  });
}