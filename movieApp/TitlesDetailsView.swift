//
//  TitlesDetailsView.swift
//  movieApp
//
//  Created by kareem mohamed  on 14/10/2026.
//

import SwiftUI
import SwiftData

struct TitlesDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let title: Title
    var titleName : String {
    return  (title.name ?? title.title) ?? ""
    }
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    var body: some View{
        GeometryReader{geometry in
            
            switch viewModel.vedioIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView().frame(width: geometry.size.width , height: geometry.size.height)
            case .success:
                ScrollView{
                    LazyVStack(alignment: .leading){
                        YoutubePlayer(videoId: viewModel.videoId).aspectRatio(1.3 , contentMode: .fit)
                        Text(titleName).bold().font(.title2).padding(5)
                        
                        Text(title.overview ?? "").padding(5)
                         
                        HStack{
                            Spacer()
                            Button{
                                let saveTitle = title
                                saveTitle.title = titleName
                                modelContext.insert(saveTitle)
                                try? modelContext.save()
                                dismiss()
                            }label: {
                                Text(Constant.downloadString).ghostButton()
                            }
                            Spacer()
                        }
                        
                       
                    }
                }
            case .failre(let underlyingError):
                Text(underlyingError.localizedDescription).errorMessage().frame(
                    width: geometry.size.width ,height: geometry.size.height
                )
            }
        }.task {
            print("============\(titleName)")
            await viewModel.getVideoId(for: titleName)
        }
    }
    
}

#Preview {
    TitlesDetailsView(title: Title.previewTitles[0])
}
