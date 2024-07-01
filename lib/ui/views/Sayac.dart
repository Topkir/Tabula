import 'package:flutter/material.dart';

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({super.key});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
      setState(() {
      });
    });
    //controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircularProgressIndicator(
            value: controller.value,
          ),
          Switch(
            value: determinate,
            onChanged: (bool value) {
              setState(() {
                determinate = value;
                if (determinate) {
                  controller.stop();
                } else {
                  controller
                    ..forward(from: controller.value)
                    ..repeat();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
