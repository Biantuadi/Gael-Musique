import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class LoadingOverlayScreen extends StatelessWidget{

  const LoadingOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Assets.splashBgJPG,
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: 0.5,
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                gradient: ThemeVariables.linearGradient),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Assets.logoPNG,
                width: size.width / 3,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 30,
                  child: Column(
                    children: [
                     Container(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.iconSizeSmall),
                          child: Text(
                            "Chargement des données",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          )),
                      const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}