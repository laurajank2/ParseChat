//
//  Post.h
//  ParseChat
//
//  Created by Laura Jankowski on 6/27/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *postID;
    @property (nonatomic, strong) NSString *userID;
    @property (nonatomic, strong) NSString *caption;
    
    @property (nonatomic, strong) PFFileObject *image;
    
@end

NS_ASSUME_NONNULL_END
