import 'dart:io';

import 'package:digit_predictor/screens/home/components/common_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'select_photo_options_screen.dart';

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

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
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
          maxChildSize: 0.4,
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
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Ingrese una imagen',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Photos make your profile more engaging',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
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
                                  ? const Text(
                                      'Sin imagen',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 200.0,
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Anonymous',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonButtons(
                      onTap: () => _showSelectPhotoOptions(context),
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      textLabel: 'Add a Photo',
                    ),
                  ],
                ),
                //
                const SizedBox(height: 15),
                CommonButtons(
                  onTap: () {
                    //funcionalidad
                    //File? _image;
                    //tratar imagen
                    classifyImageFile(_image!);
                  },
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  textLabel: 'Predecir',
                ),
                if (_outputs == [])
                  const Text("Resultado")
                else
                  Text(_outputs.toString()),
                _stepper(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _currentStep = 0;
  bool isCompleted = false;

  Widget _stepper() {
    if (isCompleted) {
      return Container();
    } else {
      return Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.blue)),
        child: Stepper(
          //indica cual es el paso actual del stepper
          currentStep: this._currentStep,
          //numero de pasos
          steps: getSteps(),
          type: StepperType.vertical,
          physics: ScrollPhysics(),
          onStepContinue: () {
            final isLastStep = _currentStep == getSteps().length - 1;
            if (isLastStep) {
              setState(() {
                isCompleted = true;
              });
              print('Completed');
              //mandar datos al servidor
              /* Producto producto = Producto();
              producto.categoria = _dropdownValue;
              producto.nombre = nombreController.text;
              producto.descripcion = descripcionController.text;
              producto.precio = precioController.text;
              widget.listaProducto?.add(producto); */
              Navigator.pop(context);
            } else {
              setState(() {
                _currentStep += 1;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep == 0) {
              null;
            } else {
              setState(() {
                _currentStep = _currentStep - 1;
              });
            }
          },
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          controlsBuilder: (context, details) {
            final isLastStep = _currentStep == getSteps().length - 1;
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'CONFIRMAR' : 'SIGUIENTE'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  if (_currentStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: Text("VOLVER"),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  List<Step> getSteps() {
    return [
      Step(
          title: Text("Ingresa "),
          subtitle: Text("Paso 1"),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.editing,
          content: /* _dropdownCategoria() */ Text("asd")),
      Step(
        title: Text("Ingresa el nombre"),
        subtitle: Text("Paso 2"),
        isActive: _currentStep >= 1,
        state: _currentStep > 1
            ? StepState.complete
            : _currentStep == 1
                ? StepState.editing
                : StepState.indexed,
        content: Container(
            child: Text(
                "daa") /* _textField(
              hintText: "Ingrese el nombre",
              controller: nombreController,
              focusNode: focusNombre,
              focusNodeSiguiente: focusDescripcion), */
            ),
      ),
      Step(
        title: Text("Ingresa una descripción"),
        subtitle: Text("Paso 3"),
        isActive: _currentStep >= 2,
        state: _currentStep > 2
            ? StepState.complete
            : _currentStep == 2
                ? StepState.editing
                : StepState.indexed,
        content: Container(
            child: Text(
                "Paso 3") /* _textField(
              hintText: "Ingresa una desocripción",
              controller: descripcionController,
              focusNode: focusDescripcion,
              focusNodeSiguiente: focusPrecio), */
            ),
      ),
      Step(
        title: Text("Ingresa su precio"),
        subtitle: Text("Paso 4"),
        isActive: _currentStep >= 3,
        state: _currentStep > 3
            ? StepState.complete
            : _currentStep == 3
                ? StepState.editing
                : StepState.indexed,
        content: Container(
            child: Text(
                "Paso 3") /* _textField(
              hintText: "Ingresa su precio",
              controller: precioController,
              focusNode: focusPrecio,
              textInputType: TextInputType.number,
              focusNodeSiguiente: focusPrecio), */
            ),
      ),
      Step(
        title: Text("Confirmar producto"),
        subtitle: Text("Paso 5"),
        isActive: _currentStep >= 4,
        state: _currentStep > 4
            ? StepState.complete
            : _currentStep == 4
                ? StepState.editing
                : StepState.indexed,
        content: Column(
          children: [
            Row(
              children: [
                Text("Categoria:"),
                SizedBox(width: 10),
                //Text(_dropdownValue!),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Nombre:"),
                SizedBox(width: 10),
                //Text(nombreController.text),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Descripcion:"),
                SizedBox(width: 10),
                //Text(descripcionController.text),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Precio:"),
                SizedBox(width: 10),
                //Text(precioController.text),
                Text("."),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
