import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/ellipsis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gael/views/components/button_gradient.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    double width = sizeScreen.width;
    double height = sizeScreen.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_welcome.webp"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(152, 19, 19, 18),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(108, 19, 19, 18),
              BlendMode.darken,
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          buildEllipse(
            sizeWidth: width * 0.5,
            sizeHeight: width * 0.8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.163),
                child: SvgPicture.asset(
                  "assets/images/Media_son.svg",
                  width: width,
                  height: height * 0.252,
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 10, top: 50),
                child: SvgPicture.asset(
                  "assets/images/TextGael.svg",
                  width: width * 0.5,
                  height: height * 0.22,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, top: 100),
                child:  GradientButton(
                  child: Text("Press Me", style: Theme.of(context).textTheme.titleSmall,),
                  voidCallback: () {
                    Navigator.pushNamed(context, Routes.mainScreen);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
