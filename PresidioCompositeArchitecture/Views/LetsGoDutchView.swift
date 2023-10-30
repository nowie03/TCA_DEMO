//
//  LetsGoDutchView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct LetsGoDutch: View {

    @FocusState var isFocussed:Bool 
    let tipPercentages = [10,15,20]

    
    let store : StoreOf<LGDFeature>
   
    var body: some View {
        WithViewStore(self.store, observe: {$0}){ viewStore in
            Form {
                Section("Enter Bill Amount"){
                    TextField("Hello", text: viewStore.binding(
                        get: { state in
                            String(format: "%.2f", state.billAmount)
                        },
                        send: { value in
                            .updateBillAmount(Double(value) ?? 0.0)
                        }
                    ))
                }
                
                
                Section("Select a Tip"){
                    
                    Picker(selection: viewStore.binding(
                        get: { state in
                            state.tip
                        },
                        send: { value in
                                .updateTipAmount(Int(value))
                        }
                    ), label: Text("Choose a tip")){
                        ForEach(tipPercentages, id: \.self){
                            tip in
                            Text("\(tip)")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section{
                    Picker(selection:  viewStore.binding(get: { state in
                        state.noOfPeople
                    }, send: { value in
                            .updatePeople(value)
                    }), label: Text("Number of People")){
                        ForEach(viewStore.peoples,id:\.self){
                            n in
                            Text("\(n)")
                        }
                    }
                }
                
                Section("Amount per Person"){
                    Text("\(viewStore.amountPerson)")
                }
                
            }.navigationTitle("Lets Go Dutch")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Button("Done"){
                            isFocussed = false
                        }
                    }
                }
        }
        
    }
}
#Preview {
    LetsGoDutch(
        store : Store(initialState: LGDFeature.State(), reducer: {
            LGDFeature()._printChanges()
        })
    )
}





struct LGDFeature: Reducer {
    var body: some ReducerOf<Self> {
      Reduce { state, action in
          switch action{
          case .updateBillAmount(let value):
              state.billAmount = value
              state.amountPerson = calculate(state.billAmount, state.tip, state.noOfPeople)
              return .none
      case .updateTipAmount(let value):
          state.tip = value
        state.amountPerson = calculate(state.billAmount, state.tip, state.noOfPeople)
          return .none
          case .updatePeople(let value):
              state.noOfPeople = value
              state.amountPerson = calculate(state.billAmount, state.tip, state.noOfPeople)
              return .none
          }
      }
    }
    
    struct State : Equatable{
        var billAmount = 200.0
        var tip = 0
        var noOfPeople = 2
        var amountPerson = 0.0
        var peoples = [2,3,4,5,6]
      }
    enum Action {
        case updateBillAmount(Double)
        case updateTipAmount(Int)
        case updatePeople(Int)
     }
    func calculate(_ billAmount : Double, _ tip : Int, _ numberOfPeople : Int)->Double{
        let tipPlusBill = billAmount + (billAmount * (Double(tip)/100.0))
       return tipPlusBill/Double(numberOfPeople)
    }
}
