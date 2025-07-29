//
//  DriftSnapshot.swift
//  Jumping Quail Solutions Blog
//
//  Created by Ryan David Oates on 7/22/25.
//

import SwiftUI

// MARK: - DriftSnapshot Model

/// Represents a single divergence reading between symbolic and neural cognition layers.
struct DriftSnapshot: Identifiable {
    let id = UUID()
    let time: Date
    let symbolic: Double
    let neural: Double

    var divergence: Double {
        abs(symbolic - neural)
    }

    var color: Color {
        switch divergence {
        case 0.0..<0.15: return .green
        case 0.15..<0.35: return .yellow
        case 0.35..<0.6: return .orange
        default: return .red
        }
    }
}

// MARK: - NeuralDriftHeatmapView

/// SwiftUI-based visual module that shows the evolving divergence between symbolic and neural pathways.
struct NeuralDriftHeatmapView: View {
    @State private var snapshots: [DriftSnapshot] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Neural Drift Heatmap")
                .font(.title2)
                .padding(.bottom)

            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(snapshots.prefix(20).reversed()) { snap in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(snap.color)
                            .frame(
                                width: geometry.size.width / 24,
                                height: CGFloat(snap.divergence) * geometry.size.height
                            )
                            .overlay(
                                Text(snap.divergence > 0.5 ? "⚠️" : "")
                                    .font(.caption2)
                                    .rotationEffect(.degrees(-45))
                                    .offset(y: -10)
                                    .foregroundStyle(.white),
                                alignment: .top
                            )
                            .animation(.easeInOut(duration: 0.4), value: snap.divergence)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 140)

            Text("Symbolic ↔ Neural divergence score | Red = High Δ | Green = Balanced")
                .font(.footnote)
                .padding(.top, 8)
        }
        .padding()
        .onAppear {
            generateMockDrift()
        }
    }

    // MARK: - Simulated Data

    /// Generates mock drift data between 0.2–1.0 for symbolic and neural values every 3 seconds.
    func generateMockDrift() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            let s = Double.random(in: 0.2...1.0)
            let n = Double.random(in: 0.2...1.0)
            let newSnapshot = DriftSnapshot(time: Date(), symbolic: s, neural: n)
            snapshots.append(newSnapshot)
            if snapshots.count > 40 { snapshots.removeFirst() }
        }
    }
}
