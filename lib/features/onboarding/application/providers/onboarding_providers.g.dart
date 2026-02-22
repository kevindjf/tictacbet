// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingDatasourceHash() =>
    r'317b93dd84e83d80d113ba034a6be78c3baff9d9';

/// See also [onboardingDatasource].
@ProviderFor(onboardingDatasource)
final onboardingDatasourceProvider =
    Provider<OnboardingLocalDatasource>.internal(
      onboardingDatasource,
      name: r'onboardingDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingDatasourceRef = ProviderRef<OnboardingLocalDatasource>;
String _$onboardingCompletedHash() =>
    r'ac72e088cf436bff4577e8a9834bcf3d7658bc88';

/// See also [OnboardingCompleted].
@ProviderFor(OnboardingCompleted)
final onboardingCompletedProvider =
    NotifierProvider<OnboardingCompleted, bool>.internal(
      OnboardingCompleted.new,
      name: r'onboardingCompletedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingCompletedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingCompleted = Notifier<bool>;
String _$onboardingControllerHash() =>
    r'e022c677526f97717e4cbc100395571b2616d268';

/// See also [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingStep?>.internal(
      OnboardingController.new,
      name: r'onboardingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingController = Notifier<OnboardingStep?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
