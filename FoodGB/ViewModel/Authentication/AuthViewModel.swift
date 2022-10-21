//
//  AuthViewModel.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import Firebase

class AuthViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    @Published var warning: String = ""
    
    static let shared = AuthViewModel()
    
    // MARK: - Initialisation
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    // MARK: - Functions
    func login(withEmail email: String, password: String) {
        print(email, password)
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.warning = error.localizedDescription
                print("DEBUG: Login failed\(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String,
                  password: String,
                  userName: String) {

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.warning = error.localizedDescription
                print(error.localizedDescription)
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            print("Successfully registered user...")
            
            let data = ["userName": userName,
                        "email": email,
                        "uid": user.uid]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("Successfully uplooader user data...")
                self.userSession = user
                self.fetchUser()
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
}
