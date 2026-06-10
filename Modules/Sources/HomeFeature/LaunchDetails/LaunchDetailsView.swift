//
//  LaunchDetailsView.swift
//  Modules
//
//  Created by Varun on 2026-06-09.
//

import HomeDomain
import SwiftUI

struct LaunchDetails: View {
    private let launch: Launch

    init(launch: Launch) {
        self.launch = launch
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let missionImage = launch.mission?.missionPatch {
                AsyncImage(url: missionImage) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                } placeholder: {
                    placeholderImage
                }
            } else {
                placeholderImage
            }

            if let missionName = launch.mission?.name {
                Text(missionName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
            }

            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    if let rocketName = launch.rocket?.name {
                        Text(rocketName)
                            .font(.title3)
                            .fontWeight(.regular)
                    }

                    if let site = launch.site {
                        Text(site)
                            .font(.title3)
                            .fontWeight(.regular)
                    }

                    Image(systemName: launch.isBooked ? "ticket.fill" : "ticket")
                        .foregroundStyle(launch.isBooked ? .green : .secondary)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var placeholderImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.fill)
            .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

#Preview {
    LaunchDetails(launch: Launch(
        id: "110",
        isBooked: false,
        mission: Mission(
            name: "CRS-21",
            missionPatch: URL(string: "https://imgur.com/E7fjUBD.png")
        ),
        rocket: Rocket(
            name: "Falcon 9",
            type: "FT"
        ),
        site: "KSC LC 39A"
    ))
}
