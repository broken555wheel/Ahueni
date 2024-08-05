import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Home'),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Overcoming',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Cocaine',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Sober Start Date:',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(100)),
              width: 290,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    'Sober Start Date:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Sober For:',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    'Sober For:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 20),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
