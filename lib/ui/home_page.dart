import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:tccapp/dto/AccountDto.dart';
import 'package:tccapp/entity/BeaconEntity.dart';
import 'package:tccapp/ui/widget/MenuTCC.dart';
import 'package:tccapp/utils/parameters.dart';

final FlutterTts flutterTts = FlutterTts();
final Parameters parameters = Parameters();

class HomePage extends StatefulWidget {
  final AccountDto accountDto;

  HomePage({@required this.accountDto});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: MenuTCC(context, accountDto: widget.accountDto)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/beacons.gif'),
          )
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    initializeTts();
    initializeBeacons();

    var scheduler = NeatPeriodicTaskScheduler(
      interval: Duration(seconds: 5000),
      name: 'scan-beacon',
      timeout: Duration(minutes: 10),
      task: () {
        Future.delayed(const Duration(seconds: 1), () {
          playTts("quarto");
        });

        Future.delayed(const Duration(seconds: 20), () {
          playTts("cozinha");
        });

        Future.delayed(const Duration(seconds: 30), () {
          playTts("quarto");
        });
      },
      minCycle: Duration(seconds: 5),
    );

    scheduler.start();
  }

  Future<void> initializeBeacons() async {
    try {
      // if you want to manage manual checking about the required permissions
      await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch(e) {
      // library failed to initialize, check code and message
    }
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> playTts(String texto) async {
    await flutterTts.speak(texto);
  }

  Future<void> _scanBeacons() async {
    print('scanBeacons');
    final regions = await listRegions();

    flutterBeacon.monitoring(regions).listen((MonitoringResult result) async {
      var beacon = await getBeacon(result.region.identifier);

      playTts(beacon.message);
    });
  }

  Future<List<Region>> listRegions() async {
    Map<String, String> header = Map();
    header['Content-Type'] = 'application/json';

    http.Response response = await http.get('${parameters.basePath}/tcc/v1/beacon', headers: header);

    if (response.statusCode == 200) {
      Iterable beacons = jsonDecode(response.body);

      var regions = List<Region>();

      for (var i = 0; i < beacons.length; i++) {
        var region = Region(identifier: beacons.elementAt(i)['identity'].toString());

        regions.add(region);
      }

      return regions;
    }

    return null;
  }

  Future<BeaconEntity> getBeacon(String identifier) async {
    Map<String, String> header = Map();
    header['Content-Type'] = 'application/json';

    http.Response response = await http.get('${parameters.basePath}/tcc/v1/beacon/${identifier}', headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> beacon = jsonDecode(response.body);

      var beaconEntity = BeaconEntity(beacon['id'], beacon['identity'], beacon['message'], beacon['range']);

      return beaconEntity;
    }

    return null;
  }
}
