import 'package:bankio/amount.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Contact {
  final String name;
  final String address;

  Contact(this.name, this.address);
}

class ContactSelector extends StatefulWidget {
  const ContactSelector({super.key, required this.contacts});

  final List<Contact> contacts;

  @override
  State<ContactSelector> createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<ContactSelector> {
  final _walletController = TextEditingController();

  @override
  void dispose() {
    _walletController.dispose();
    super.dispose();
  }

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
            SizedBox(
              child: Column(
                children: [
                  Text(
                    'Escanea su dirección de wallet',
                    style: GoogleFonts.manrope(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: MobileScanner(
                        onDetect: (barcodes) => setState(() {
                              _walletController.text =
                                  barcodes.barcodes.first.rawValue ?? '';
                            })),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                          controller: _walletController,
                          onChanged: (value) => setState(() {
                                _walletController.text = value;
                              }),
                          autofocus: false,
                          obscureText: false,
                          style: GoogleFonts.manrope(fontSize: 14),
                          decoration: InputDecoration(
                              isDense: true,
                              labelStyle: GoogleFonts.manrope(fontSize: 14),
                              hintText: '\$ilp.interledger.org/fulanodetal',
                              hintStyle: GoogleFonts.manrope(fontSize: 14),
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
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                  disabledBackgroundColor:
                      const Color.fromRGBO(156, 156, 156, 1.0),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8))),
              onPressed: _walletController.text.isEmpty
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Amount(wallet: _walletController.text)));
                    },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Text(
                  'Continuar',
                  style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'O selecciona un contacto',
              style: GoogleFonts.manrope(fontSize: 12),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.contacts.length,
              itemBuilder: (context, index) {
                return Card.filled(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Amount(
                                wallet: widget.contacts[index].address,
                              ))),
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
                                      widget.contacts[index].name,
                                      style: GoogleFonts.manrope(fontSize: 16),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Text(
                                          widget.contacts[index].address,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.manrope(
                                              fontSize: 12)),
                                    )
                                  ])
                            ],
                          )),
                    ));
              },
            )),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
