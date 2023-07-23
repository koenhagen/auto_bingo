import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Backseat Bingo',
      home: MyHomePage(title: 'Backseat Bingo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? seed;
  List<String> cards = [
    'Tractor',
    "McDonald's sign",
    "Country flag",
    'Road construction',
    "Bridge",
    'Tunnel',
    'Stopped car',
    'Petrol station',
    "Car with spoiler",
    'Cows',
    'Sheep',
    'Traffic light',
    'Police car',
    'Dog in car',
    'Wind turbine',
    'Train',
    'Caravan',
    'Car with bike rack',
    'Hitchhiker',
    'Bus',
    'Truck without container',
    'Tank Truck',
    'Roundabout',
    'Motorhome',
    'Horse trailer',
    'Billboard',
    'Farmer selling produce',
    'Traffic jam',
    "Stork's nest",
    'Yellow car',
    'Graffiti',
    'Car with trailer',
    'Car with roof box',
    'Car carrier',
    'Car with open trunk',
    'Wild animal crossing sign',
    'Speeding car',
    'Car dealership',
    'Excavator',
    'Motorcycle',
    'Bulldozer',
    'Airplane',
    'Helicopter',
    'Taxi',
    'Church',
    'Windmill',
    'Bumper sticker',
    'River',
    'Lake',
    'Car with missing wheel cover',
    'Car with dirty license plate',
    'Car with broken tail light',
    'Boat',
    'Jeep',
    'Smart car',
    'Hot air balloon',
    'Ferrari',
    'Tesla',
    'Dump truck',
    'Tower crane',
    'Volkswagen camper van',
    'Car with roof tent',
    'Ambulance',
    'Fire truck',
    'Potato field',
    'Corn field',
    'Wheat field',
    'Sunflower field',
    'Hay bale',
    'Windsock',
    'Train crossing',
    'Hotel',
    'Factory',
    'Red car',
    'Hawk',
    'turnpike',
    'Barn',
    'Traffic cone',
    'Water tower',
    'Car with canoe',
    'Flock of birds',
    'Speed enforcement camera',
    'Convertible',
    'Animal viaduct',
    'Military vehicle',
    '"Welcome to..." sign',
    'Car with visible spare tire',
    'Vintage car',
    'Statue',
    'Someone eating',
    'Detour sign',
    'The letter "Z"',
    'Caution sign',
    'Duct-taped car part',
    'Tow truck',
    'Person wearing sunglasses',
    'Person wearing a hat',
    'Person on their phone',
    'For sale sign',
    'The number "7"',
    'Stop sign',
    'Mail truck',
    'Shopping center',
    'Antenna topper',
    'Bent guard rail',
    'Wayside shrine',
    'Car with a dent',
    'Pedestrian crossing',
    'Person smoking',
    'Pickup truck',
    'Overhead power line',
    'Rainbow',
    'Tipped-over sign',
    'Pothole',
    'Scarecrow',
    'Advisory speed sign',
  ];
  List<String> activeCards = [];
  List<String> pressedCards = ['Free Space'];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late ConfettiController _confettiController;

  @override
  void initState() {
    _getCards();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
  }

  Future<void> _getCards() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      seed = prefs.getInt('seed');
    });
    seed == null ? _shuffleCards() : _setCards();
  }

  Future<void> _shuffleCards() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      seed = Random().nextInt(100000);
      cards.shuffle(Random(seed));
      activeCards = cards.take(24).toList();
      activeCards.insert(12, 'Free Space');
    });
    prefs.setInt('seed', seed!);
  }

  Future<void> _setCards() async {
    setState(() {
      cards.shuffle(Random(seed));
      activeCards = cards.take(24).toList();
      activeCards.insert(12, 'Free Space');
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _checkForBingo() {

    if (pressedCards.length >= 25) {
      _confettiController.play();
    }

    List<String> previousPressedCards = List.from(pressedCards);
    if (previousPressedCards.isEmpty) {
      return;
    }
    previousPressedCards.removeLast();
    if ((([activeCards[0], activeCards[1], activeCards[2], activeCards[3], activeCards[4]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[5], activeCards[6], activeCards[7], activeCards[8], activeCards[9]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[10], activeCards[11], activeCards[12], activeCards[13], activeCards[14]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[15], activeCards[16], activeCards[17], activeCards[18], activeCards[19]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[20], activeCards[21], activeCards[22], activeCards[23], activeCards[24]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[0], activeCards[5], activeCards[10], activeCards[15], activeCards[20]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[1], activeCards[6], activeCards[11], activeCards[16], activeCards[21]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[2], activeCards[7], activeCards[12], activeCards[17], activeCards[22]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[3], activeCards[8], activeCards[13], activeCards[18], activeCards[23]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[4], activeCards[9], activeCards[14], activeCards[19], activeCards[24]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[24], activeCards[0], activeCards[6], activeCards[12], activeCards[18]].every((item) => previousPressedCards.contains(item)))
        || ([activeCards[4], activeCards[8], activeCards[12], activeCards[16], activeCards[20]].every((item) => previousPressedCards.contains(item)))
    )) {
      return;
    }

    if (([activeCards[0], activeCards[1], activeCards[2], activeCards[3], activeCards[4]].every((item) => pressedCards.contains(item)))
        || ([activeCards[5], activeCards[6], activeCards[7], activeCards[8], activeCards[9]].every((item) => pressedCards.contains(item)))
        || ([activeCards[10], activeCards[11], activeCards[12], activeCards[13], activeCards[14]].every((item) => pressedCards.contains(item)))
        || ([activeCards[15], activeCards[16], activeCards[17], activeCards[18], activeCards[19]].every((item) => pressedCards.contains(item)))
        || ([activeCards[20], activeCards[21], activeCards[22], activeCards[23], activeCards[24]].every((item) => pressedCards.contains(item)))
        || ([activeCards[0], activeCards[5], activeCards[10], activeCards[15], activeCards[20]].every((item) => pressedCards.contains(item)))
        || ([activeCards[1], activeCards[6], activeCards[11], activeCards[16], activeCards[21]].every((item) => pressedCards.contains(item)))
        || ([activeCards[2], activeCards[7], activeCards[12], activeCards[17], activeCards[22]].every((item) => pressedCards.contains(item)))
        || ([activeCards[3], activeCards[8], activeCards[13], activeCards[18], activeCards[23]].every((item) => pressedCards.contains(item)))
        || ([activeCards[4], activeCards[9], activeCards[14], activeCards[19], activeCards[24]].every((item) => pressedCards.contains(item)))
        || ([activeCards[24], activeCards[0], activeCards[6], activeCards[12], activeCards[18]].every((item) => pressedCards.contains(item)))
        || ([activeCards[4], activeCards[8], activeCards[12], activeCards[16], activeCards[20]].every((item) => pressedCards.contains(item)))
    ) {
      _confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _shuffleCards();
              });
            },
            child: const Text(
              'Refresh',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
              child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Colors.grey[500]!,
                Colors.black,
              ], radius: 0.85, focal: Alignment.center),
            ),
            padding: const EdgeInsets.all(2),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 5,
              children: activeCards
                  .map((card) => InkWell(
                        onTap: () {
                          setState(() {
                            if (pressedCards.contains(card)) {
                              pressedCards.remove(card);
                            } else {
                              pressedCards.add(card);
                            }
                          });
                          _checkForBingo();
                        },
                        child: Container(
                            color: Colors.white,
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.check,
                                    color: pressedCards.contains(card)
                                        ? Colors.green
                                        : Colors.transparent,
                                  ),
                                ),
                                Center(
                                    child: Text(card,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: pressedCards.contains(card)
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              ],
                            )),
                      ))
                  .toList(),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              emissionFrequency: 0.02,
              numberOfParticles: 50,
              maxBlastForce: 200,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
