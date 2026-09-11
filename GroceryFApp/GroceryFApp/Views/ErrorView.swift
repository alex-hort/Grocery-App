//
//  ErrorView.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 09/09/26.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    
    
    var body: some View {
        VStack{
            Text("Error has ocurred in the application.")
                .font(.headline)
                .padding([.bottom], 10)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guiadance)
                .font(.caption)
        }.padding(.horizontal)
    }
}


enum SampleError: Error{
    case operationFailed
}

#Preview {
    
   
    ErrorView(errorWrapper: ErrorWrapper(error: SampleError.operationFailed, guiadance: "Operationhas failed. Please try again later."))
}
