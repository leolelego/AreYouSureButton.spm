import SwiftUI

public struct SecureToggle<Label: View>: View {
    @Binding var isOn: Bool
    let confirmationTitle: String
    let confirmationMessage: String
    let confirmationButton: String
    let cancelButton: String
    let label: () -> Label
    let confirmOnEachToggle: Bool
    let requirePassword: Bool
    let correctPassword: String
    
    @State private var pendingState: Bool? = nil
    @State private var showPasswordPrompt = false
    @State private var enteredPassword: String = ""
    
    public var body: some View {
        Toggle(isOn: Binding(
            get: { isOn },
            set: { newValue in
                if confirmOnEachToggle || (!isOn && newValue) {
                    pendingState = newValue
                    if requirePassword {
                        showPasswordPrompt = true
                    } else {
                        isOn = newValue
                    }
                } else {
                    isOn = newValue
                }
            }
        )) {
            label()
        }
        .alert(confirmationTitle, isPresented: $showPasswordPrompt, actions: {
            SecureField("Password", text: $enteredPassword)
            Button(cancelButton, role: .cancel) {
                pendingState = nil
                enteredPassword = ""
            }
            Button(confirmationButton, role: .destructive) {
                if enteredPassword == correctPassword {
                    if let pendingState = pendingState {
                        isOn = pendingState
                    }
                    pendingState = nil
                }
                enteredPassword = ""
            }
        }, message: {
            Text(confirmationMessage)
        })
   
    }
    
    public init(
        isOn: Binding<Bool>,
        confirmationTitle: String? = nil,
        confirmationMessage: String? = nil,
        confirmationButton: String? = nil,
        cancelButton: String? = nil,
        confirmOnEachToggle: Bool = false,
        requirePassword: Bool = false,
        correctPassword: String = "",
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isOn = isOn
        self.confirmationTitle = confirmationTitle ?? "Are You Sure?"
        self.confirmationMessage = confirmationMessage ?? "This action cannot be undone."
        self.confirmationButton = confirmationButton ?? "Continue"
        self.cancelButton = cancelButton ?? "Cancel"
        self.confirmOnEachToggle = confirmOnEachToggle
        self.requirePassword = requirePassword
        self.correctPassword = correctPassword
        self.label = label
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var isFeatureEnabled = false
    VStack {
        // Example Toggle Usage
        SecureToggle(
            isOn: $isFeatureEnabled,
            confirmationTitle: "Toggle Confirmation",
            confirmationMessage: "Are you sure you want to toggle this setting?",
            confirmationButton: "Yes",
            cancelButton: "No",
            confirmOnEachToggle: false,
            requirePassword: true,
            correctPassword: "1234"
        ) {
            Text("Enable Feature")
                .bold()
        }
    }
    .padding()
}
