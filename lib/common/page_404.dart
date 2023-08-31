import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myfinance/common/routes.dart';

class ErrorScreen extends StatelessWidget {
  final String e;
  const ErrorScreen({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(56.0),
              child: Text(e),
            ),
            const SizedBox(height: 24.0),
            FilledButton(
              onPressed: () => context.goNamed(AppRoutesConstants.main),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
