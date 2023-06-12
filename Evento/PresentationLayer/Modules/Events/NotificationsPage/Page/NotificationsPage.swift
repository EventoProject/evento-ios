//
//  NotificationsPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.06.2023.
//

import SwiftUI

struct NotificationsPage: View {
    @ObservedObject var viewModel: NotificationsViewModel
    
    var body: some View {
        List(viewModel.notifications, id: \.self) { notification in
            NotificationItemView(notification: notification)
            .listRowSeparator(.hidden)
            .listRowBackground(CustColor.backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(CustColor.backgroundColor)
        .refreshable {
            viewModel.refresh()
        }
    }
}

private struct NotificationItemView: View {
    let notification: NotificationItemModel
    
    var body: some View {
        HStack(spacing: 11) {
            bellView
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    CustText(text: notification.type, weight: .medium, size: 16)
                        .foregroundGradient()
                    Spacer()
                    CustText(
                        text: notification.createdAt.toDate(with: .yyyyMMddTHHmmssSSSZ)?.timeElapsedString() ?? "",
                        weight: .regular,
                        size: 14
                    ).foregroundColor(CustColor.lightGray)
                }
                CustText(text: notification.content, weight: .regular, size: 16)
            }
        }
        .padding(16)
        .background(.white)
        .cornerRadius(20)
    }
    
    private var bellView: some View {
        ZStack {
            Circle()
                .fill(CustLinearGradient)
                .frame(width: 60, height: 60)
            
            Image(uiImage: Images.whiteBell)
        }
    }
}

struct NotificationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsPage(viewModel: NotificationsViewModel(
            apiManager: EventsApiManager(
                webService: WebService(
                    keychainManager: KeychainManager()
                )
            )
        ))
    }
}
