//
//  SearchList.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 6/30/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <Realm/Realm.h>

@interface SearchList : RLMObject

@property NSString *friendID;
@property NSString *friendName;
@property NSString *friendPicture;

@end
