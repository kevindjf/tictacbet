// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingBoxHash() => r'28840b1dbe35a134e9ae7f45a8a577f1a70de1a9';

/// Provides the Hive onboarding box used by the onboarding repository.
///
/// Copied from [onboardingBox].
@ProviderFor(onboardingBox)
final onboardingBoxProvider = Provider<Box<dynamic>>.internal(
  onboardingBox,
  name: r'onboardingBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingBoxRef = ProviderRef<Box<dynamic>>;
String _$onboardingRepositoryHash() =>
    r'37f692e9a56987f3a95a55181ce8b0c540e97ac0';

/// Provides the onboarding repository abstraction backed by Hive.
///
/// Copied from [onboardingRepository].
@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider = Provider<OnboardingRepository>.internal(
  onboardingRepository,
  name: r'onboardingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingRepositoryRef = ProviderRef<OnboardingRepository>;
String _$checkOnboardingCompletedUseCaseHash() =>
    r'293e48be7d6ae5713aab516cd0a2542135c63659';

/// Provides the use case that reads onboarding completion state.
///
/// Copied from [checkOnboardingCompletedUseCase].
@ProviderFor(checkOnboardingCompletedUseCase)
final checkOnboardingCompletedUseCaseProvider =
    Provider<CheckOnboardingCompletedUseCase>.internal(
      checkOnboardingCompletedUseCase,
      name: r'checkOnboardingCompletedUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$checkOnboardingCompletedUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CheckOnboardingCompletedUseCaseRef =
    ProviderRef<CheckOnboardingCompletedUseCase>;
String _$completeOnboardingUseCaseHash() =>
    r'03feed5c8cd3d66555d4c154bf523ab992f329e6';

/// Provides the use case that marks onboarding as completed.
///
/// Copied from [completeOnboardingUseCase].
@ProviderFor(completeOnboardingUseCase)
final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>.internal(
      completeOnboardingUseCase,
      name: r'completeOnboardingUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$completeOnboardingUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompleteOnboardingUseCaseRef = ProviderRef<CompleteOnboardingUseCase>;
String _$resetOnboardingUseCaseHash() =>
    r'ce695ead4ff6183b15998739e71327d8808c9c62';

/// Provides the use case that resets onboarding completion state.
///
/// Copied from [resetOnboardingUseCase].
@ProviderFor(resetOnboardingUseCase)
final resetOnboardingUseCaseProvider =
    Provider<ResetOnboardingUseCase>.internal(
      resetOnboardingUseCase,
      name: r'resetOnboardingUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$resetOnboardingUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResetOnboardingUseCaseRef = ProviderRef<ResetOnboardingUseCase>;
String _$onboardingCompletedHash() =>
    r'12ac90d36427d3b6e32639eb8387f204e81e9c73';

/// Stores the persisted onboarding completion flag.
///
/// Copied from [OnboardingCompleted].
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
    r'f0f91e6a00c83a53f6a9141e44d5cdc4b45172fe';

/// Controls the in-memory onboarding step flow.
///
/// `start -> next* -> complete`, with `skip` and `reset` helpers.
///
/// Copied from [OnboardingController].
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
