import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Upload_Files extends StatefulWidget {
  final String personSelected;
  final String typeSelected;
  final Function checkEachUpload;
  const Upload_Files(
      {required this.personSelected,
      required this.typeSelected,
      required this.checkEachUpload,
      super.key});

  @override
  State<Upload_Files> createState() => UploadFiles();
}

class UploadFiles extends State<Upload_Files> {
  FilePickerResult? result;
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
                          type: FileType.custom, allowedExtensions: ['pdf']);

                      if (result == null) {
                      } else {
                        setState(() {});
                        for (var element in result!.files) {
                          uploads[0] = true;
                          widget.checkEachUpload(
                              uploads[0], uploads[1], uploads[2]);
                          id = element.name;
                        }
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
                                allowedExtensions: ['pdf', 'jpg']);

                            if (result == null) {
                            } else {
                              setState(() {});
                              for (var element in result!.files) {
                                uploads[1] = true;
                                widget.checkEachUpload(
                                    uploads[0], uploads[1], uploads[2]);
                                doctorNote = element.name;
                              }
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
                                allowedExtensions: ['pdf', 'jpg']);

                            if (result == null) {
                            } else {
                              setState(() {});
                              for (var element in result!.files) {
                                uploads[2] = true;
                                widget.checkEachUpload(
                                    uploads[0], uploads[1], uploads[2]);
                                solemn = element.name;
                              }
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
