import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR_Scan extends StatefulWidget {
  const QR_Scan({super.key});

  @override
  State<QR_Scan> createState() => QRScan();
}

class QRScan extends State<QR_Scan> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

    _controller!.pauseCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: (result != null)
                      ? Text('Data = ${result!.code}')
                      : const Text('Scan QR Code')),
            ),
            Flexible(
              flex: 1,
              child: FilledButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop('qr');
                  });
                },
                child: const Text('Check Info'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
