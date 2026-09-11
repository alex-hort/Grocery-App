//
//  GroceryCategoriesListScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 05/09/26.
//

import SwiftUI

struct GroceryCategoriesListScreen: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    @EnvironmentObject private var appState: AppState
    
    
    private func deleteGroceryCategory(at offsets: IndexSet){
        offsets.forEach { i in
            let groceryCategories = model.groceryCategories[i]
            Task{
                do{
                    try await model.deleteGroceryCategory(groceryCategoryId: groceryCategories.id)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.7)
                    .shadow(radius: 2)
                
                VStack{
                    
                    if model.groceryCategories.isEmpty{
                        Text("No grocery categories found.")
                            .fontWeight(.heavy)
                    } else {
                        List {
                            ForEach(model.groceryCategories) { category in
                                NavigationLink(value: Route.groceryCategoryDetail(category)) {
                                    
                                }
                                CategoryRow(category: category)
                            }
                            .onDelete(perform: deleteGroceryCategory)
                        }   .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                }.padding(.horizontal)
                .navigationBarBackButtonHidden(true)
           
                
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                model.logout()
                                appState.routes.append(.login)
                            } label: {
                                Image(systemName: "door.left.hand.open")
                                
                            }.padding()
                            
                        }
                        
                        ToolbarItem(placement: .topBarTrailing){
                            Button{
                                isPresented = true
                            }label: {
                                Image(systemName: "plus")
                            }.padding()
                        }
                    }.sheet(isPresented: $isPresented) {
                        NavigationStack{
                            AddGroceryCategoryScreen()
                        }
                    }
            }
            .task {
                try? await model.populateGroceryCategories()
            }
        }
    }
}

#Preview {
    
    GroceryCategoriesListScreen().environmentObject(GroceryModel())
}
