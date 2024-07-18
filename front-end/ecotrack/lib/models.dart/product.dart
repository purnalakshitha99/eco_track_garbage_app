import 'package:flutter/material.dart';

class product{
  final String image,title,description;
  final int size,id;
  final Color color;
  final double price;

  product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color
  });
}
List<product> products = [
  product(
    id: 1,
    image:"asset/images/1a8a6ac05e82a7d9b5ddcd225c5e7384.jpg",
    title: "Glass Light",
    price: 1000.00,
    description: "dummy text",
    size: 12,
    color: const Color(0xff46A74A)
  ),
    product(
    id: 1,
    image:"asset/images/lighting-fixtures-glass-recycling-ideas-11.jpg",
    title: "Glass Light",
    price: 1000.00,
    description: "dummy text",
    size: 12,
    color: const Color(0xff46A74A)
  )
];