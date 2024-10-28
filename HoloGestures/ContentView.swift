//
//  ContentView.swift
//  HoloGestures
//
//  Created by Mahir Saeed on 28/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLetter = "S"
    @State private var selectedEmoji = "🖥️"
    @State private var xRotation: Double = 0
    @State private var yRotation: Double = 0
    
    let letters = ["S", "W", "I", "F", "T", "U", "I"]
    let emojis = ["🖥️", "📀", "📡", "🔋", "🎮", "🔌", "💾"]
    
    // Apple color palette for each letter
    let letterColorPalettes: [String: [Color]] = [
        "S": [
            Color.red.opacity(0.3),
            Color.red.opacity(0.4),
            Color.red.opacity(0.5),
            Color.red.opacity(0.6),
            Color.red.opacity(0.7),
        ],
        "W": [
            Color.blue.opacity(0.3),
            Color.blue.opacity(0.4),
            Color.blue.opacity(0.5),
            Color.blue.opacity(0.6),
            Color.blue.opacity(0.7),
        ],
        "F": [
            Color.yellow.opacity(0.3),
            Color.yellow.opacity(0.4),
            Color.yellow.opacity(0.5),
            Color.yellow.opacity(0.6),
            Color.yellow.opacity(0.7),
        ],
        "T": [
            Color.orange.opacity(0.3),
            Color.orange.opacity(0.4),
            Color.orange.opacity(0.5),
            Color.orange.opacity(0.6),
            Color.orange.opacity(0.7),
        ],
        "U": [
            Color.purple.opacity(0.3),
            Color.purple.opacity(0.4),
            Color.purple.opacity(0.5),
            Color.purple.opacity(0.6),
            Color.purple.opacity(0.7),
        ],
        "I": [
            Color.pink.opacity(0.3),
            Color.pink.opacity(0.4),
            Color.pink.opacity(0.5),
            Color.pink.opacity(0.6),
            Color.pink.opacity(0.7),
        ]
    ]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<5) { index in
                    if let selectedColors = letterColorPalettes[selectedLetter], index < selectedColors.count {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(selectedColors[index])
                            .frame(width: CGFloat(300 - (index * 50)), height: CGFloat(300 - (index * 50)))
                            .rotation3DEffect(.degrees(Double(index * 5)), axis: (x: 1, y: 1, z: 0))
                            .shadow(radius: CGFloat(20 - index * 4))
                    }
                }
                
                Text(selectedEmoji)
                    .font(.system(size: 40))
                    .offset(x: -5)
            }
            .frame(width: 400, height: 400)
            .rotation3DEffect(.degrees(xRotation), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(.degrees(yRotation), axis: (x: 0, y: 1, z: 0))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        xRotation = Double(value.translation.height / 5)
                        yRotation = Double(value.translation.width / 5)
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            xRotation = 0
                            yRotation = 0
                        }
                    }
            )
            .padding(.bottom, 40)
            
            HStack(spacing: 5) {
                ForEach(0..<letters.count) { index in
                    Text(letters[index])
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(letterColorPalettes[letters[index]]?[2] ?? Color.gray)
                        .cornerRadius(25)
                        .onTapGesture {
                            selectedLetter = letters[index]
                            selectedEmoji = emojis[index]
                        }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
