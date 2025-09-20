import 'package:bankio/contacts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
              padding: const EdgeInsets.all(16),
              child: true
                  ? null
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            'YaYa',
                            style: GoogleFonts.urbanist(
                              fontSize: 26,
                              letterSpacing: 0.0,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text('Ya te cayo? YaYa!',
                              style: GoogleFonts.manrope(fontSize: 16)),
                        ])),
          actions: true ? null : [
            Row(children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined)),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.person_rounded)),
            ]),
          ],
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(child: SizedBox()),
                  const Text('YaYa'),
                  const Text('Ya te cayo'),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Recibir'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('Recibir'),
                      ],
                    ),
                  ),
                  Text('Transferencias P2P instantaneas'),
                  Text('Powered by Interledger Open Payment'),
                  /*QrImageView(
                    data: 'https://ilp.interledger-test.dev/enterprise',
                    version: QrVersions.auto,
                    size: 150.0,
                    // dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
                    // gapless: false,
                    // eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
                  ),*/
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ));
  }
}
