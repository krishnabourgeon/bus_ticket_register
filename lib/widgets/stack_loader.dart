import 'package:flutter/material.dart';

import 'package:bus_ticket_register/common/extensions.dart';

class StackLoader extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  const StackLoader({
    Key? key,
    required this.child,
    this.inAsyncCall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        (inAsyncCall
                ? const Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                            dismissible: false, color: Colors.white),
                      ),
                      Center(child: CircularProgressIndicator())
                    ],
                  )
                : const SizedBox())
            .animatedSwitch()
      ],
    );
  }
}
