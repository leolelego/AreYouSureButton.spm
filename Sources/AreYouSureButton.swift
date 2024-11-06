//
//  AreYouSureButton.swift
//  ShadeFinder
//
//  Created by Léo on 05/11/2024.
//
import SwiftUI

struct AreYouSureButton<Label: View> : View {
    let action: () -> Void
    let label: () -> Label
    let confirmationTitle: String
    let confirmationMessage: String
    let confirmationButton: String
    let cancelButton: String
    
    
    @State private var showConfirmation = false
    
    var body: some View {
        Button {
            showConfirmation.toggle()
        } label: {
            label()
        }
        .alert(confirmationTitle, isPresented: $showConfirmation) {
            Button(cancelButton, role: .cancel) { }
            Button(confirmationButton, role: .destructive) {
                action()
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    init(_ title: String,
         confirmationTitle: String? = nil,
         confirmationMessage: String? = nil,
         confirmationButton: String? = nil ,
         cancelButton: String? = nil,
         action: @escaping () -> Void
    ) where Label == Text {
        self.init(confirmationTitle: confirmationTitle,
                  confirmationMessage: confirmationMessage,
                  confirmationButton: confirmationButton,
                  cancelButton: cancelButton,
                  action: action,
                  label:  {Text(title).bold()})
    }
    
    init(
        confirmationTitle: String? = nil,
        confirmationMessage: String? = nil,
        confirmationButton: String? = nil ,
        cancelButton: String? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
        self.confirmationTitle = confirmationTitle ?? "Are You Sure?"
        self.confirmationMessage = confirmationMessage ?? "This action cannot be undone."
        self.confirmationButton = confirmationButton ?? "Continue"
        self.cancelButton = cancelButton ?? "Cancel"
        
    }
}
#Preview {
    VStack{
        // Simple button
        AreYouSureButton("Delete") {
            print("Action confirmed")
        }
        
        // More complexe one
        AreYouSureButton(
            confirmationTitle: "You sure about that?", // Optional
            confirmationMessage: "are you REAALLY Sure?? ", // Optional
            confirmationButton: "Yeap! ", // Optional
            cancelButton: "Neaaaah" // Optional
        ) {
            print("Deleted !")
        } label: {
            HStack {
                Image(systemName: "trash")
                Text("Delete")
                    .bold().font(.title)
            }
        }
    }
}
