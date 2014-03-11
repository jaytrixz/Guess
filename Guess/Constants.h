//
//  Constants.h
//  Guess
//
//  Created by Jay Santos on 12/11/13.
//  Copyright (c) 2013 Globe Telecom. All rights reserved.
//

#ifndef Guess_Constants_h
#define Guess_Constants_h

// URLs
#pragma mark - URLs

#define kBaseURL                                                @"http://developer.globelabs.com.ph/dialog/oauth?app_id="
#define kRegistrationURL                                        kBaseURL "eqKboU7ea8RfA7izzLTa6EfaEKK9UpXA"
#define kReferenceCodeURL                                       @"http://guess-app.herokuapp.com/reference"
#define kChargingURL                                            @"http://devapi.globelabs.com.ph/payment/v1/transactions/amount"
#define kIncrementReferenceURL                                  @"http://guess-app.herokuapp.com/increment"

// Alert view
#pragma mark - Alert view

#define kSorry                                                  @"Sorry"
#define kOK                                                     @"OK"
#define kNo                                                     @"No"
#define kYes                                                    @"Yes"
#define kNeedHelp                                               @"Need Help?"
#define kQuitting                                               @"Quitting Already?"
#define kHintMessage                                            @"Do you want to purchase a HINT for this question?\n1 Hint = 1 Peso"
#define kWrongMessage                                           @"Incorrect. Please try again."
#define kBlankAnswerMessage                                     @"Nothing entered. Please try again."
#define kAreYouSure                                             @"Are you sure you want to quit?"

// Images
#pragma mark - Images

#define kSpongebobImage                                         [UIImage imageNamed:@"spongebob.png"]
#define kGarfieldImage                                          [UIImage imageNamed:@"garfield.png"]
#define kWoodyImage                                             [UIImage imageNamed:@"woody.png"]
#define kAvengersImage                                          [UIImage imageNamed:@"avengers.png"]

#define kEmptyImage                                             [UIImage imageNamed:@""]

#define kOneImage                                               [UIImage imageNamed:@"1.png"]
#define kTwoImage                                               [UIImage imageNamed:@"2.png"]
#define kThreeImage                                             [UIImage imageNamed:@"3.png"]
#define kFourImage                                              [UIImage imageNamed:@"4.png"]

// Texts
#pragma mark - Texts

#define kLevelOneText                                           @"Level 1"
#define kLevelTwoText                                           @"Level 2"
#define kLevelThreeText                                         @"Level 3"
#define kLevelFourText                                          @"Level 4"

#define kScoreZeroText                                          @"0"
#define kScoreOneText                                           @"1"
#define kScoreTwoText                                           @"2"
#define kScoreThreeText                                         @"3"
#define kScoreFourText                                          @"4"

#define kEmptyText                                              @""
#define kLoadingText                                            @"Loading..."

#define kScoreText                                              @"Score: %@"

// Arrays
#pragma mark - Arrays

#define kHintsArray                                             @[@"Lives in Bikini Bottom", @"I hate Mondays!", @"Cowboy", @"A team of superheroes in the Marvel Universe"]

// Dictionaries
#pragma mark - Dictionaries

#define kChargingParameterDict                                  @{@"access_token": _tokenString, @"amount": @"0.00", @"description": @"Guess (?)", @"endUserId": _userIDString, @"referenceCode": _referenceString, @"transactionOperationStatus": @"Charged"}
#define kIncrementParameterDict                                 @{@"reference": @"ok"}













#endif
