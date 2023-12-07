import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    Key? key,
    this.showLogo = false,
    this.showAvatar = false,
    this.showBackButton = false,
    this.title = "",
    this.textRadio = false,
  }) : super(key: key);

  final bool? showLogo;
  final bool? showAvatar;
  final bool? showBackButton;
  final String? title;
  final bool? textRadio;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: textRadio! ? 140 : 105,
      padding: const EdgeInsets.only(top: 50),
      // color: AppTheme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showLogo!) _buildLogo(),
          if (showBackButton!) _buildBackButton(context),
          if (title!.isNotEmpty) _buildTitle(context),
          if (showAvatar!) _buildAvatar(),
          if (textRadio!) _buildTextRadio(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Image.asset(
        'assets/logo/logo.png',
        height: 50,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        title!,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeVariables.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(
          'assets/images/avatar.png',
        ),
      ),
    );
  }

  // text span
  Widget _buildTextRadio(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: RichText(
        text: TextSpan(
          text: 'Faites votre choix, \n',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
          children: const <TextSpan>[
            TextSpan(
              text: 'ou passez sur la radio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
