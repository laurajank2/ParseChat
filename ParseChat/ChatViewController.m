//
//  ChatViewController.m
//  ParseChat
//
//  Created by Laura Jankowski on 6/27/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *chatMessageField;
@property (nonatomic, strong) NSArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    [query orderByDescending:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.messages = posts;
            NSLog(@"posts");
            NSLog(@"%@", posts);
            NSLog(@"messages");
            NSLog(@"%@", self.messages);
            
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    [self onTimer];
    
}
- (IBAction)didSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    chatMessage[@"text"] = self.chatMessageField.text;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (succeeded) {
                NSLog(@"The message was saved!");
                self.chatMessageField.text = @"";
            } else {
                NSLog(@"Problem saving message: %@", error.localizedDescription);
            }
        }];
}

- (void)onTimer {
   // Add code to be run periodically
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    PFObject *chat = self.messages[indexPath.row];
    cell.chatText.text = chat[@"text"];
    NSLog(@"Here");
    NSLog(@"@%@", self.messages[indexPath.row][@"text"]);
    NSLog(@"%@",self.messages);
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
