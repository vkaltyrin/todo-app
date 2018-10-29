import EarlGrey

func grey_getText(onText: ((String) -> ())?) -> GREYActionBlock {
    return GREYActionBlock(
        name: "get text",
        constraints: grey_respondsToSelector(#selector(getter: UITextField.text)),
        perform: { element, errorOrNil -> Bool in
            if let textField = element as? UITextField {
                onText?(textField.text ?? "")
            }
            
            return true
    })
}
