import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFiles extends StatefulWidget {
  final Function checkUpload;
  final Function getDoctors;
  const UploadFiles(
      {required this.checkUpload, required this.getDoctors, super.key});

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  FilePickerResult? result;

  String doctorNote = "Doctor's Note";
  bool upload = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                child: Icon(
                  Icons.description_outlined,
                  size: 24,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: Center(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      doctorNote,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                    onPressed: () async {
                      result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                          withData: true);

                      if (result == null) {
                      } else {
                        setState(() {
                          var element = result!.files.first;
                          widget.checkUpload(true);
                          doctorNote = element.name;
                          widget.getDoctors(element);
                        });
                      }
                    },
                    child: const Text('Upload')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
