import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Upload_Files extends StatefulWidget {
  final String personSelected;
  final String typeSelected;
  final Function checkEachUpload;
  final Function getID;
  final Function getSolemn;
  final Function getDoctors;
  const Upload_Files(
      {required this.getID,
      required this.getSolemn,
      required this.getDoctors,
      required this.personSelected,
      required this.typeSelected,
      required this.checkEachUpload,
      super.key});

  @override
  State<Upload_Files> createState() => UploadFiles();
}

class UploadFiles extends State<Upload_Files> {
  FilePickerResult? result;
  Uint8List? fileBytes;
  String id = 'ID';
  String doctorNote = "Doctor's Note";
  String solemn = 'Solemn Decleration';

  List<bool> uploads = [false, false, false];

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
                      id,
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
                          type: FileType.custom, allowedExtensions: ['pdf'], withData: true);

                      if (result == null) {
                      } else {
                        setState(() {
                          var element = result!.files.first;
                          uploads[0] = true;
                          widget.checkEachUpload(
                              uploads[0], uploads[1], uploads[2]);
                          id = element.name;
                          widget.getID(element);
                        });
                      }
                    },
                    child: const Text('Upload')),
              ),
            ],
          ),
        ),
        (widget.typeSelected == 'athlete')
            ? Padding(
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
                                allowedExtensions: ['pdf'], withData: true);

                            if (result == null) {
                            } else {
                              setState(() {
                                var element = result!.files.first;
                                uploads[1] = true;
                                widget.checkEachUpload(
                                    uploads[0], uploads[1], uploads[2]);
                                doctorNote = element.name;
                                widget.getDoctors(element);
                              });
                            }
                          },
                          child: const Text('Upload')),
                    ),
                  ],
                ),
              )
            : Container(),
        (widget.personSelected == 'kid')
            ? Padding(
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
                            solemn,
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
                                allowedExtensions: ['pdf'], withData: true);
                            if (result == null) {
                            } else {
                              setState(() {});
                              var element = result!.files.first;
                              uploads[2] = true;
                              widget.checkEachUpload(
                                  uploads[0], uploads[1], uploads[2]);
                              solemn = element.name;
                              widget.getSolemn(element);
                            }
                          },
                          child: const Text('Upload')),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
