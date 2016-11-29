//
//  CollectionViewBaseCell
//  Wave
//
//  Created by Eude Lesperance on 11/25/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
