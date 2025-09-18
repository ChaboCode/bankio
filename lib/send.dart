import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'A quién vas a transferir?',
          style: GoogleFonts.urbanist(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8)),
                    child: Padding(
                        padding: const EdgeInsetsGeometry.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(Icons.person_rounded,
                                color: Colors.black, size: 24),
                            const SizedBox(width: 20),
                            Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Javier Ochoa',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                        '\$ilp.interledger-test.dev/javierochoa',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.manrope(
                                          fontSize: 12
                                        )),
                                  )
                                ])
                          ],
                        )))
              ],
            )),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8))),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Text(
                  'Continuar',
                  style: GoogleFonts.manrope(color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'O transnfiere a un nuevo contacto',
                    style: GoogleFonts.manrope(
                      fontSize: 12
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: MobileScanner(
                      onDetect: (barcodes) {
                        print(barcodes.barcodes.first.rawValue);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                      width: 200,
                      child: TextFormField(
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              isDense: true,
                              labelStyle: GoogleFonts.manrope(
                                fontSize: 14
                              ),
                              hintText: '\$ilp.interledger.org/fulanodetal',
                              hintStyle: GoogleFonts.manrope(
                                fontSize: 14
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.white)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
