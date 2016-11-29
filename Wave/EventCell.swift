//
//  EventCell.swift
//  Wave
//
//  Created by Eude Lesperance on 11/25/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit

class EventCell: CollectionViewBaseCell {
    var event: Event? {
        didSet {
            thumbnailImageView.image = UIImage(named: (event?.thumbnailImageName)!)            
            eventNameLabel.text = event?.eventName
            eventDateLabel.text = event?.eventDate
            eventCostLabel.text = "$\(event!.eventCost)"
            
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Event Name"
        return label
    }()
    
    let eventDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "December 10, 2016 5:00 PM - 9:00 PM"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    let eventCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$100.00"
        label.textAlignment = .right
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(eventNameLabel)
        addSubview(eventDateLabel)
        addSubview(eventCostLabel)
        addSubview(separatorView)
        
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -16).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        eventNameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16).isActive = true
        eventNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        eventNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        eventDateLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16).isActive = true
        eventDateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 4).isActive = true
        eventDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        eventCostLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16).isActive = true
        eventCostLabel.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 4).isActive = true
        eventCostLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
}
