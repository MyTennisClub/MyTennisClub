import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR_Scan extends StatefulWidget {
  final Function checkResult;
  const QR_Scan({required this.checkResult, super.key});

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

  Future<void> onPermissionSet(
      BuildContext context, QRViewController ctrl, bool p) async {
    {
      if (!p) {
        _controller?.dispose();
        Navigator.pop(context);
      }
    }
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
                onPermissionSet: (ctrl, p) async {
                  await onPermissionSet(context, ctrl, p);
                },
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
            // Flexible(
            //   flex: 1,
            //   child: FilledButton(
            //     onPressed: () {
            //       setState(() {
            //         widget.checkResult(1.toString());
            //         Navigator.pop(context);
            //       });
            //     },
            //     child: const Text('Check Info'),
            //   ),
            // )
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
        widget.checkResult(result!.code);
        Navigator.pop(context);
      });
    });
  }
}
