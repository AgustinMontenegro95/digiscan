import 'rive_model.dart';

class MenuModel {
  final String title;
  final RiveModel rive;

  MenuModel({required this.title, required this.rive});
}

List<MenuModel> sidebarMenus = [
  MenuModel(
    title: "Principal",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  MenuModel(
    title: "Más sobre DigiScan",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
  ),
  MenuModel(
    title: "Proceso de desarrollo",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity"),
  ),
  MenuModel(
    title: "Ayuda",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
  ),
];
List<MenuModel> sidebarMenus2 = [
  MenuModel(
    title: "Habiñak, Carlos Alberto",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
  MenuModel(
    title: "Montenegro, Agustin",
    rive: RiveModel(
        src: "assets/rive_assets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
];
