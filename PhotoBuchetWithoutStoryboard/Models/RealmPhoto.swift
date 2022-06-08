//
//  RealmPhoto.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 08.06.2022.
//

import Foundation
import RealmSwift

class RealmObject: Object {
    @Persisted var id: String = ""

    
    @Persisted var created_at: String = ""
    @Persisted var likes: Int = 0
    @Persisted var liked_by_user: Bool = false
    
    @Persisted var url = ""
    
    @Persisted var dateString = ""
    @Persisted var dateSome = Date()
    
    @Persisted var name: String = ""
    @Persisted var location: String = ""
}
