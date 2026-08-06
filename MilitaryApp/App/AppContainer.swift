//
//  AppContainer.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The composition root / hand-rolled dependency container.
///
/// Constructs the single infrastructure objects (token store + API client),
/// wires the live repositories over them, and exposes factory methods that
/// assemble feature stores with their use cases. Built once in
/// `MilitaryAppApp` and threaded down the view tree.
final class AppContainer {

    // MARK: Infrastructure
    let tokenStore = TokenStore()
    let api: APIClient

    // MARK: Repositories (domain ports → live adapters)
    let authRepository: AuthRepository
    let profileRepository: ProfileRepository
    let homeRepository: HomeRepository
    let placesRepository: PlacesRepository
    let contentRepository: ContentRepository
    let benefitsRepository: BenefitsRepository

    init() {
        api = APIClient(tokens: tokenStore)
        authRepository = AuthRepositoryLive(api: api, tokens: tokenStore)
        profileRepository = ProfileRepositoryLive(api: api)
        homeRepository = HomeRepositoryLive(api: api)
        placesRepository = PlacesRepositoryLive(api: api)
        contentRepository = ContentRepositoryLive()
        benefitsRepository = BenefitsRepositoryLive()
    }

    // MARK: Store factories

    @MainActor
    func makeSessionStore() -> SessionStore {
        SessionStore(
            restoreSession: RestoreSessionUseCase(tokens: tokenStore, profile: profileRepository),
            deviceLogin: DeviceLoginUseCase(repository: authRepository),
            login: LoginUseCase(repository: authRepository),
            register: RegisterUseCase(repository: authRepository),
            loadProfile: LoadProfileUseCase(repository: profileRepository),
            updateProfile: UpdateProfileUseCase(repository: profileRepository),
            completeOnboarding: CompleteOnboardingUseCase(repository: profileRepository),
            logout: LogoutUseCase(tokens: tokenStore),
            deleteAccount: DeleteAccountUseCase(repository: authRepository),
            clearLocalBenefits: ClearLocalBenefitsUseCase(repository: benefitsRepository),
            seedTrackedBenefits: SeedTrackedBenefitsUseCase(repository: benefitsRepository)
        )
    }

    @MainActor
    func makeOnboardingStore() -> OnboardingStore {
        OnboardingStore(loadPlaces: LoadPlacesUseCase(repository: placesRepository))
    }

    @MainActor
    func makeHomeStore() -> HomeStore {
        HomeStore(loadEntries: LoadTrackedBenefitsUseCase(repository: benefitsRepository),
                  saveEntry: SaveTrackedBenefitUseCase(repository: benefitsRepository),
                  removeEntry: RemoveTrackedBenefitUseCase(repository: benefitsRepository),
                  loadRatings: LoadSavedRatingsUseCase(repository: benefitsRepository),
                  saveRating: SaveRatingUseCase(repository: benefitsRepository),
                  deleteRating: DeleteRatingUseCase(repository: benefitsRepository),
                  combineRatings: CalculateCombinedRatingUseCase(),
                  content: contentRepository)
    }

    @MainActor
    func makeDiscoverStore() -> DiscoverStore {
        DiscoverStore(loadPlaces: LoadPlacesUseCase(repository: placesRepository),
                      content: contentRepository)
    }
}
