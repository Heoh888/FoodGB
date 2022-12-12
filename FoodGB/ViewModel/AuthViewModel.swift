//
//  AuthViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import FirebaseAuth
import FirebaseAnalytics

class AuthViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var warning: String = ""
    
    // MARK: - Singleton AuthViewModel
    static let shared = AuthViewModel()
    
    // MARK: - Private properties
    private let service: NetworkServiceProtocol!
    
    // MARK: - Initialisation
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.userSession = Auth.auth().currentUser
        self.service = service
        self.getUser()
    }
    
    // MARK: - Functions
    func getUser() {
        guard let uid = userSession?.uid else { return }
        service.getUser(id: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.currentUser = user
            case let .failure(error):
                self.warning = error.localizedDescription
            }
        }
    }
    
    func login(withEmail email: String, password: String) {
        service.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let session):
                self.userSession = session
                Analytics.logEvent("Successful_login", parameters: [AnalyticsParameterContentType: "cont"])
                self.getUser()
            case let .failure(error):
                self.warning = error.localizedDescription
                Analytics.logEvent("Unsuccessful_login", parameters: ["status": error.localizedDescription])
            }
        }
    }
    
    func register(withEmail email: String, password: String, userName: String) {
        service.register(withEmail: email, password: password, userName: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.userSession = user
                self.getUser()
                Analytics.logEvent("Registration", parameters: [AnalyticsParameterContentType: "cont"])
            case let .failure(error):
                self.warning = error.localizedDescription
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        service.signout()
        Analytics.logEvent("Exit", parameters: [AnalyticsParameterContentType: "cont"])
    }
}
