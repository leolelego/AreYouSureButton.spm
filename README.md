AreYouSureButton -  
---

> A Simple Button that ask if you are sure to do what you want to do. 

### How to Use

add the SPM to your project : https://github.com/leolelego/AreYouSureButton.spm.git

add the selected `AreYouSureButton` in your Project. 

### Sample Code 

```swift
VStack{
    // Simple button
    AreYouSureButton("Delete") {
        print("Action confirmed")
    }
    
    // Customised one
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
```