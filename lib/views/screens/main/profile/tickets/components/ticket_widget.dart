import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/buttons/secondary_button.dart';
import 'package:Gael/views/components/images/image_file_widget.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TicketWidget extends StatefulWidget{
  final EventTicket eventTicket;
  const TicketWidget({super.key, required this.eventTicket});

  @override
  TicketWidgetState createState()=>TicketWidgetState();
}
class TicketWidgetState extends State<TicketWidget>{
  bool showQR = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size  = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
          margin: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                color: ThemeVariables.thirdColorBlack
          ),
          child: Row(
            children: [
              widget.eventTicket.event.imageCover().isFromInternet?
              NetWorkImageWidget(imageUrl:  widget.eventTicket.event.image, size: Size(size.width/4, size.width/3)):
              FileImageWidget(imagePath:  widget.eventTicket.event.imageCover().imagePath, size: Size(size.width/4, size.width/5)),
              SizedBox(width: Dimensions.spacingSizeSmall,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( widget.eventTicket.event.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
                  Text("ID: ${ widget.eventTicket.id}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white)),
                  SizedBox(height: Dimensions.spacingSizeSmall,),
                  Text("PRIX: ${ widget.eventTicket.price} \$", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white)),
                  SizedBox(height: Dimensions.spacingSizeSmall,),
                  Row(
                    children: [
                      GradientButton(onTap: (){
                        Navigator.pushNamed(context, Routes.eventDetailsScreen, arguments: widget.eventTicket.event);
                      }, size:Size(size.width/4, 50), child: Text("event", style:Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white) ,)),
                      SizedBox(width: Dimensions.spacingSizeDefault,),
                      showQR==false?
                      SecondaryButton(onTap: (){
                        setState(() {
                          showQR = !showQR;
                        });
                      }, size: Size(size.width/4, 50),child: Text("QR code", style:Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white), )):
                      const SizedBox()
                    ],)
            ],
          ),
        ),])),
        showQR?
            Container(
              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.width * .8,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.radiusSizeDefault* 2
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                      color: Colors.white
                    ),
                    child: PrettyQrView.data(
                      data: widget.eventTicket.id,
                      decoration:  PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                            image: AssetImage(Assets.logoPNG),
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.color)
                        )
                    )
                    ),
                  ),
                  SizedBox(height: Dimensions.spacingSizeDefault,),
                  SecondaryButton(onTap: (){
                    setState(() {
                      showQR = !showQR;
                    });
                  }, size: Size(size.width, 50),child: Text("fermer", style:Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white), ))
              
                ],
              ),
            ) : Container()
    ]);
  }
}