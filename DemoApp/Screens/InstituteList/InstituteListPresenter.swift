//
//  InstituteListPresenter.swift
//  ProntoSoccorsoKit
//
//  Created by Matteo Pacini on 10/10/2019.
//  Copyright (c) 2019 Matteo Pacini. All rights reserved.

import Foundation

final class InstituteListPresenter {

    weak var output: InstituteListPresenterOutput?

}

// MARK: InstituteListPresenterInput

extension InstituteListPresenter: InstituteListPresenterInput {

    func updateTitle(response: InstituteList.Title.Response) {
        output?.presentTitle(viewModel:
            InstituteList.Title.ViewModel(title: response.region.displayName)
        )
    }

    func updateData(response: InstituteList.Data.Response) {
        output?.presentData(viewModel:
            InstituteList.Data.ViewModel(institutes: response.institutes.map { $0.name })
        )
    }

    func updateLoading(response: InstituteList.Loading.Response) {
        output?.presentLoading(viewModel:
            InstituteList.Loading.ViewModel(loading: response.loading)
        )
    }

}
