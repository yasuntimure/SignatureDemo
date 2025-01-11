//
//  DragGestureDemoView.swift
//  SignitureDemo
//
//  Created by Eyüp on 2023-11-02.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .gray
    var lineWidth: Double = 1.0
}

struct DragGestureDemoView: View {

    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0

    var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        let newPoint = value.location
                        currentLine.points.append(newPoint)
                        self.lines.append(currentLine)
                    })
                    .onEnded({ value in
                        self.lines.append(currentLine)
                        self.currentLine = Line()
                    })

            )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.7))
            )
            .padding(50)
            .padding(.vertical, 200)

            Spacer()

            VStack {
                Slider(value: $thickness, in: 1...20) {
                    Text("Thickness")
                }.frame(maxWidth: 200)
                    .onChange(of: thickness) { newThickness in
                        currentLine.lineWidth = newThickness
                    }
                Divider()
                ColorPickerView(selectedColor: $currentLine.color)
                    .onChange(of: currentLine.color) { newColor in
                        print(newColor)
                        currentLine.color = newColor
                    }
            }
        }

    }
}

struct ColorPickerView: View {

    let colors = [Color.red, Color.orange, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color

    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in

                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

struct Constants {

    struct Icons {
        static let plusCircle = "plus.circle"
        static let line3HorizontalCircleFill = "line.3.horizontal.circle.fill"
        static let circle = "circle"
        static let circleInsetFilled = "circle.inset.filled"
        static let exclaimationMarkCircle = "exclamationmark.circle"
        static let recordCircleFill = "record.circle.fill"
        static let trayCircleFill = "tray.circle.fill"
        static let circleFill = "circle.fill"
    }

}
