import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_model.dart';
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DBHelper? dbHelper = DBHelper();

  List<String> productName=['Jackfruit' ,'Mango','Guavas','Pineapple' ,'Longan','Apple','Watermelon','Bannana',];
  List<String> productUnit=['Pice','KG','Dorzon','Pice','Dorzon','KG','Pice','Dorzon'];
  List<int> productPrice =[100, 120, 60,50,120,60,40,80, ];
  List<String> productImage =[
    'https://thumbs.dreamstime.com/z/jackfruit-isolated-white-jackfruit-isolated-white-background-172042163.jpg',
    'https://media.istockphoto.com/photos/multiple-mangos-one-cut-and-one-sliced-in-a-pattern-picture-id450724125?s=612x612',
    'https://thumbs.dreamstime.com/z/guavas-leaves-21228683.jpg',
    'https://thumbs.dreamstime.com/z/pineapple-slices-isolated-white-30985039.jpg',
    'https://thumbs.dreamstime.com/b/longan-fruit-close-up-white-background-43539942.jpg',
    'https://thumbs.dreamstime.com/b/apple-crate-fresh-red-apples-fruit-food-apple-crate-filled-fresh-red-apples-s-harvest-time-food-fruit-162210192.jpg',
    'https://thumbs.dreamstime.com/b/watermelon-19151721.jpg',
    'https://thumbs.dreamstime.com/z/bannana-yellow-white-background-isolated-75579211.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: Text('Product List'),
        actions: [
          InkWell(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value,child){
                   return Text(value.getCounter().toString(),
                     style: TextStyle(color: Colors.white),);
                  },
                ),
                animationType: BadgeAnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
              child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 20.0,)
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productName.length,
                  itemBuilder:(context,index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  width: 100,
                                  height: 100,
                                  image: NetworkImage(productImage[index].toString()),
                                ),
                                 SizedBox(width: 10,),
                                 Expanded(
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisSize: MainAxisSize.max,
                                     children: [
                                       Text(productName[index].toString(),
                                         style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                       ),
                                       SizedBox(height: 5,),

                                       Text(productUnit[index].toString() +" "+r"$"+ productPrice[index].toString(),
                                         style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                       ),
                                       SizedBox(height: 5,),
                                       Align(
                                         alignment: Alignment.centerRight,
                                       child: InkWell(
                                         onTap: (){
                                           print(index);
                                           print(index);
                                           print(productName[index].toString());
                                           print( productPrice[index].toString());
                                           print( productPrice[index]);
                                           print('1');
                                           print(productUnit[index].toString());
                                           print(productImage[index].toString());

                                           dbHelper!.insert(
                                             Cart(
                                                 id: index,
                                                 productId: index.toString(),
                                                 productName: productName[index].toString(),
                                                 initialPrice: productPrice[index],
                                                 productPrice: productPrice[index],
                                                 quantity: 1,
                                                 unitTag: productUnit[index].toString(), 
                                                 image: productImage[index].toString()
                                             )


                                           ).then((value){

                                               final snackBar = SnackBar(backgroundColor: Colors.green,content: Text('Product is added to cart'), duration: Duration(seconds: 1),);

                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                             cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                             cart.addCounter();
                                           }).onError((error, stackTrace){
                                             print("error"+error.toString());
                                             final snackBar = SnackBar(backgroundColor: Colors.red ,content: Text('Product is already added in cart'), duration: Duration(seconds: 1));

                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                           });
                                         },
                                         child: Container(
                                           height: 35,
                                           width: 100,
                                           decoration: BoxDecoration(
                                             color: Colors.green,
                                             borderRadius: BorderRadius.circular(5),
                                           ),
                                           child:const Center(
                                             child: Text('Add to Cart',style: TextStyle(color: Colors.white),),
                                           ),
                                         ),
                                       ),
                                       ),
                                     ],
                                   ),
                                 ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
            )
        ],
      ),
    );
  }
}
