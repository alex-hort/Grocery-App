//
//  RegistrationScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 28/08/26.
//


import SwiftUI
import GroceryAppSharedDTO

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState

    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    @Namespace private var namespace
    
    private func register() async{
        do {
            let registerResponseDTO = try await model.register(name: name, username: username, password: password)
            
            if !registerResponseDTO.error{
                //take the user to the login screen
                appState.routes.append(.login)
            } else {
                errorMessage = registerResponseDTO.reason ?? ""
                
            }
        } catch  {
            errorMessage = error.localizedDescription

        }
    }

    private var isFormValid: Bool {
        !name.isEmptyOrWhiteSpace &&
        !username.isEmptyOrWhiteSpace &&
        !password.isEmptyOrWhiteSpace &&
        password.count >= 6 &&
        password.count <= 10
    }

    var body: some View {
        VStack(spacing: 0) {

            Image(.registergrocery)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
                .ignoresSafeArea()
                .opacity(0.9)

            VStack{
                Text("Grocery")
                    .font(.largeTitle)
                    .fontWeight(.ultraLight)
                    .padding(.top, -30)
                
            
                    Text("Create your account!")
                
            }

            VStack {

                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)

                Divider()

                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                Divider()

                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                Divider()
            }
            .padding(.horizontal)
            

            Spacer()
                .padding(.bottom)
             

            VStack(spacing: 12) {
                Button {
                    Task { await register() }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(.mint)
                        .overlay {
                            Text("Register")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .matchedGeometryEffect(id: "buttonRegister", in: namespace)
                        }
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.5)
                
                Spacer()
                

                Button {
                    appState.routes.append(.login)
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(.cyan)
                        .overlay {
                            Text("Already have an account? Login")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .matchedGeometryEffect(id: "buttonLogin", in: namespace)
                                .padding(.horizontal)
                        }
                        
                }
                .opacity(0.8)
                

            }

            Spacer()
                .padding(.bottom)
        }
       
    }
}



#Preview {
    RegistrationScreen()
        .environmentObject(GroceryModel())
        .environmentObject(AppState())
}
