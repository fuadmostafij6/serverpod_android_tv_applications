

import 'package:flutter/material.dart';
class Tv extends StatefulWidget {
  const Tv({super.key});

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('TV Shows'),
      // ),
      body: Center(
        child: Text(
          'TV Shows Page',
        ),
      ),
    );
  }
}
