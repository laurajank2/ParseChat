//
//  Post.m
//  ParseChat
//
//  Created by Laura Jankowski on 6/27/22.
//

#import "Post.h"

@implementation Post
    
    @dynamic postID;
    @dynamic userID;
    @dynamic caption;
    @dynamic image;

    + (nonnull NSString *)parseClassName {
        return @"Post";
    }
    
@end
