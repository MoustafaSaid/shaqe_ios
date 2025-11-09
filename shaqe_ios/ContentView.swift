//
//  ContentView.swift
//  shaqe_ios
//
//  Created by moustafa on 09/11/2025.
//

import SwiftUI
import CoreMotion

// MARK: - Shake Detection via UIKit Bridge
class ShakeDetectorViewController: UIViewController {
    var onShake: (() -> Void)?

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            onShake?()
        }
    }
}

// MARK: - UIViewControllerRepresentable Wrapper
struct ShakeDetectorRepresentable: UIViewControllerRepresentable {
    var onShake: () -> Void
    
    func makeUIViewController(context: Context) -> ShakeDetectorViewController {
        let controller = ShakeDetectorViewController()
        controller.onShake = onShake
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ShakeDetectorViewController, context: Context) {}
}

// MARK: - Main SwiftUI View
struct ContentView: View {
    @State private var currentQuote: String = ""
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    private let motionManager = CMMotionManager()
    @State private var lastShakeTime: TimeInterval = 0
    
    private let shakeThreshold: Double = 2.5
    private let shakeTimeLapse: TimeInterval = 0.5
    
    private let quotes = [
        "Believe you can and you're halfway there. - Theodore Roosevelt",
        "The only way to do great work is to love what you do. - Steve Jobs",
        "Success is not final, failure is not fatal. - Winston Churchill",
        "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
        "The future belongs to those who believe in their dreams. - Eleanor Roosevelt",
        "You are never too old to set another goal. - C.S. Lewis",
        "It always seems impossible until it's done. - Nelson Mandela",
        "Start where you are. Use what you have. Do what you can. - Arthur Ashe",
        "The secret of getting ahead is getting started. - Mark Twain",
        "Don't limit yourself. Many people limit themselves to what they think they can do.",
        "Study hard what interests you the most in the most undisciplined way. - Richard Feynman",
        "Education is the passport to the future. - Malcolm X",
        "The expert in anything was once a beginner. - Helen Hayes",
        "Learning never exhausts the mind. - Leonardo da Vinci",
        "Stay focused, go after your dreams and keep moving toward your goals. - LL Cool J"
    ]
    
    var body: some View {
        ZStack {
            // 🌈 Gradient background
            LinearGradient(
                colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "iphone.radiowaves.left.and.right")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .shadow(radius: 8)
                    .padding(.top, 40)
                
                Text("Shake for Motivation")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 20) {
                    Image(systemName: "quote.bubble.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                        .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text(currentQuote)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 0.4), value: opacity)
                        .padding()
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                .scaleEffect(scale)
                .animation(.spring(), value: scale)
                .padding(.horizontal, 24)
                
                Spacer()
                
                Text("🤳 Shake your phone to get a new quote")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.bottom, 30)
            }
            
            // 👇 Hidden UIKit view for simulator shake detection
            ShakeDetectorRepresentable {
                onShakeDetected()
            }
            .allowsHitTesting(false)
        }
        .onAppear {
            displayRandomQuote()
            startMotionDetection()
        }
        .onDisappear {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    // MARK: - Shake Logic
    private func displayRandomQuote() {
        currentQuote = quotes.randomElement() ?? "Stay motivated!"
    }
    
    private func startMotionDetection() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer not available (using simulator fallback)")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { data, _ in
            guard let data = data else { return }
            detectShake(data: data)
        }
    }
    
    private func detectShake(data: CMAccelerometerData) {
        let currentTime = Date().timeIntervalSince1970
        guard (currentTime - lastShakeTime) > shakeTimeLapse else { return }
        
        let acceleration = sqrt(
            pow(data.acceleration.x, 2) +
            pow(data.acceleration.y, 2) +
            pow(data.acceleration.z, 2)
        )
        
        if acceleration > shakeThreshold {
            lastShakeTime = currentTime
            onShakeDetected()
        }
    }
    
    private func onShakeDetected() {
        withAnimation(.easeOut(duration: 0.2)) {
            opacity = 0.0
            scale = 0.95
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            displayRandomQuote()
            withAnimation(.spring()) {
                opacity = 1.0
                scale = 1.0
            }
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

