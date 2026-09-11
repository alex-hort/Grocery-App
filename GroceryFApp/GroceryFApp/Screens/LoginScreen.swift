//
//  LoginScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 29/08/26.
//

import SwiftUI
import GroceryAppSharedDTO


struct LoginScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    @Namespace private var namespace
    
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace &&
        !password.isEmptyOrWhiteSpace &&
        password.count >= 6 &&
        password.count <= 10
    }
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            
         
            if loginResponseDTO.error{
                errorMessage = loginResponseDTO.reason ?? ""
                appState.errorWrapper = ErrorWrapper(error: GroceryError.login, guiadance: loginResponseDTO.reason ?? "")
                
            } else {
                //take the user to grocey categories list view
                appState.routes.append(.groceryCategoryList)
            }
        } catch  {
            errorMessage = error.localizedDescription
            appState.errorWrapper = ErrorWrapper(error: error, guiadance: "Incorret email or password")
        }
    }
    
    var body: some View {
        VStack{
            Image(.logingrocery)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
                .ignoresSafeArea()
                .opacity(0.9)
            
            Spacer()
            
            
            VStack{
                Text("Welcome to Grocery Store")
                    .font(.largeTitle)
                    .fontWeight(.ultraLight)
                    .padding(.top, -30)
                    Text("Login with your username")
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack {

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
            
            HStack{
                Button {
                    Task{
                        await login()
                        appState.routes.append(.groceryCategoryList)
                    }
                    
                    
                
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.brown)
                        .frame(width: 200, height: 50)
                        
                        .overlay {
                            Text("Login")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .matchedGeometryEffect(
                                    id: "buttonRegister",
                                    in: namespace
                                )
                        }
                 
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.5)
            }
            .sheet(item: $appState.errorWrapper) { errorW in
                ErrorView(errorWrapper: errorW)
                    .presentationDetents([.medium])
            }
            
            
            Spacer()
                .padding(.bottom)
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(GroceryModel())
        .environmentObject(AppState())
}
