import 'package:apnidhukan/core/remote_db/api_service.dart';
import 'package:apnidhukan/products/domain/category.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProductsRepository {
  final _tag = "=== $ProductsRepository =======>> ";
  final _select =
      'id,title,description,category,price,discountPercentage,rating,images,brand';

  final Dio dio = ApiService.dio;

  //fetch('https://dummyjson.com/products')
  //fetch('https://dummyjson.com/products?limit=10&skip=10&select=title,price')
  Future<List<ProductItem>> getProducts() async {
    final targetUrl = "products";
    try {
      final response = await dio.get(
        targetUrl,
        queryParameters: {'limit': 10, 'select': _select},
      );

      // response.data is a Map<String, dynamic>
      final data = response.data;

      // Extract "products" as a list
      final productsJson = data['products'] as List<dynamic>?;

      if (productsJson == null) return [];

      return productsJson.map((p) => ProductItem.fromJson(p)).toList();
    } catch (error) {
      debugPrint("$_tag, Error in getProducts -- $error");
      return [];
    }
  }

  //fetch('https://dummyjson.com/products/category/smartphones')
  Future<List<ProductItem>> getProductsWithCategory(String targetUrl) async {
    try {
      final response = await dio.get(
        targetUrl,
        queryParameters: {'limit': 5, 'select': _select},
      );

      // response.data is a Map<String, dynamic>
      final data = response.data;

      // Extract "products" as a list
      final productsJson = data['products'] as List<dynamic>?;

      if (productsJson == null) return [];

      return productsJson.map((p) => ProductItem.fromJson(p)).toList();
    } catch (error) {
      debugPrint("$_tag, Error in getProducts with category -- $error");
      return [];
    }
  }

  //fetch('https://dummyjson.com/products/search?q=phone')
  Future<List<ProductItem>> getProductsWithQuery(String query) async {
    final targetUrl = "products/search";
    try {
      final response = await dio.get(
        targetUrl,
        queryParameters: {'q': query, 'limit': 5, 'select': _select},
      );

      // response.data is a Map<String, dynamic>
      final data = response.data;

      // Extract "products" as a list
      final productsJson = data['products'] as List<dynamic>?;

      if (productsJson == null) return [];

      return productsJson.map((p) => ProductItem.fromJson(p)).toList();
    } catch (error) {
      debugPrint("$_tag, Error in getProducts with search query -- $error");
      return [];
    }
  }

  //fetch('https://dummyjson.com/products/categories')
  Future<List<Category>> getCategoriesList() async {
    const targetUrl = 'products/categories';

    try {
      final response = await dio.get(targetUrl);

      final categoriesJson = response.data as List<dynamic>?;

      if (categoriesJson == null) return [];

      final categories = categoriesJson
          .map((c) => Category.fromJson(c))
          .toList();

      debugPrint("$_tag Categories fetched: $categories");
      return categories;
    } catch (error) {
      debugPrint("$_tag Error in getCategoriesList -- $error");
      return [];
    }
  }

  Future<String?> getCategoryThumbnail(String targetUrl) async {
    try {
      final response = await dio.get(
        targetUrl,
        queryParameters: {'limit': 1, 'select': 'thumbnail'},
      );

      final data = response.data;

      final productsJson = data['products'] as List<dynamic>?;

      if (productsJson == null || productsJson.isEmpty) return null;

      final firstProduct = productsJson.first as Map<String, dynamic>;

      return firstProduct['thumbnail']?.toString();
    } catch (error) {
      // debugPrint("Error in getCategoryThumbnail -- $error");
      return null;
    }
  }
}
