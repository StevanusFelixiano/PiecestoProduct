import SwiftUI

struct AnimatedHelloIllustration: View {
    @State private var waveHand = false
    @State private var floatAvatar = false
    @State private var floatFlowerLeft = false
    @State private var floatFlowerRight = false
    @State private var showHiBubble = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 80)
                .fill(Color(red: 0.98, green: 0.88, blue: 0.84).opacity(0.55))
                .frame(width: 190, height: 190)
                .rotationEffect(.degrees(-12))
                .offset(y: 8)
            
            RoundedRectangle(cornerRadius: 70)
                .fill(Color(red: 0.93, green: 0.88, blue: 1.0).opacity(0.35))
                .frame(width: 165, height: 165)
                .rotationEffect(.degrees(18))
                .offset(x: 10, y: -4)
            
            FlowerView(size: 40, petalColor: Color.pink.opacity(0.75))
                .offset(x: -78, y: -58)
                .offset(y: floatFlowerLeft ? -7 : 7)
                .rotationEffect(.degrees(floatFlowerLeft ? -7 : 7))
            
            FlowerView(size: 32, petalColor: Color.purple.opacity(0.6))
                .offset(x: 82, y: 42)
                .offset(y: floatFlowerRight ? 7 : -7)
                .rotationEffect(.degrees(floatFlowerRight ? 8 : -8))
            
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: 126, height: 126)
                        .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
                    
                    Circle()
                        .fill(Color(red: 0.99, green: 0.92, blue: 0.95))
                        .frame(width: 104, height: 104)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 66))
                        .foregroundStyle(Color(red: 0.74, green: 0.47, blue: 0.52))
                    
                    Image(systemName: "hand.wave.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.orange.opacity(0.95))
                        .offset(x: 40, y: -4)
                        .rotationEffect(.degrees(waveHand ? 18 : -12), anchor: .bottomLeading)
                }
                .offset(y: floatAvatar ? -7 : 7)
                
                Text("Hi, Mama")
                    .font(.headline)
                    .foregroundStyle(Color(red: 0.55, green: 0.37, blue: 0.40))
            }
            
            Text("Hi!")
                .font(.subheadline.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color(red: 0.86, green: 0.54, blue: 0.61))
                )
                .offset(x: 62, y: -72)
                .scaleEffect(showHiBubble ? 1 : 0.85)
                .opacity(showHiBubble ? 1 : 0.55)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.45).repeatForever(autoreverses: true)) {
                waveHand = true
            }
            
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                floatAvatar = true
            }
            
            withAnimation(.easeInOut(duration: 2.1).repeatForever(autoreverses: true)) {
                floatFlowerLeft = true
            }
            
            withAnimation(.easeInOut(duration: 1.7).repeatForever(autoreverses: true)) {
                floatFlowerRight = true
            }
            
            withAnimation(.spring(duration: 1.2).repeatForever(autoreverses: true)) {
                showHiBubble = true
            }
        }
    }
}

struct FlowerView: View {
    let size: CGFloat
    let petalColor: Color
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { index in
                Circle()
                    .fill(petalColor)
                    .frame(width: size * 0.34, height: size * 0.34)
                    .offset(y: -size * 0.28)
                    .rotationEffect(.degrees(Double(index) * 60))
            }
            
            Circle()
                .fill(Color.yellow.opacity(0.95))
                .frame(width: size * 0.24, height: size * 0.24)
        }
    }
}

#Preview {
    AppThemeManager {
        AnimatedHelloIllustration()
            .frame(width: 260, height: 260)
    }
}
