//
//  HobbyList.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 6/3/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <Realm/Realm.h>

@interface HobbyList : RLMObject

@property NSString *hobbyID;
@property NSString *hobbyName;
@property bool isShare;

@end
