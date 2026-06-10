//
//  LaunchesListRowView.swift
//  Modules
//
//  Created by Varun on 2026-06-06.
//

import HomeDomain
import SwiftUI

struct LaunchesListRowView: View {
    let launch: Launch

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let missionImage = launch.mission?.missionPatch {
                AsyncImage(url: missionImage) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    placeholderImage
                }
                .frame(width: 100, height: 100)
            } else {
                placeholderImage
            }

            VStack(alignment: .leading, spacing: 10) {
                if let missionName = launch.mission?.name {
                    Text(missionName)
                        .font(.title3)
                        .fontWeight(.medium)
                }

                VStack(alignment: .leading, spacing: 5) {
                    if let rocketName = launch.rocket?.name {
                        Text(rocketName)
                            .font(.callout)
                            .fontWeight(.regular)
                    }

                    if let site = launch.site {
                        Text(site)
                            .font(.callout)
                            .fontWeight(.regular)
                    }

                    Image(systemName: launch.isBooked ? "ticket.fill" : "ticket")
                        .foregroundStyle(launch.isBooked ? .green : .secondary)
                }
            }
        }
    }

    private var placeholderImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.fill)
            .frame(width: 100, height: 100)
    }
}

#Preview {
    LaunchesListRowView(launch: Launch(
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
