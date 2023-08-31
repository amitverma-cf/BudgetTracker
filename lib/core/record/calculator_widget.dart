import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  String _output = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'x' ||
          buttonText == '/') {
        _operator = buttonText;
        _num1 = double.tryParse(_output) ?? 0;
        _output = '';
      } else if (buttonText == '=') {
        _num2 = double.tryParse(_output) ?? 0;
        if (_operator == '+') {
          _output = (_num1 + _num2).toString();
        } else if (_operator == '-') {
          _output = (_num1 - _num2).toString();
        } else if (_operator == 'x') {
          _output = (_num1 * _num2).toString();
        } else if (_operator == '/') {
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = 'Error';
          }
        }
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (buttonText == '<') {
        if (_output.isNotEmpty) {
          _output = _output.substring(0, _output.length - 1);
        }
      } else {
        _output += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _output.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Enter Amount",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w300),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width - 72,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0.0),
                            child: Text(
                              _output,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.end,
                              softWrap: false,
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  IconButton(
                    onPressed: () {
                      _handleButtonPress("<");
                    },
                    padding: const EdgeInsets.all(16),
                    icon: const Icon(Icons.backspace_outlined),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisExtent: 70),
                itemCount: 16,
                itemBuilder: (context, index) {
                  List<String> buttons = [
                    '/',
                    '7',
                    '8',
                    '9',
                    'x',
                    '4',
                    '5',
                    '6',
                    '-',
                    '1',
                    '2',
                    '3',
                    '+',
                    '0',
                    ".",
                    '=',
                  ];
                  return InkWell(
                    onTap: () {
                      _handleButtonPress(buttons[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: (["/", "x", "-", "+", "="]
                                    .contains(buttons[index]))
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(32)),
                        child: Text(
                          buttons[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
