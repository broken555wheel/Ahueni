import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_button.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 680,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
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
            height: 10,
          ),
          Center(
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
              width: 290,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    '5th August 2024',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 680,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Sober For:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
              child: Center(
                widthFactor: 1,
                child: Text(
                  '1 Day',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(buttonText: 'Reset', onTap: () {}),
              MyButton(buttonText: 'My Tasks', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
