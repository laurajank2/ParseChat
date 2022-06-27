//
//  LoginViewController.m
//  ParseChat
//
//  Created by Laura Jankowski on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ChatViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginUser:(id)sender {
    NSString *username = self.userField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                       message:@"Problem logging in"
                                                                                preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle cancel response here. Doing nothing will dismiss the view.
                                                              }];
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ChatViewController *chatVC = [storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
            [self presentViewController:chatVC animated:YES completion:nil];
        }
    }];
}
- (IBAction)registerUser:(id)sender {
    // initialize a user object
   PFUser *newUser = [PFUser user];
   
   // set user properties
   newUser.username = self.userField.text;
   newUser.password = self.passwordField.text;
   
   // call sign up function on the object
   [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
       if (error != nil) {
           NSLog(@"Error: %@", error.localizedDescription);
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                      message:@"Problem making account"
                                                                               preferredStyle:(UIAlertControllerStyleAlert)];
           // create a cancel action
           UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                    // handle cancel response here. Doing nothing will dismiss the view.
                                                             }];
           // add the cancel action to the alertController
           [alert addAction:cancelAction];

           // create an OK action
           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                    // handle response here.
                                                            }];
           // add the OK action to the alert controller
           [alert addAction:okAction];
           [self presentViewController:alert animated:YES completion:^{
               // optional code for what happens after the alert controller has finished presenting
           }];

       } else {
           NSLog(@"User registered successfully");
           
           
           // manually segue to logged in view
           [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
       }
   }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
