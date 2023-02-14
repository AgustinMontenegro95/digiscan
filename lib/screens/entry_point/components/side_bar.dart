import 'package:digit_predictor/screens/entry_point/entry_point.dart';
import 'package:digit_predictor/screens/habinak_carlos/habinak_carlos_screen.dart';
import 'package:digit_predictor/screens/help/help_screen.dart';
import 'package:digit_predictor/screens/montenegro_agustin/montenegro_agustin_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../model/menu_model.dart';
import '../../../utils/rive_utils.dart';
import 'info_card.dart';
import 'side_menu.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  MenuModel selectedSideMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF17203A),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "Digit Predictor",
                bio: "App",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "NAVEGACIÓN",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                          //borrar
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EntryPoint(
                                        screenRedirect: HelpScreen())));
                          });
                          //
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "SOBRE NOSOTROS",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                          // Redirect page
                          switch (menu.title) {
                            case "Habiñak, Carlos Alberto":
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EntryPoint(
                                            screenRedirect:
                                                HabinakCarlosScreen())));
                              });
                              break;
                            case "Montenegro, Agustin":
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EntryPoint(
                                            screenRedirect:
                                                MontenegroAgustinScreen())));
                              });
                              break;
                            default:
                          }
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              Center(
                  child: Container(
                padding: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () => launchUrlString("https://soludevs.web.app"),
                  child: Image.asset("assets/images/soludev_logo_mono.png",
                      width: 75),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
