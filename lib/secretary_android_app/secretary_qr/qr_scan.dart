import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mytennisclub/models/reservation.dart';

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
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      if (result!.code!.isNotEmpty) {
        if (_isInteger(result!.code!)) {
          try {
            int scannedId = int.parse(result!.code!);
            print('----------- $scannedId ---------');
            _controller!.pauseCamera(); // Pause the camera to stop scanning

            var reservation =
                await Reservation.fetchReservationFromDb(scannedId);

            if (reservation.isNotEmpty) {
              setState(() {
                result = scanData;
                _controller!.pauseCamera(); // Pause the camera to stop scanning
                widget.checkResult(result!.code, reservation);
                Navigator.pop(context);
              });
            } else {
              _controller!.pauseCamera();
              Navigator.pop(context);
              _showErrorDialog(
                  context, 'No reservation found with the given ID');
            }
          } catch (e) {
            _controller!.pauseCamera();
            Navigator.pop(context);
            print('Error fetching reservation: $e');
            _showErrorDialog(context, 'Error fetching reservation');
          }
        } else {
          _controller!.pauseCamera();
          Navigator.pop(context);
          _showErrorDialog(context, 'Scanned QR code is not a valid ID');
        }
      }
    });
  }

  bool _isInteger(String value) {
    return int.tryParse(value) != null;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
