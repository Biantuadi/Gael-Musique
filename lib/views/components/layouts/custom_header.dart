import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showLogo!) _buildLogo(),
          if (showBackButton!) _buildBackButton(context),
          if (title!.isNotEmpty) _buildTitle(context),
          if (showAvatar!) _buildAvatar(context),
          if (textRadio!) _buildTextRadio(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      Assets.logoPNG,
      height: 50,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title!,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeVariables.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: NetWorkImageWidget(imageUrl: Provider.of<AuthProvider>(context, listen: false).userProfileUrl??"", size: Size(Dimensions.iconSizeExtraLarge * 1.2, Dimensions.iconSizeExtraLarge*1.2), radius: Dimensions.iconSizeExtraLarge,),
    );
  }

  // text span
  Widget _buildTextRadio(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Laissez vous emporter \n',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
            ),
        children: const <TextSpan>[
          TextSpan(
            text: 'par nos playlists',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
