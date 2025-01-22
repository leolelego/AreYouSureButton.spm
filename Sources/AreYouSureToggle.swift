import SwiftUI

public struct AreYouSureToggle<Label: View>: View {
    @Binding var isOn: Bool
    let confirmationTitle: String
    let confirmationMessage: String
    let confirmationButton: String
    let cancelButton: String
    let label: () -> Label
    let confirmOnEachToggle: Bool
    
    @State private var pendingState: Bool? = nil
    @State private var showConfirmation = false
    
    public var body: some View {
        Toggle(isOn: Binding(
            get: { isOn },
            set: { newValue in
                if confirmOnEachToggle || (!isOn && newValue) {
                    pendingState = newValue
                    showConfirmation.toggle()
                } else {
                    isOn = newValue
                }
            }
        )) {
            label()
        }
        .alert(confirmationTitle, isPresented: $showConfirmation) {
            Button(cancelButton, role: .cancel) {
                pendingState = nil // Reset pending state
            }
            Button(confirmationButton, role: .destructive) {
                if let pendingState = pendingState {
                    isOn = pendingState
                }
                self.pendingState = nil // Reset after confirmation
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    public init(
        isOn: Binding<Bool>,
        confirmationTitle: String? = nil,
        confirmationMessage: String? = nil,
        confirmationButton: String? = nil,
        cancelButton: String? = nil,
        confirmOnEachToggle: Bool = false,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isOn = isOn
        self.confirmationTitle = confirmationTitle ?? "Are You Sure?"
        self.confirmationMessage = confirmationMessage ?? "This action cannot be undone."
        self.confirmationButton = confirmationButton ?? "Continue"
        self.cancelButton = cancelButton ?? "Cancel"
        self.confirmOnEachToggle = confirmOnEachToggle
        self.label = label
    }
}

@available(iOS 17, *)
#Preview {
    @Previewable @State var isFeatureEnabled = false
    VStack {
        // Example Toggle Usage
        AreYouSureToggle(
            isOn: $isFeatureEnabled,
            confirmationTitle: "Toggle Confirmation",
            confirmationMessage: "Are you sure you want to toggle this setting?",
            confirmationButton: "Yes",
            cancelButton: "No",
            confirmOnEachToggle: false) {
                Text("Enable Feature")
                    .bold()
            }
    }
    .padding()
}
