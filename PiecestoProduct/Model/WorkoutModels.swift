//
//  WorkoutModels.swift
//  PiecestoProduct
//
//  Created by Ishandeep Singh on 03/06/26.
//

import SwiftUI

enum AppRoute: Hashable {
    case plan(EnergyState)
    case video(WorkoutVideo)
}

enum EnergyState: Int, CaseIterable, Hashable {
    case needingRest = 1
    case takingItEasy = 2
    case findingRhythm = 3
    case feelingGood = 4
    case energized = 5
    
    var title: String {
        switch self {
        case .needingRest: return "\"NEEDING REST\""
        case .takingItEasy: return "\"TAKING IT EASY\""
        case .findingRhythm: return "\"FINDING YOUR RHYTHM\""
        case .feelingGood: return "\"FEELING GOOD\""
        case .energized: return "\"ENERGIZED\""
        }
    }
    
    var description: String {
        switch self {
        case .needingRest: return "Your body has been carrying a lot lately. \nToday may be a day for slowing down and giving yourself extra care."
        case .takingItEasy: return "You have some energy, but your body may still be asking for gentle movement and moments of rest."
        case .findingRhythm: return "You're moving through the day steadily. \nListen to your body and take things at a pace that feels right."
        case .feelingGood: return "Your energy is showing up today. \nEnjoy what feels manageable while still making space for yourself."
        case .energized: return "Your body feels ready to move and engage today. \nCelebrate this moment and continue treating yourself with kindness."
        }
    }
    
    var imageName: String {
        switch self {
        case .needingRest: return "FlowerEmpty"
        case .takingItEasy: return "Flower2Petals"
        case .findingRhythm: return "Flower4Petals"
        case .feelingGood: return "Flower6Petals"
        case .energized: return "FullFlower"
        }
    }
    
    var imageOffset: CGFloat {
        switch self {
        case .needingRest: return -4
        case .takingItEasy: return 0
        case .findingRhythm: return 0
        case .feelingGood: return 0
        case .energized: return 0
        }
    }
}

struct WorkoutVideo: Identifiable, Hashable {
    let id = UUID()
    let youtubeId: String
    let title: String
    let instructor: String
    let energyLevel: EnergyState
    let steps: [String]
}

