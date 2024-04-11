import 'package:Gael/data/models/app/payment_mean.dart';
import 'package:Gael/data/providers/payment_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PaymentDetailsScreen extends StatefulWidget{
  const PaymentDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentDetailsScreenState();
  }

}
class PaymentDetailsScreenState extends State<PaymentDetailsScreen>{
  PaymentMean? selectedMean;
  @override
  void initState() {
    super.initState();
    selectedMean = Provider.of<PaymentProvider>(context, listen: false).paymentMeans.first;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer<PaymentProvider>(builder: (ctx, provider, child){

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Payment", style: Theme.of(context).textTheme.titleMedium,),
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
                icon: const Icon(Iconsax.arrow_left, color: Colors.white,),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
              sliver: SliverList.list(children: [
                Text("Moyen de payement ", style: Theme.of(context).textTheme.titleSmall,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
                  child: DropdownButton(
                    padding:  EdgeInsets.symmetric(vertical:Dimensions.spacingSizeDefault),
                      isExpanded :true,
                      itemHeight : kMinInteractiveDimension * 1.2,
                      alignment: AlignmentDirectional.bottomCenter,
                      items: provider.paymentMeans.map((mean) => DropdownMenuItem<PaymentMean>(
                        value: mean,
                          child: Container(
                            margin: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
                            padding: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Dimensions.spacingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                                    color: Colors.white
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                                      child: Image.asset(mean.imgUrl, width: size.width * .1, height: size.width * .1, fit: BoxFit.fitWidth,)),
                                ),
                                SizedBox(width: Dimensions.spacingSizeSmall,),
                                Text(mean.name, style: Theme.of(context).textTheme.bodySmall,)
                              ],
                            ),
                          ))).toList(),
                      value: selectedMean!,
                      onChanged: (value){
                        setState(() {
                          selectedMean =value!;
                        });
                      }),
                )
              ]),
            )
          ],
        );
      }),
    );
  }
}