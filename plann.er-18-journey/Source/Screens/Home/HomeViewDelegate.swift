//
//  HomeViewDelegate.swift
//  plann.er-18-journey
//
//  Created by Diogo on 06/03/2025.
//
import Foundation

protocol HomeViewDelegate: AnyObject {
    func didTapContinueButton(with location: String, startDate: Date, endDate: Date)
    func didTapInviteButton()
}
