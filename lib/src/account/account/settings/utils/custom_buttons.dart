import 'package:flutter/material.dart';
import 'package:pastry/src/chat/detail/view/rooms.dart';

class EditAccountDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditAccountDetailsButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text('Edit Account Details'),
    );
  }
}

class EditAddPaymentInfoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditAddPaymentInfoButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text('Edit/Add Payment Information'),
    );
  }
}

class ViewMessagesButton extends StatelessWidget {
  // final VoidCallback onPressed;

  const ViewMessagesButton({
    Key? key,
    // required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const RoomsPage())));
      },
      child: const Text('Messages'),
    );
  }
}

class ContactSupportButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContactSupportButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text('Contact Support'),
    );
  }
}
