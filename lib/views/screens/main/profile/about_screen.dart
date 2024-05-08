import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AboutScreen extends StatefulWidget{
  const AboutScreen({super.key});

  @override
  AboutScreenState createState()=> AboutScreenState();
}
class AboutScreenState extends State<AboutScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("A propos", style: Theme.of(context).textTheme.titleMedium,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gael Music", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 40),),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              Text(
                  """
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis quo laboriosam ipsa veniam rerum minima totam molestiae, possimus consectetur odio esse reprehenderit eveniet nulla laborum sunt repudiandae voluptatibus officia commodi tempore necessitatibus deserunt qui hic sint asperiores. Natus commodi facere fuga itaque dolore, ut eius praesentium vel! Nobis exercitationem corrupti quam commodi error tenetur nesciunt labore, ratione quibusdam, possimus accusantium magni, voluptas dolor hic officia consequatur cum incidunt. Minima, odio. Aliquid, perferendis accusamus? Reiciendis et blanditiis dicta distinctio, similique at error eveniet vero deleniti accusantium aliquid. Consequuntur sed earum unde eum commodi voluptatibus vero recusandae libero, impedit labore possimus velit quos, repudiandae mollitia necessitatibus omnis reiciendis optio praesentium itaque quia blanditiis nam. Beatae, repudiandae nemo quo error minima porro ut reprehenderit ex atque illo magni obcaecati qui quidem dolore quia earum molestias, illum ea dolorem accusantium. Inventore illum voluptatum quaerat, quidem earum ratione minus vero quas quae perspiciatis sint quis, aperiam est fugit, aliquid laborum! Dolor labore repellendus maxime hic sunt, quisquam iusto perspiciatis doloribus obcaecati voluptate, corrupti atque fuga assumenda voluptas asperiores, ab illo. Delectus aperiam quidem illo explicabo, libero impedit similique possimus consequuntur aliquid dolorum aspernatur, assumenda totam perspiciatis ab aut nam? Tenetur, dolore. Corporis, magnam necessitatibus, nobis dolores libero adipisci vero excepturi veniam quam tenetur sequi ipsum facere voluptatem error qui debitis quasi? Autem odit saepe necessitatibus veritatis ipsa mollitia, esse doloremque sit voluptate perferendis vitae consequatur placeat culpa, a consequuntur, labore ullam eligendi magni beatae nulla animi. Amet obcaecati quam odio quidem deserunt mollitia vitae praesentium, iure maiores laudantium eius facere voluptatum quisquam, quas nobis eligendi earum temporibus culpa officiis veniam? A fugit necessitatibus quibusdam, numquam placeat facilis ipsam. Debitis fugit vel facere perferendis iure quae esse cum repellendus quam tenetur. Voluptatem eveniet consectetur velit deserunt nihil voluptates voluptas natus est quisquam. Commodi, quo? Voluptate, nobis?
              """,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: Dimensions.spacingSizeDefault,),
              Text("Vos données", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 40),),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              Text(
                """
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis quo laboriosam ipsa veniam rerum minima totam molestiae, possimus consectetur odio esse reprehenderit eveniet nulla laborum sunt repudiandae voluptatibus officia commodi tempore necessitatibus deserunt qui hic sint asperiores. Natus commodi facere fuga itaque dolore, ut eius praesentium vel! Nobis exercitationem corrupti quam commodi error tenetur nesciunt labore, ratione quibusdam, possimus accusantium magni, voluptas dolor hic officia consequatur cum incidunt. Minima, odio. Aliquid, perferendis accusamus? Reiciendis et blanditiis dicta distinctio, similique at error eveniet vero deleniti accusantium aliquid. Consequuntur sed earum unde eum commodi voluptatibus vero recusandae libero, impedit labore possimus velit quos, repudiandae mollitia necessitatibus omnis reiciendis optio praesentium itaque quia blanditiis nam. Beatae, repudiandae nemo quo error minima porro ut reprehenderit ex atque illo magni obcaecati qui quidem dolore quia earum molestias, illum ea dolorem accusantium. Inventore illum voluptatum quaerat, quidem earum ratione minus vero quas quae perspiciatis sint quis, aperiam est fugit, aliquid laborum! Dolor labore repellendus maxime hic sunt, quisquam iusto perspiciatis doloribus obcaecati voluptate, corrupti atque fuga assumenda voluptas asperiores, ab illo. Delectus aperiam quidem illo explicabo, libero impedit similique possimus consequuntur aliquid dolorum aspernatur, assumenda totam perspiciatis ab aut nam? Tenetur, dolore. Corporis, magnam necessitatibus, nobis dolores libero adipisci vero excepturi veniam quam tenetur sequi ipsum facere voluptatem error qui debitis quasi? Autem odit saepe necessitatibus veritatis ipsa mollitia, esse doloremque sit voluptate perferendis vitae consequatur placeat culpa, a consequuntur, labore ullam eligendi magni beatae nulla animi. Amet obcaecati quam odio quidem deserunt mollitia vitae praesentium, iure maiores laudantium eius facere voluptatum quisquam, quas nobis eligendi earum temporibus culpa officiis veniam? A fugit necessitatibus quibusdam, numquam placeat facilis ipsam. Debitis fugit vel facere perferendis iure quae esse cum repellendus quam tenetur. Voluptatem eveniet consectetur velit deserunt nihil voluptates voluptas natus est quisquam. Commodi, quo? Voluptate, nobis?
              """,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}