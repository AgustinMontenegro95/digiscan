import 'dart:io';

import 'package:digit_predictor/screens/home/components/common_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'components/select_photo_options_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const id = 'set_photo_screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  //
  List _outputs = [];
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
    _listenForPermissionStatus();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/artificialIntelligence/model.tflite",
      labels: "assets/artificialIntelligence/labels.txt",
    );
  }

  classifyImageFile(File image) async {
    //tratar la imagen

    var output = await Tflite.runModelOnImage(
      path: image.path,
    );
    print("predict = " + output.toString());
    setState(() {
      _outputs = output!;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  //
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  void _listenForPermissionStatus() async {
    final status = await Permission.camera.status;
    setState(() => _permissionStatus = status);
  }

  Future _pickImage(ImageSource source) async {
    //var status = await Permission.camera.status;
    setState(() {});
    try {
      print(_permissionStatus);
      switch (_permissionStatus) {
        case PermissionStatus.denied:
          print("denegado");
          Permission.camera.request();
          //openAppSettings();
          setState(() {
            _listenForPermissionStatus();
          });
          break;
        case PermissionStatus.granted:
          print("aceptado");
          final image = await ImagePicker().pickImage(source: source);
          if (image == null) return;
          File? img = File(image.path);
          img = await _cropImage(imageFile: img);
          setState(() {
            _image = img;
            Navigator.of(context).pop();
          });
          break;
        case PermissionStatus.limited:
          print("limitado");
          break;
        default:
          print("otro");
          break;
      }

      /* if (status.isRestricted) {
        /* El usuario optó por no volver a ver nunca más el cuadro de diálogo de solicitud de permiso 
          para esta aplicación. La única forma de cambiar el estado del permiso ahora es dejar que el
          el usuario lo habilita manualmente en la configuración del sistema. */
        openAppSettings();
      }

      if (status.isDenied) {
        // No pedimos permiso todavía o el permiso ha sido denegado antes pero no de forma permanente.
        Permission.camera.request();

        //openAppSettings();
      }

      /* if (status.isGranted) {
        // Permiso concedido
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        File? img = File(image.path);
        img = await _cropImage(imageFile: img);
        setState(() {
          _image = img;
          Navigator.of(context).pop();
        });
      } */

      if (await Permission.camera.request().isGranted) {
        // O el permiso ya se concedió antes o el usuario lo acaba de conceder.
        print("cocedido");
        // Permiso concedido
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        File? img = File(image.path);
        img = await _cropImage(imageFile: img);
        setState(() {
          _image = img;
          Navigator.of(context).pop();
        });
      } */
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar imagen',
          toolbarColor: Colors.blueGrey.shade900,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          //cambiado a true
          lockAspectRatio: true,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.28,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Predecir Dígito',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Cargar una imagen',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'mediante cámara o galeria.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: _image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/not-image.jpg',
                                      width: 200,
                                      height: 200,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      _image!,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CommonButtons(
                  onTap: () => _showSelectPhotoOptions(context),
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  textLabel:
                      _image != null ? 'Reemplazar imagen' : 'Agregar imagen',
                ),
                const Divider(
                  thickness: 1,
                  height: 50,
                ),
                Column(
                  children: [
                    const Text(
                      'Resultado',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        _outputs.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CommonButtons(
                  onTap: _image != null
                      ? () {
                          //funcionalidad
                          //File? _image;
                          //tratar imagen
                          classifyImageFile(_image!);
                        }
                      : null,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  textLabel: 'Predecir',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
