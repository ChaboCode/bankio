import 'package:bankio/send.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola, Saúl!',
                      style: GoogleFonts.urbanist(
                        fontSize: 26,
                        letterSpacing: 0.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Bienvenido a YaYa',
                        style: GoogleFonts.manrope(fontSize: 16)),
                  ])),
          actions: [
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
          toolbarHeight: 120,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Card.filled(
                elevation: 4,
                color: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 0, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saldo disponible',
                            style: GoogleFonts.manrope(
                                color: Colors.white, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: Text(
                              '\$47,000.00',
                              style: GoogleFonts.urbanist(
                                  color: Colors.white, fontSize: 28),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 0),
                            child: Text(
                              'Conectado desde Interledger',
                              style: GoogleFonts.manrope(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Cuenta corriente',
                            style: GoogleFonts.manrope(
                                color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            '**** 4562',
                            style: GoogleFonts.manrope(
                                color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            'En línea',
                            style: GoogleFonts.manrope(
                                color: Colors.green, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 72,
                          width: 72,
                          child: IconButton.filled(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Scanner())
                              );
                            },
                            icon: const Icon(
                              Icons.send_sharp,
                              color: Color(0xFF8AFFE8),
                              size: 32,
                            ),
                            // color: Colors.black,
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        Text('Transferir')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 72,
                          height: 72,
                          child: IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.request_page,
                              size: 32,
                            ),
                            color: const Color(0xFFD6EE50),
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        Text('Movimientos')
                      ],
                    ),
                  ),
                ],
              ),
              QrImageView(
                data: 'https://ilp.interledger-test.dev/pingadeburra',
                version: QrVersions.auto,
                size: 150.0,
                // dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
                // gapless: false,
                // eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
              ),
            ],
          ),
        ));
  }
}
