// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingBoxHash() => r'c74cc6b3afe79c14a6fc13696d37e1f18348066e';

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
    r'37d2505c98d08ea4e683ea1c5ec43407c1a02d3e';

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
    r'89a18f2999b7a214dc16f5faa54a8c81add24420';

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
    r'2ee930ad54d3ee9336006ac8646237227db317a6';

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
    r'7cf95b6e57aa49c5aaba3a1b9262983111dabb3b';

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
    r'7f32121871acd17619083f33da8f52c27674fb12';

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
