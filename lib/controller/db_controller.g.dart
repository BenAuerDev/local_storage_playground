// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseControllerHash() =>
    r'b7cd3254635e8edffb49dd8a45d24cd32a048ed7';

/// See also [databaseController].
@ProviderFor(databaseController)
final databaseControllerProvider = AutoDisposeProvider<DBController>.internal(
  databaseController,
  name: r'databaseControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseControllerRef = AutoDisposeProviderRef<DBController>;
String _$databaseHash() => r'8163176114b0fa7835d267bc95fdbe0231cbc9d1';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeFutureProvider<Database?>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseRef = AutoDisposeFutureProviderRef<Database?>;
String _$flashlistsHash() => r'e5f3a2b80a156104f962e5bf5f0119b697f724cf';

/// See also [flashlists].
@ProviderFor(flashlists)
final flashlistsProvider = AutoDisposeFutureProvider<List<Flashlist>>.internal(
  flashlists,
  name: r'flashlistsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$flashlistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlashlistsRef = AutoDisposeFutureProviderRef<List<Flashlist>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
