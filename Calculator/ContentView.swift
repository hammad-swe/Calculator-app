//
//  ContentView.swift
//  Calculator
//
//  Created by Hammad Ali on 25/09/2025.
//

import SwiftUI

struct ContentView: View {
  
    @State private var displayText: String = "0"
    @State private var currentInput: String = ""
    @State private var storedValue: Double? = 0
    @State private var currentOperator: String?
    
    var body: some View {
        
        ZStack {
            Color(.black).ignoresSafeArea()
            
            
            VStack {
               
                Spacer()
                Text(displayText)
                                .font(.system(size: 80))
                                .foregroundColor(Color.white)
                                .padding(.trailing, 20)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                calculatorbtnRow(buttons: ["7","8","9","/"], action: buttonTap)
                calculatorbtnRow(buttons: ["4","5","6","*"], action: buttonTap)
                calculatorbtnRow(buttons: ["1","2","3","-"], action: buttonTap)
                calculatorbtnRow(buttons: [".","0","=","+"], action: buttonTap)
                calculatorbtnRow(buttons: ["C"], action: {button in clearbtn()})
                

            }
            .padding()
        }
        
    }
    func buttonTap(_ button:String){
        switch button{
        case "+","-","*","/" :
            currentOperator = button
            storedValue = Double(currentInput)
            currentInput = ""
        case "=" :
            if let operatorType = currentOperator,
         let storedValue = storedValue,
                let CurrentValue = Double(currentInput){
                    let result:Double
                    
                    switch operatorType{
                    case "+" :
                        result = storedValue + CurrentValue
                    case "-" :
                        result = storedValue - CurrentValue
                    case "*" :
                        result = storedValue * CurrentValue
                    case "/" :
                        result = storedValue / CurrentValue
                    default :
                        fatalError("Unknown Operator")
                    }
                    currentInput = "\(result)"
                    currentOperator = nil
                }
        case "." :
            currentInput += button
        default:
            currentInput += button
        }
        if currentInput.isEmpty{
            displayText = "0"
        } else {
            displayText = currentInput
        }
        
    }
    func clearbtn(){
        currentInput = ""
        storedValue = nil
        currentOperator = nil
        displayText = "0"
    }
    
}




struct calculatorbtnRow: View{
    let buttons: [String]
    let action: (String) ->Void
    let buttonSize = (UIScreen.main.bounds.width - 5 * 12) / 4
   
    
    
    var body: some View{
        
        HStack(spacing: 12){
            ForEach(buttons, id: \.self){ buttonLabel in
                Button(action: {
                    action(buttonLabel)
                }) {
                    Text(buttonLabel)
                        .font(.title)
                        .frame(width: buttonSize, height: buttonSize)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(buttonSize)
                }
                
                
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
