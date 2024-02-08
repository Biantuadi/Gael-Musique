import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/ellipsis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';

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
          Container(padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.15),
                  child: SvgPicture.asset(
                    Assets.mediaSonSVG,
                    width: width,
                    height: height * 0.3,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    Assets.textGael,
                    width: width * 0.5,
                    height: height * 0.22,
                  ),
                ),
                SizedBox(height: sizeScreen.height * 0.1,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientButton(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.loginScreen);
                      },
                      size: Size(width*0.35, height * 0.07),
                      child: Text("Press me", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black, 
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),),
                    ),
                    // SizedBox(height: Dimensions.spacingSizeDefault,),
                    // Text('or', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.primaryColor.withOpacity(0.7)),),
                    // TextButton(
                    //     onPressed: (){
                    //       Navigator.pushNamed(context, Routes.registerScreen);
                    //     },
                    //     child: Text("Register", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ThemeVariables.primaryColor))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
