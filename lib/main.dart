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
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        colorScheme: const ColorScheme.light(),
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
          title: const SizedBox.shrink(), 
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'YaYa',
                      style: GoogleFonts.urbanist(
                        fontSize: 60,
                      ),
                    ),
                    const Text('¿Ya te cayo? ¡Ya, ya!'),
                    const SizedBox(
                      height: 32,
                    ),
                    ExpandableQRButton(),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffea580c),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactSelector(contacts: [
                                  Contact('YoVoy',
                                      'https://ilp.interledger-test.dev/yovoy')
                                ])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(
                              Icons.crop_free,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('Transferir',
                                style: GoogleFonts.urbanist(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Text('Transferencias P2P instantaneas',
                        style: GoogleFonts.manrope(fontSize: 14)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Powered by Interledger Open Payments',
                      style: GoogleFonts.manrope(fontSize: 12),
                    ),
                    /*QrImageView(
                      data: 'https://ilp.interledger-test.dev/enterprise',
                      version: QrVersions.auto,
                      size: 150.0,
                      // dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
                      // gapless: false,
                      // eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
                    ),*/
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xfff9fafb),
                    border: Border(
                        top: BorderSide(
                      width: 1,
                      color: Color(0xfff3f4f6),
                    ))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'YaYa • ',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Transferencias intsantáneas seguras',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class ExpandableQRButton extends StatefulWidget {
  const ExpandableQRButton({super.key});

  @override
  _ExpandableQRButtonState createState() => _ExpandableQRButtonState();
}

class _ExpandableQRButtonState extends State<ExpandableQRButton>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff7a4388),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !_expanded
                                ? const Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('Recibir',
                                style: GoogleFonts.urbanist(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: _expanded
                                ? Column(
                                  children: [
                                    QrImageView(
                                        data:
                                            'https://ilp.interledger-test.dev/esochoa',
                                        version: QrVersions.auto,
                                        size: 150.0,
                                        dataModuleStyle: const QrDataModuleStyle(
                                            dataModuleShape:
                                                QrDataModuleShape.circle,
                                            color: Colors.white),
                                        // gapless: false,
                                        eyeStyle: const QrEyeStyle(
                                            eyeShape: QrEyeShape.circle,
                                            color: Colors.white),
                                      ),
                                      Text('https://ilp.interledger-test.dev/esochoa', style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: 14
                                      ),)
                                  ],
                                )
                                : const SizedBox.shrink()),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