struct WorkoutData {
    static let videos: [WorkoutVideo] = [
        //Very low enegy
        WorkoutVideo(youtubeId: "CbZ22sjuWNU", title: "5 Min Restful Seated Stretch", instructor: "Yoga With Bird", energyLevel: .needingRest, steps: ["Find a comfortable seated position", "Gently roll your neck and shoulders", "Slowly reach into a seated side stretch", "Fold forward gently over your legs", "Rest your hands and take deep, calming breaths"]),
        WorkoutVideo(youtubeId: "gH1Wx6byvUo", title: "5 Min Gentle Bed Stretches", instructor: "Yoga with Kassandra", energyLevel: .needingRest, steps: ["Lie flat on your back and relax", "Slowly hug your knees to your chest", "Drop knees to the side for a gentle twist", "Move through a soft seated cat-cow", "Close your eyes and focus on belly breathing"]),
        WorkoutVideo(youtubeId: "Kvoq4luIYVc", title: "5 Min Grounding Body Stretch", instructor: "Yoga With Adriene", energyLevel: .needingRest, steps: ["Start in a comforting child's pose", "Gently press up to a soft downward dog", "Walk hands back to a standing forward fold", "Roll up slowly to a standing mountain pose", "Take three deep, grounding breaths"]),
        WorkoutVideo(youtubeId: "aPN89GOsDaI", title: "5 Min Gentle Pilates Stretch", instructor: "Lindywell", energyLevel: .needingRest, steps: ["Lie back and practice deep pelvic breathing", "Allow your spine to twist gently side to side", "Sit up for a gentle mermaid side stretch", "Stretch your hamstrings without forcing", "Return to a resting posture to finish"]),
        WorkoutVideo(youtubeId: "iXfme9X1slA", title: "5 Min Pelvic Floor Connection", instructor: "Renée Mowatt", energyLevel: .needingRest, steps: ["Lie comfortably on your back", "Perform tiny, gentle pelvic tilts", "Connect with your core using soft bracing", "Lift into small, restorative glute bridges", "Relax your muscles completely and breathe"]),

        //Low Energy
        WorkoutVideo(youtubeId: "XMhyk4Ym15I", title: "10 Min Standing Mobility", instructor: "MIZI", energyLevel: .takingItEasy, steps: ["Stand tall and find your balance", "Reach your arms slowly overhead", "Twist your torso gently from side to side", "Lean into a soft side body stretch", "Release tension with a forward fold"]),
        WorkoutVideo(youtubeId: "FuUFYaXaxTk", title: "10 Min Feel-Good Body Stretch", instructor: "Yoga With Bird", energyLevel: .takingItEasy, steps: ["Begin in an easy seated pose", "Flow through gentle cat-cow movements", "Press into a soft downward facing dog", "Step forward for a low, supported lunge", "Rest and recover in child's pose"]),
        WorkoutVideo(youtubeId: "TIjnkwaFkwM", title: "10 Min Posture Relief", instructor: "MIZI", energyLevel: .takingItEasy, steps: ["Slowly roll your shoulders back and down", "Open your chest and stretch your arms wide", "Gently release tension in your neck", "Reach overhead for a standing side bend", "Return to center and breathe deeply"]),
        WorkoutVideo(youtubeId: "C2RAjUEAoLI", title: "10 Min Gentle Morning Flow", instructor: "Yoga with Kassandra", energyLevel: .takingItEasy, steps: ["Start with a quiet seated meditation", "Move into gentle spinal twists", "Stretch your back in tabletop position", "Melt your heart down in puppy pose", "Settle into a final resting pose"]),
        WorkoutVideo(youtubeId: "C2RAjUEAoLI", title: "10 Min At-Home Stretch Routine", instructor: "Jessica Valant", energyLevel: .takingItEasy, steps: ["Focus on finding neutral pelvic placement", "Extend gently into a single leg stretch", "Slowly articulate your spine up and down", "Open your chest to relieve nursing posture", "Take a deep, restorative final breath"]),

        //Moderate energy
        WorkoutVideo(youtubeId: "dB0SX-VwURY", title: "15 Min Feel-Good Standing Pilates", instructor: "MonikaFit", energyLevel: .findingRhythm, steps: ["Warm up with gentle stepping", "Perform slow standing side leg lifts", "Lower into gentle, controlled squats", "Draw large circles with your arms", "Cool down with slow, sweeping stretches"]),
        WorkoutVideo(youtubeId: "2RYoz7lxJNI", title: "15 Min Gentle Full Body Routine", instructor: "MonikaFit", energyLevel: .findingRhythm, steps: ["Start by marching lightly in place", "Engage your core with standing crunches", "Step back into gentle, shallow lunges", "Reach overhead to stretch your sides", "Slow your heart rate with deep breathing"]),
        WorkoutVideo(youtubeId: "tov0o3mi5h8", title: "15 Min Beginner Mat Pilates", instructor: "Flow with Mira", energyLevel: .findingRhythm, steps: ["Prepare your core for The Hundred", "Roll back halfway to engage your abs", "Draw small circles with your lifted leg", "Sit up and stretch your spine forward", "Rest peacefully in child's pose"]),
        WorkoutVideo(youtubeId: "rpGWRI4EhJ4", title: "15 Min Mobility Flow for the Soul", instructor: "The Bare Female", energyLevel: .findingRhythm, steps: ["Loosen your hips with dynamic circles", "Transition from downward dog to plank", "Step up into a strong crescent lunge", "Release hip tension in pigeon pose", "Rest completely in Savasana"]),
        WorkoutVideo(youtubeId: "EvMTrP8eRvM", title: "15 Min Stress-Reduction Flow", instructor: "Yoga with Kassandra", energyLevel: .findingRhythm, steps: ["Sit quietly and ground your energy", "Relieve tension with slow neck stretches", "Twist gently in thread the needle pose", "Lift into a mild, supported bridge", "Enter deep relaxation to finish"]),

        //Moderate-High Energy
        WorkoutVideo(youtubeId: "mYlcWUii1CI", title: "15 Min Low-Impact Cardio Walk", instructor: "Pregnancy and Postpartum TV", energyLevel: .feelingGood, steps: ["Warm up your body by marching", "Move side to side with step touches", "Engage your core with low impact knee drives", "Keep the rhythm with gentle side steps", "Cool down and stretch your legs"]),
        WorkoutVideo(youtubeId: "7RB9QfY1SkM", title: "15 Min Dance Cardio Fun", instructor: "Pregnancy and Postpartum TV", energyLevel: .feelingGood, steps: ["Step to the rhythm of the music", "Sway your arms to build momentum", "Travel side to side with grapevine steps", "Loosen up with gentle hip movements", "Slow your pace to bring your heart rate down"]),
        WorkoutVideo(youtubeId: "pRHzVXxfNHY", title: "15 Min Energizing Cardio Flow", instructor: "Bridget Teyler", energyLevel: .feelingGood, steps: ["Get your heart rate up with brisk marching", "Perform low impact jumping jacks", "Step into alternating reverse lunges", "Engage your waist with standing core twists", "Finish with a deep, full body stretch"]),
        WorkoutVideo(youtubeId: "9pZ1xHjZs-I", title: "15 Min Core & Cardio Boost", instructor: "Pregnancy and Postpartum TV", energyLevel: .feelingGood, steps: ["Warm up with wide strides", "Squat down and reach up tall", "Crunch your obliques while standing", "Activate your glutes with kickbacks", "Stretch gently to recover"]),
        WorkoutVideo(youtubeId: "1klYAQGXodg", title: "15 Min Hormone Balancing Cardio", instructor: "Lauren Fitter", energyLevel: .feelingGood, steps: ["Start with light side-to-side step taps", "Swing your arms to engage your upper body", "Glide side to side in low impact skaters", "Perform standing abdominal exercises", "Cool down with slow, focused breathing"]),

        //High Energy
        WorkoutVideo(youtubeId: "y2RcYo36boM", title: "20 Min Express Full Body Pilates", instructor: "Move With Nicole", energyLevel: .energized, steps: ["Ignite your core with the Pilates hundred", "Articulate your spine with full roll ups", "Target your glutes with side lying leg work", "Strengthen your back with swimming extensions", "Release tension in child's pose"]),
        WorkoutVideo(youtubeId: "o8u_xfJnLq0", title: "20 Min Empowering Pilates Flow", instructor: "Lidia Mera", energyLevel: .energized, steps: ["Challenge your core with plank variations", "Lift and squeeze in glute bridges", "Work your outer thighs with clamshells", "Engage deep abs with the double leg stretch", "Reward your body with a full stretch"]),
        WorkoutVideo(youtubeId: "WjH-NQDeQ3o", title: "20 Min All Standing Cardio", instructor: "fitbymik", energyLevel: .energized, steps: ["March powerfully with high knees", "Twist deeply in standing cross crunches", "Keep the energy up with fast step touches", "Perform low impact standing burpees", "Cool down and grab a sip of water"]),
        WorkoutVideo(youtubeId: "gpPs0IFnrIM", title: "20 Min Low Impact Pilates Burn", instructor: "growingannanas", energyLevel: .energized, steps: ["Start with a dynamic, active warm up", "Feel the burn with squat pulses", "Transition from plank to bear crawl", "Target your lower body with lying glute work", "Take a moment for a final restorative stretch"]),
        WorkoutVideo(youtubeId: "6bWhu6DwEns", title: "20 Min Full Body Power Pilates", instructor: "IsaWelly", energyLevel: .energized, steps: ["Activate your core right away", "Control your core with single leg drops", "Strengthen your obliques with side plank dips", "Lift your chest for back extensions", "Finish strong with deep, calming breaths"])
    ]
    
    static func getRandomVideo(for energy: EnergyState) -> WorkoutVideo {
        let filtered = videos.filter { $0.energyLevel == energy }
        return filtered.randomElement() ?? videos[0]
    }
}
