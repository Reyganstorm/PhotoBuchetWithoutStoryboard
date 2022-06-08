//
//  DataRealmManager.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 08.06.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(_ completion: @escaping() -> Void ) {
        if !UserDefaults.standard.bool(forKey: "keyForPhotoBucketWithoutStoryboardTestingAppReasonOne") {
            UserDefaults.standard.set(true, forKey: "keyForPhotoBucketWithoutStoryboardTestingAppReasonOne")
            
            let creator = RealmObject()
  
            creator.url = "https://sun9-36.userapi.com/s/v1/if1/hZ8MUblmRePlmTirpwdYY3FOT3g5tg_Caze3ZwBd3UGWXt55qKDe4TxoubU4WLhiyJpMUMpQ.jpg?size=499x392&quality=96&type=album"
            creator.name = "Ruslan Shtybaev - app creator"
            creator.location = "Moscow mb Gotham"
            creator.likes = 12345
            creator.liked_by_user = true
            
            let secondObjectForExample = RealmObject()
            secondObjectForExample.url = "https://sun9-67.userapi.com/s/v1/if2/s7mlxhx1H8BCxbMzYFLOkZazZUUsVqJN1PeZfq-A3arVzq5jCTKJxFPft0Xmw9volHu-sq-lfVdzi26P_WZ2vrpQ.jpg?size=1280x848&quality=96&type=album"
            secondObjectForExample.name = "App Creator"
            secondObjectForExample.location = "Now Realy Moscow"
            secondObjectForExample.likes = 54321
            secondObjectForExample.liked_by_user = true
            
            
            DispatchQueue.main.async {
                StorageManager.shared.save(creator)
                StorageManager.shared.save(secondObjectForExample)
                completion()
            }
        }
    }
}
