import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/validators/email_validator.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/loading_overlay.dart';
import 'package:Gael/views/components/overlay_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool showPositional = true;
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    //Provider.of<AuthProvider>(context, listen: false).nullAuthVars();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    showPositional = !(keyBoardHeight > 0);
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (BuildContext ctx, provider, Widget? widget) {
          return SafeArea(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    Assets.loginBg,
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Consumer<AuthProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Iconsax.arrow_left,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.all(Dimensions.spacingSizeDefault),
                            width: size.width,
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.logoPNG,
                                    width: size.width / 4,
                                  ),
                                  SizedBox(
                                    height: Dimensions.spacingSizeDefault,
                                  ),
                                  Text(
                                    "Login",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(
                                    height: Dimensions.spacingSizeSmall,
                                  ),
                                  Text(
                                    "Heureux de vous revoir!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: Dimensions.spacingSizeLarge,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: Dimensions.spacingSizeSmall,
                                      ),
                                      CustomTextField(
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        hintText: 'e-mail@gmail.com',
                                        validator: (value) =>
                                            validateEmail(value),
                                      ),
                                      SizedBox(
                                        height: Dimensions.spacingSizeDefault,
                                      ),
                                      Text(
                                        "Mot de passe",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: Dimensions.spacingSizeSmall,
                                      ),
                                      CustomTextField(
                                        onChanged: (value) {
                                          password = value;
                                        },
                                        hintText: '********',
                                        isForPassword: true,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.toString().trim() == "") {
                                            return "Le mot de passe est obligatoire";
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  provider.loginError != null
                                      ? SizedBox(
                                          width: size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    Dimensions.spacingSizeLarge,
                                              ),
                                              Text(
                                                provider.loginError!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.red),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ),
                                  SizedBox(
                                    height: Dimensions.spacingSizeLarge,
                                  ),
                                  GradientButton(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          provider.login(
                                              LoginModel(
                                                  email: email,
                                                  password: password),
                                              successCallBack: () async {
                                            await Provider.of<SongProvider>(
                                                    context,
                                                    listen: false)
                                                .getSongsFromApi();
                                            await Provider.of<SongProvider>(
                                                    context,
                                                    listen: false)
                                                .getAlbums();
                                            await Provider.of<EventsProvider>(
                                                    context,
                                                    listen: false)
                                                .getEventsFromAPi();
                                            await Provider.of<
                                                        StreamingProvider>(
                                                    context,
                                                    listen: false)
                                                .getStreaming()
                                                .then((value) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Routes.mainScreen,
                                                  (route) => false);
                                            });
                                          }, errorCallback: () {});
                                        }
                                      },
                                      size: size,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          provider.isLoading
                                              ? Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                .spacingSizeSmall),
                                                        width: Dimensions
                                                            .iconSizeExtraSmall,
                                                        height: Dimensions
                                                            .iconSizeExtraSmall,
                                                        child:
                                                            const CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                          color: Colors.black,
                                                        ))
                                                  ],
                                                )
                                              : const SizedBox(),
                                          Text(
                                            "se connecter",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Mot de passe oublié? "))
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                ),
                Positioned(
                    bottom: size.height * 0.000,
                    child: Visibility(
                      visible: showPositional,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: size.height * 0.07,
                        color: Colors.black.withOpacity(0.6),
                        child: RichText(
                          text: TextSpan(
                              text: "Vous n'avez pas un compte?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: " Créez-en",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, Routes.registerScreen),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                    )),
                (provider.isLoading || provider.isLoadingData)
                    ? OverlayScreen(
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.emoji_happy4,
                              size: Dimensions.iconSizeExtraLarge,
                            ),
                            SizedBox(
                              height: Dimensions.spacingSizeDefault,
                            ),
                            const Text("Connexion en cours...")
                          ],
                        ),
                      )
                    : const SizedBox(),
                provider.isLoadingData
                    ? const LoadingOverlayScreen()
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
