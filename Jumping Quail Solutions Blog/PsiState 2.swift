//
//  PsiState.swift
//  Jumping Quail Solutions Blog
//
//  Created by Ryan David Oates on 7/22/25.
//

import Foundation
import SwiftUI

// MARK: - PsiState Model

struct PsiState: Identifiable, Codable {
    let id = UUID()
    var symbolicScore: Double
    var neuralScore: Double
    var alpha: Double
    var rcog: Double
    var reff: Double
    var alertMessage: String?
    var timestamp: Date


    var divergence: Double {
        abs(symbolicScore - neuralScore)
    }

    var isOverloaded: Bool {
        rcog > 0.5 || abs(alpha - 0.5) > 0.4
    }
}

// MARK: - PsiDashboardView

struct PsiDashboardView: View {
    @State private var psiStates: [PsiState] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Ψ(x) Sanity Monitor")
                .font(.title2)
                .padding(.bottom)

            ForEach(psiStates) { state in
                psiStateCard(state)
            }
        }
        .padding()
        .onAppear {
            simulatePsiUpdates()
        }
    }

    @ViewBuilder
    func psiStateCard(_ state: PsiState) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("🕒 \(state.timestamp.formatted())")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                Text("S(x): \(state.symbolicScore, specifier: "%.2f")")
                Spacer()
                Text("N(x): \(state.neuralScore, specifier: "%.2f")")
                Spacer()
                Text("α(t): \(state.alpha, specifier: "%.2f")")
            }
            HStack {
                Text("R₁: \(state.rcog, specifier: "%.2f")")
                Spacer()
                Text("R₂: \(state.reff, specifier: "%.2f")")
            }
            if let alert = state.alertMessage {
                Text("⚠️ \(alert)")
                    .foregroundColor(.red)
                    .bold()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.secondarySystemBackground)))
        .padding(.bottom, 8)
    }

    func simulatePsiUpdates() {
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            let s = Double.random(in: 0.2...0.9)
            let n = Double.random(in: 0.6...1.0)
            let a = Double.random(in: 0.1...1.0)
            let rc = Double.random(in: 0.0...0.7)
            let re = Double.random(in: 0.0...0.5)

            let alert: String? =
                rc > 0.5 ? "Cognitive overload detected" :
                (s < 0.3 && n > 0.8) ? "Symbolic drift into neural flood" :
                (abs(a - 0.5) > 0.4) ? "Modulation instability" : nil

            let newState = PsiState(
                symbolicScore: s,
                neuralScore: n,
                alpha: a,
                rcog: rc,
                reff: re,
                alertMessage: alert,
                timestamp: Date()
            )

            psiStates.insert(newState, at: 0)
            if psiStates.count > 10 { psiStates.removeLast() }
        }
    }
}
