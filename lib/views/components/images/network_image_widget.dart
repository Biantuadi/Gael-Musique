import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';

class NetWorkImageWidget extends StatefulWidget{
  final String imageUrl;
  final Size size;
  final double? radius;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;
  const NetWorkImageWidget({super.key, required this.imageUrl, required this.size, this.radius, this.errorWidget, this.placeHolderWidget});
  @override
  State<StatefulWidget> createState() {
   return NetWorkImageWidgetState();
  }

}
class NetWorkImageWidgetState extends State<NetWorkImageWidget>{
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:BorderRadius.circular(widget.radius??Dimensions.radiusSizeDefault),
      child: Container(
        height: widget.size.height,
        width: widget.size.width,
        decoration:const BoxDecoration(
          color: Colors.white10
        ),
        child: ImageFade(
          image: NetworkImage(widget.imageUrl),
          duration: const Duration(milliseconds: 900),
          syncDuration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          placeholder: Container(
            color: Theme.of(context).hintColor,
            height: widget.size.height,
            width: widget.size.width,
            alignment: Alignment.center,
            child: widget.placeHolderWidget ??  Icon(Iconsax.image, color: Colors.white30, size: widget.size.width /2),
          ),
          loadingBuilder: (context, progress, chunkEvent) =>
              Container(
                height: widget.size.height,
                width: widget.size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(widget.radius??Dimensions.radiusSizeDefault)
                ),
                  child: CircularProgressIndicator(value: progress),
              ),
          errorBuilder: (context, error) => Container(
            height: widget.size.height,
            width: widget.size.width,
            color: const Color(0xFF6F6D6A),
            alignment: Alignment.center,
            child:widget.errorWidget?? Icon(Iconsax.eraser, color: Colors.black26, size: widget.size.width * 0.2),
          ),
        ),
      ),
    );
  }
  
}