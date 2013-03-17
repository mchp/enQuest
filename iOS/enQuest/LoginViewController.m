//
//  LoginViewController.m
//  enQuest
//
//  Created by Leo on 03/13/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "RegistrationTurtle.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize scrollView;
@synthesize username_field;
@synthesize password_field;
@synthesize loginButton;
@synthesize registerButton;
@synthesize reg_username_field;
@synthesize reg_password_field;
@synthesize reg_confirm_password_field;
@synthesize reg_email_field;
@synthesize activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create gesture recognizer to dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)login:(id)sender
{
    LoginManager *manager = [LoginManager sharedManager];
    manager.delegate = self;
    [manager loginWithUsername:username_field.text password:password_field.text];
    loginButton.enabled = NO;
    loginButton.alpha = DisabledButtonAlpha;
}

- (void)loginDidFinish
{
    NSLog(@"...dismissLoginScreen");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginDidFailWithError:(NSError *)error
{
    loginButton.enabled = YES;
    loginButton.alpha = 1.0;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login was unsuccessful." message:@"Please check your username and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)registerNewUser:(id)sender
{
    NSString *u = self.reg_username_field.text;
    NSString *p = self.reg_password_field.text;
    NSString *cp = self.reg_confirm_password_field.text;
    NSString *e = self.reg_email_field.text;
    
    // check that passwords agree
    if (![p isEqualToString:cp]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Passwords don't match",@"Title for alert displayed when passwords don't match.") message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    RegistrationTurtle *t = [[RegistrationTurtle alloc] init];
    t.delegate = self;
    [t registerWithUsername:u password:p email:e];
    
    /* disable button */
    registerButton.enabled = NO;
    registerButton.alpha = DisabledButtonAlpha;
}

- (void)registrationTurtleDidFinishRegister:(RegistrationTurtle*)turtle
{
    /* clear registration textfields */
    self.reg_username_field.text = @"";
    self.reg_password_field.text = @"";
    self.reg_confirm_password_field.text = @"";
    self.reg_email_field.text = @"";
    
    /* re-enable button */
    registerButton.enabled = YES;
    registerButton.alpha = 1.0;
    
    /* present alert to notify success */
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Registration successful! Please login above.",@"Title for alert displayed when registration is successful.") message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)registrationTurtleDidFailRegister:(RegistrationTurtle*)turtle withError:(NSError *)error
{
    
    /* re-enable button */
    registerButton.enabled = YES;
    registerButton.alpha = 1.0;

    /* present alert */
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.username_field) {
        [self.password_field becomeFirstResponder];
    }
    else if (textField == self.password_field) {
        [textField resignFirstResponder];
        [self login:nil];
    }
    else if (textField == self.reg_username_field) {
        [self.reg_password_field becomeFirstResponder];
    }
    else if (textField == self.reg_password_field) {
        [self.reg_confirm_password_field becomeFirstResponder];
    }
    else if (textField == self.reg_confirm_password_field) {
        [self.reg_email_field becomeFirstResponder];
    }
    else if (textField == self.reg_email_field) {
        [textField resignFirstResponder];
        [self registerNewUser:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

#pragma mark keyboard management

-(void)dismissKeyboard {
    [activeField resignFirstResponder];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize kbSize = [self.view convertRect:keyboardFrame fromView:self.view.window].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect visibleRect = self.scrollView.bounds;
    visibleRect.size.height -= kbSize.height;
    CGRect activeFieldRect = [activeField convertRect:activeField.bounds toView:scrollView];
    if (!CGRectContainsRect(visibleRect, activeFieldRect) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeFieldRect.origin.y + activeFieldRect.size.height/2.0-visibleRect.size.height/2.0);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [UIView commitAnimations];
}

@end
