// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qoute_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchQuotes)
const fetchQuotesProvider = FetchQuotesProvider._();

final class FetchQuotesProvider
    extends $FunctionalProvider<AsyncValue<Quote>, Quote, FutureOr<Quote>>
    with $FutureModifier<Quote>, $FutureProvider<Quote> {
  const FetchQuotesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fetchQuotesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchQuotesHash();

  @$internal
  @override
  $FutureProviderElement<Quote> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Quote> create(Ref ref) {
    return fetchQuotes(ref);
  }
}

String _$fetchQuotesHash() => r'09ae84440a4b2561ba2ea7dbe5758af3b6ecdbea';
