//
//  CountdownView.swift
//  Timer
//
//  Created by Rohit Pradhan on 08/12/23.
//

import SwiftUI

struct CountdownView: View {
    @StateObject var viewModel: CountdownViewModel
    
    var body: some View {
        VStack {
            timerView
                .padding(.all, 50)
            
            controlsView
        }
        .onAppear {
            viewModel.startTimer()
        }
    }
    
    private var timerView: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: viewModel.remainingFillValue)
                .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(.degrees(-90))
            
            Text(viewModel.timerText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .onTapGesture {
                    viewModel.toggleTimer()
                }
        }
    }
    
    private var controlsView: some View {
        HStack {
            Button(action: {
                viewModel.startPauseTimer()
            }) {
                Text(viewModel.startPauseButtonTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            
            Button(action: {
                viewModel.stopTimer()
            }) {
                Text(Constants.Strings.stop)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(viewModel: CountdownViewModel())
    }
}
