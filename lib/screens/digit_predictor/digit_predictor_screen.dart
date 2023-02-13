import 'dart:convert';
import 'dart:io';

import 'package:digit_predictor/model/result_model.dart';
import 'package:digit_predictor/screens/digit_predictor/components/common_buttons.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as Img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'components/select_photo_options_screen.dart';

class DigitPredictorScreen extends StatefulWidget {
  const DigitPredictorScreen({super.key});

  @override
  State<DigitPredictorScreen> createState() => _DigitPredictorScreenState();
}

class _DigitPredictorScreenState extends State<DigitPredictorScreen> {
  File? _image;

  List<ResultModel>? _resultList = [];

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
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

    List<ResultModel>? resultList = [];

    print(
        "predict = ${output.toString().replaceAll("index", "\"index\"").replaceAll("label", "\"label\"").replaceAll("confidence", "\"confidence\"")}");

    ResultModel resultModel;
    for (var result in output!) {
      resultModel = ResultModel.fromJson(json.decode(result
          .toString()
          .replaceAll("index", "\"index\"")
          .replaceAll("label", "\"label\"")
          .replaceAll("confidence", "\"confidence\"")));
      resultList.add(resultModel);
    }

    print(resultList[0].confidence);

    setState(() {
      _resultList = resultList;
    });
  }

  Future pickImage(ImageSource source) async {
    var status = source == ImageSource.camera
        ? await Permission.camera.status
        : await Permission.storage.status;

    var permissionRequest = source == ImageSource.camera
        ? await Permission.camera.request().isGranted
        : await Permission.storage.request().isGranted;

    try {
      print(status);
      if (status.isGranted) {
        permissionGranted(source);
      } else if (status.isDenied) {
        // No pedimos permiso todavía o el permiso ha sido denegado antes pero no de forma permanente.
        if (permissionRequest) {
          // El permiso ya se concedió antes o el usuario lo acaba de conceder.
          permissionGranted(source);
        }
      } else if (status.isRestricted ||
          status.isLimited ||
          status.isPermanentlyDenied) {
        /* El usuario optó por no volver a ver nunca más el cuadro de diálogo de solicitud de permiso 
          para esta aplicación. La única forma de cambiar el estado del permiso ahora es dejar que el
          el usuario lo habilita manualmente en la configuración del sistema. */
        openAppSettings();
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  permissionGranted(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // image size (dudoso)
    var imageBytes = Img.decodeImage(await image.readAsBytes());
    var resizedImage = Img.copyResize(imageBytes!, width: 28, height: 28);
    List<int> resizedBytes = Img.encodePng(resizedImage);
    File resizedFile = File('resized_image.png');
    await resizedFile.writeAsBytes(resizedBytes);
    //
    // aumento de contraste
    var imageReadBytes = Img.decodeImage(await resizedFile.readAsBytes());
    // Asigna el archivo de imagen a la variable imageFile
    int width = imageReadBytes!.width;
    int height = imageReadBytes.height;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int pixel = imageReadBytes.getPixel(x, y);
        int red = Img.getRed(pixel);
        int green = Img.getGreen(pixel);
        int blue = Img.getBlue(pixel);

        // Aumenta el contraste multiplicando por un factor
        red = (red * 1.5).clamp(0, 255).toInt();
        green = (green * 1.5).clamp(0, 255).toInt();
        blue = (blue * 1.5).clamp(0, 255).toInt();

        imageReadBytes.setPixelRgba(
            x, y, red, green, blue, Img.getAlpha(pixel));
      }
    }
    List<int> modifiedBytes = Img.encodePng(imageReadBytes);
    File modifiedFile = File('contrast_increased_image.png');
    await modifiedFile.writeAsBytes(modifiedBytes);
    //
    File? img = File(modifiedFile.path);
    //File? img = File(resizedFile.path);
    //File? img = File(image.path);
    img = await cropImage(imageFile: img);
    setState(() {
      _image = img;
      Navigator.of(context).pop();
    });
  }

  Future<File?> cropImage({required File imageFile}) async {
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

  void showSelectPhotoOptions(BuildContext context) {
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
                onTap: pickImage,
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
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
                        showSelectPhotoOptions(context);
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
                                    child: Screenshot(
                                      controller: screenshotController,
                                      child: ColorFiltered(
                                        colorFilter: const ColorFilter.mode(
                                          Colors.grey,
                                          BlendMode.saturation,
                                        ),
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
                  ),
                ),
                CommonButtons(
                  onTap: () => showSelectPhotoOptions(context),
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
                      height: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _resultList!.length == 1
                                  ? _resultList![0].label.toString()
                                  : _resultList!.length.toString(),
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.black87,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _resultList!.length == 1
                                      ? "Confianza: ${_resultList![0].confidence}"
                                      : _resultList!.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  _resultList!.length == 1
                                      ? "Indice: ${_resultList![0].index}"
                                      : _resultList!.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  _resultList!.length == 1
                                      ? "Etiqueta: ${_resultList![0].label}"
                                      : _resultList!.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CommonButtons(
                  onTap: _image != null
                      ? () async {
                          //funcionalidad
                          //File? _image;
                          //tratar imagen

                          /* // Carga el archivo de imagen en la variable imageFile
                          Uint8List imageBytes = _image!.readAsBytesSync();
                          // Carga los bytes de la imagen en la variable imageBytes
                          var image = Img.decodeImage(imageBytes);
                          Image blackAndWhiteImage =
                              Img.grayscale(image!) as Image; */

                          //captura de pantalla
                          Uint8List _imagefile =
                              await screenshotController.capture(
                                      delay: const Duration(milliseconds: 10))
                                  as Uint8List;
                          //guardar el archivo en el directorio principal de la aplicacion
                          MimeType type = MimeType.PNG;
                          String path = await FileSaver.instance.saveFile(
                              'digit-capture', _imagefile, 'png',
                              mimeType: type);
                          //se busca la imagen guardada y se crea un tipo File necesario para poder subir
                          final file = File(path);

                          classifyImageFile(file);
                          //classifyImageFile(_image!);
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
