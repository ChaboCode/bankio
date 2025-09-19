import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Amount extends StatefulWidget {
  const Amount({super.key, required this.wallet});

  final String wallet;

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  late final AppLinks _appLinks;

  final _amountController = TextEditingController();
  final _channel =
      WebSocketChannel.connect(Uri.parse('ws://192.168.1.102:6969/ws'));

  bool _sending = false;
  int _id = 0;

  @override
  void initState() {
    super.initState();
    _initAppLinks();
  }

  Future<void> _initAppLinks() async {
    _appLinks = AppLinks();

    // cold start
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleLink(initialUri);
    }

    // hot start
    _appLinks.uriLinkStream.listen(_handleLink);
  }

  void _handleLink(Uri uri) {
    if (!_sending) return;
    print('Link recibido: $uri');
    print('========================================================\n'
        '==============================================\n'
        '===================================');
    final hash = uri.queryParameters['hash'];
    final interact_ref = uri.queryParameters['interact_ref'];

    _channel.sink.add(
        '{"type": "payment_continue", "hash": "$hash", "interact_ref": "$interact_ref", "id": $_id}');
  }

  void _send() {
    setState(() {
      _sending = true;
    });

    handlePaymentFirstPhase();
  }

  Future<void> handlePaymentFirstPhase() async {
    await _channel.ready;
    _channel.sink.add('{'
        '"type": "payment_first",'
        '"sender": "https://ilp.interledger-test.dev/pingadeburra",'
        '"receiver": "${widget.wallet}",'
        '"amount": ${int.parse(_amountController.text.replaceAll('\$', '').split('.')[0])}'
        '}');

    _channel.stream.listen((msg) {
      final data = jsonDecode(msg) as Map<String, dynamic>;
      setState(() {
        _id = data['id'];
      });
      _openAuthUrl(data['redirect']!);
    });
  }

  Future<void> _openAuthUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _amountController.dispose();
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
          '¿Cuánto vas a enviar?',
          style: GoogleFonts.urbanist(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
                controller: _amountController,
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                      _amountController.text =
                          '\$${double.parse(value.trim().replaceAll('\$', '')).toStringAsFixed(2)}';
                      _amountController.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: _amountController.text.length - 3));
                    }),
                style: GoogleFonts.manrope(fontSize: 22),
                decoration: InputDecoration(
                    isDense: true,
                    labelStyle: GoogleFonts.manrope(fontSize: 24),
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
                    fillColor: Colors.white)),
            const SizedBox(
              width: 20,
            ),
            _sending
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : TextButton(
                    style: IconButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () => _send(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enviar ${_amountController.text}',
                        style: GoogleFonts.manrope(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
            Text(
              'Destinatario: ${widget.wallet}',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
