import 'dart:convert';
import 'dart:io';

import 'package:fitness_tracker_app/core/extention/better_clint.dart';
import 'package:fitness_tracker_app/models/quote/quote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';



part  'qoute_provider.g.dart';

@riverpod
Future<Quote> fetchQuotes(Ref ref) async {
  // Simulate fetching quotes from an API
  final clint = await ref.getBetterClint();
  final reposne  = await clint.get(Uri.parse("https://dummyjson.com/quotes/random"));
  if(reposne.statusCode ==200){
    final body = jsonDecode(reposne.body) ;//as Map<String, dynamic>;
    return Quote.fromJson(body);

  }else{
    throw Exception("Failed to load quote");
  }
}