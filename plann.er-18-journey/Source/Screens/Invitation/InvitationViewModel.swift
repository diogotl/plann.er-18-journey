//
//  InvitationViewModel.swift
//  plann.er-18-journey
//
//  Created by Diogo on 08/03/2025.
//

class InvitationViewModel {
    private var guests: [Guest] = []

    var guestsCount: Int {
        return guests.count
    }

    func item(at index: Int) -> Guest {
        return guests[index]
    }

    func addItem(_ item: Guest) {
        guests.append(item)
    }
    
    func removeItem(at index: Int) {
        guests.remove(at: index)
    }

    func getGuests() -> [Guest] {
        return guests
    }
}
