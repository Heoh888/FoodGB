//
//  AuthView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI

struct AuthView: View {
    
    // MARK: - Properties
    @State var view = "Login"
    @State var userName = ""
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel

    // MARK: - Private properties
    private var width = UIScreen.main.bounds.width
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
                .ignoresSafeArea()
            VStack {
                
                VStack {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.white)
                        
                        VStack {
                            Image("logo")
                                .frame(width: 136)
                                .padding(.bottom)
                            HStack {
                                Button {
                                    withAnimation {
                                        view = "Login"
                                        viewModel.warning = ""
                                    }
                                } label: {
                                    Text("Login")
                                        .font(.system(size: 18, weight: .semibold))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                }
                                
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        view = "Sign-up"
                                        viewModel.warning = ""
                                    }
                                } label: {
                                    Text("Sign-up")
                                        .font(.system(size: 18, weight: .semibold))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                }
                            }
                            .padding(.top, 50.0)
                            .padding(.horizontal, 80)
                            .padding(.bottom)
                            
                            Rectangle()
                                .fill(Color("MainColor"))
                                .frame(width: 120, height: 3)
                                .offset(x: view == "Sign-up" ? 85 :  -85)
                        }
                    }
                    .frame(width: width, height: 350)
                    .cornerRadius(30)
                }
                .shadow(radius: 10)
                
                Text(viewModel.warning)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("MainColor"))
                    .padding(.top)
                    .padding(.bottom, 1)
                
                ZStack(alignment: .leading) {
                    HStack {
                        RegistrationView(userName: $userName, email: $email, password: $password)
                            .frame(width: width)
                        LoginView(email: $email, password: $password)
                            .frame(width: width)
                    }
                }
                .offset(x: view == "Sign-up" ?  width / 2 : -width / 2)
                
                Spacer()
                
                Button {
                    if view == "Sign-up" {
                        viewModel.register(withEmail: email, password: password, userName: userName)
                    } else if view == "Login" {
                        viewModel.login(withEmail: email, password: password)
                    }
                } label: {
                    Text(view == "Sign-up" ? "Register" : "Login")
                        .font(.system(size: 17, weight: .semibold))
                        .fontWeight(.bold)
                        .frame(width: 314, height: 70)
                        .background(Color("MainColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                        .padding(.bottom, 50.0)
                }
            }
            .ignoresSafeArea()
        }
        .keyboardAdaptive()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
