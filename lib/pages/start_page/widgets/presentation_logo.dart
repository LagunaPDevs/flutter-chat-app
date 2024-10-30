import 'package:flutter/material.dart';

// external libraries
import 'package:flutter_svg/svg.dart';

class PresentationLogo extends StatelessWidget {
  final String title;
  const PresentationLogo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset('assets/illustration.svg'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
