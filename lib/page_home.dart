import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_core/page_home_detailscreen.dart';
import 'package:shopping_core/products/my_product.dart';

import 'components/product_card.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int isSelected = 0;

  _buildClothing()=> GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (100/140),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),

    scrollDirection: Axis.vertical,
    itemCount: MyProducts.clothing.length,
    itemBuilder: (context, index){
      final clothList = MyProducts.clothing[index];
      return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(product: clothList)
            ),
          ),
          child: ProductCard(product: clothList)
      );
    },
  );

  _buildElectronics()=> GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (100/140),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),

    scrollDirection: Axis.vertical,
    itemCount: MyProducts.electronics.length,
    itemBuilder: (context, index){
      final electronList = MyProducts.electronics[index];
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: electronList)
          ),
        ),
          child: ProductCard(product: electronList)
      );
    },
  );

  _buildGroceries()=> GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (100/140),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),

    scrollDirection: Axis.vertical,
    itemCount: MyProducts.groceries.length,
    itemBuilder: (context, index){
      final groceriesList = MyProducts.groceries[index];
      return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(product: groceriesList)
            ),
          ),
          child: ProductCard(product: groceriesList)
      );
    },
  );

  _buildProductCategory({required int index, required String name}) =>
      GestureDetector(
        onTap: (){
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
            width: 100,
            height: 40,
            margin: const EdgeInsets.only(top:10, right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected == index ? Colors.red : Colors.red.shade300,
            ),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            )
        ),
      );

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "Our Products",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductCategory(index: 0, name: "Electronics"),
              _buildProductCategory(index: 1, name: "Furniture"),
              _buildProductCategory(index: 2, name: "Appliances"),
            ],
          ),
          const SizedBox(height:20),
          Expanded(
            child: isSelected == 0
                ? _buildElectronics()
                :isSelected ==1
                ? _buildClothing()
                : _buildGroceries(),
          ),
        ],
      ),
    );
  }
}