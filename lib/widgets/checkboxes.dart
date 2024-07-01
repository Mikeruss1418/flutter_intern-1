import 'package:flutter/material.dart';

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  // bool? isLanguages = false;
  final List languages = ['Hindi', 'English', 'Nepali', 'Newari'];
  late List sLanguages;

  @override
  void initState() {
    super.initState();
    sLanguages = List.generate(4, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Languages',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Wrap(
            runSpacing: -20,
            children: List.generate(languages.length, (index) {
              return ListTile(
                leading: Checkbox(
                  value: sLanguages[index],
                  onChanged: (value) {
                    setState(() {
                      sLanguages[index] = value;
                    });
                  },
                ),
                title: Text(languages[index]),
              );
            }).toList()),
      ],
    );
  }
}

class InterestAreas extends StatefulWidget {
  const InterestAreas({super.key});

  @override
  State<InterestAreas> createState() => _InterestAreasState();
}

class _InterestAreasState extends State<InterestAreas> {
  final List interest = [
    'Sporting',
    'Gameing',
    'Cooking',
    'Reading',
    'Dancing'
  ];
  late List sInterest;

  @override
  void initState() {
    super.initState();
    sInterest = List.generate(interest.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Interested Areas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        Wrap(
          runSpacing: -22,
          children: List.generate(interest.length, (index) {
            return ListTile(
              leading: Checkbox(
                value: sInterest[index],
                onChanged: (value) {
                  setState(() {
                    sInterest[index] = value;
                  });
                },
              ),
              title: Text(interest[index]),
            );
          }).toList(),
        ),
      ],
    );
  }
}
