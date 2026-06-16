//
//  VideoPlayer.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 03/06/26.
//

import SwiftUI
import YouTubePlayerKit

struct WorkoutVideoPlayer: View {
    
    let videoID: String
    @Environment(\.dismiss) private var dismiss
    
    private let player: YouTubePlayer
    
    init(videoID: String) {
        self.videoID = videoID
        self.player = YouTubePlayer(
            source: .video(id: videoID),
            parameters: .init(
//                autoPlay: true,
//                showControls: false,
            )
        )
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack {
                YouTubePlayerView(player) { state in
                    switch state {
                    case .idle:
                        ProgressView()
                            .tint(.white)
                    case .ready:
                        EmptyView()
                    case .error(let error):
                        Text("Error: \(error.localizedDescription)")
                            .foregroundStyle(.red)
                    }
                }
                .aspectRatio(16/9, contentMode: .fit)
                .cornerRadius(12)
                
            }
        }
        .ignoresSafeArea()
        .onDisappear {
            Task {
                try? await player.pause()
            }
        }
    }
}

#Preview {
    WorkoutVideoPlayer(videoID: "mYlcWUii1CI")
}
