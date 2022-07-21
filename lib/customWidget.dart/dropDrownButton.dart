import 'package:flutter/material.dart';

class DropdownButtons extends StatefulWidget {
  const DropdownButtons({Key? key}) : super(key: key);

  @override
  State<DropdownButtons> createState() => _DropdownButtonsState();
}

class _DropdownButtonsState extends State<DropdownButtons> {
  bool dropdown = true;

  OverlayEntry createfloatingdropdown() {
    return OverlayEntry(builder: (context) {
      return Column(
        children: [
          Container(
            height: 200,
            color: Colors.brown,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      dropdown = !dropdown;
                      print(dropdown);
                      if (dropdown == true) {
                        Overlay.of(context)!.insert(createfloatingdropdown());
                      } else {
                        createfloatingdropdown().remove();
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                  )),
              color: Colors.blue,
              height: 60,
              width: 380,
            ),
          )
        ],
      ),
    );
  }
}
