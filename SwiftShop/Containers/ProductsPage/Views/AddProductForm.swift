//
//  AddProductForm.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

let DEFAULT_PRICE = "0.00"

struct AddProductForm: View {
    var onSubmit: (String, Float) -> ()
    @State private var name = ""
    @State private var price = DEFAULT_PRICE
    
    var body: some View {
        Form {
            Text("New Product")
                .font(.headline)
            
            TextField("Name", text: $name)
            TextField("Price", text: $price)
            Button(action: handleSubmit) {
                HStack{
                    Spacer()
                    Text("Submit")
                }
            }
        }
    }
    
    func handleSubmit() {
        guard let price = Float(price) else {
            return
        }
        
        onSubmit(name, price)
        self.name = ""
        self.price = DEFAULT_PRICE
    }
}

struct AddProductForm_Previews: PreviewProvider {
    static var previews: some View {
        AddProductForm(onSubmit: mockOnSubmit)
    }
    
    static func mockOnSubmit(name: String, price: Float) {}
}
