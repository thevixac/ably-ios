//
//  ARTRestCrytoTest.m
//  ably-ios
//
//  Created by vic on 13/03/2015.
//  Copyright (c) 2015 Ably. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ARTMessage.h"
#import "ARTClientOptions.h"
#import "ARTPresenceMessage.h"
#import "ARTRest.h"
#import "ARTTestUtil.h"
#import "ARTCrypto.h"
#import "ARTLog.h"
@interface ARTRestCryptoTest : XCTestCase
{
    ARTRest *_rest;
}
@end

@implementation ARTRestCryptoTest

- (void)setUp {    
    [super setUp];
}

- (void)tearDown {
    _rest = nil;
    [super tearDown];
}

-(void) testSendBinary {
    XCTestExpectation *exp = [self expectationWithDescription:@"testSendBinary"];
    [ARTTestUtil testRest:^(ARTRest *rest) {
        _rest =rest;
        ARTRestChannel * c = [rest channel:@"test"];
        XCTAssert(c);
        NSData * dataPayload = [@"someDataPayload"  dataUsingEncoding:NSUTF8StringEncoding];
        NSString * stringPayload = @"someString";
        [c publish:dataPayload cb:^(ARTStatus *status) {
            XCTAssertEqual(ARTStatusOk, status.status);
            [c publish:stringPayload cb:^(ARTStatus *status) {
                XCTAssertEqual(ARTStatusOk, status.status);
                [c history:^(ARTStatus *status, id<ARTPaginatedResult> result) {
                    XCTAssertEqual(ARTStatusOk, status.status);
                    XCTAssertEqual(ARTStatusOk, status.status);
                    XCTAssertFalse([result hasNext]);
                    NSArray * page = [result currentItems];
                    XCTAssertTrue(page != nil);
                    XCTAssertEqual([page count], 2);
                    ARTMessage * stringMessage = [page objectAtIndex:0];
                    ARTMessage * dataMessage = [page objectAtIndex:1];
                    XCTAssertEqualObjects([dataMessage content], dataPayload);
                    XCTAssertEqualObjects([stringMessage content], stringPayload);
                    [exp fulfill];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:[ARTTestUtil timeout] handler:nil];
}

-(void) testSendEncodedMessage {
    XCTestExpectation *exp = [self expectationWithDescription:@"testSendBinary"];
    [ARTTestUtil testRest:^(ARTRest *rest) {
        _rest =rest;
        
        ARTIvParameterSpec * ivSpec = [[ARTIvParameterSpec alloc] initWithIv:[[NSData alloc]
                                                                              initWithBase64EncodedString:@"HO4cYSP8LybPYBPZPHQOtg==" options:0]];
    
        NSData * keySpec = [[NSData alloc] initWithBase64EncodedString:@"WUP6u0K7MXI5Zeo0VppPwg==" options:0];
        ARTCipherParams * params =[[ARTCipherParams alloc] initWithAlgorithm:@"aes" keySpec:keySpec ivSpec:ivSpec];
        ARTRestChannel * c = [rest channel:@"test" cipherParams:params];
        XCTAssert(c);
        NSData * dataPayload = [@"someDataPayload"  dataUsingEncoding:NSUTF8StringEncoding];
        NSString * stringPayload = @"someString";
        [c publish:dataPayload cb:^(ARTStatus *status) {
            XCTAssertEqual(ARTStatusOk, status.status);
            [c publish:stringPayload cb:^(ARTStatus *status) {
                XCTAssertEqual(ARTStatusOk, status.status);
                [c history:^(ARTStatus *status, id<ARTPaginatedResult> result) {
                    XCTAssertEqual(ARTStatusOk, status.status);
                    XCTAssertEqual(ARTStatusOk, status.status);
                    XCTAssertFalse([result hasNext]);
                    NSArray * page = [result currentItems];
                    XCTAssertTrue(page != nil);
                    XCTAssertEqual([page count], 2);
                    ARTMessage * stringMessage = [page objectAtIndex:0];
                    ARTMessage * dataMessage = [page objectAtIndex:1];
                    XCTAssertEqualObjects([dataMessage content], dataPayload);
                    XCTAssertEqualObjects([stringMessage content], stringPayload);
                    [exp fulfill];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:[ARTTestUtil timeout] handler:nil];
}



/*
- (void)testPublishText256 {
    XCTFail(@"TODO write test");
}




- (void)testPublishKeyMismatch {
    XCTFail(@"TODO write test");
}


- (void)testEncrypedUnHandled {
    XCTFail(@"TODO write test");
}


 - (void)testSendUnencrypted {
 XCTFail(@"TODO write test");
 }
 */

/*
 //msgpack not implemented
- (void)testBinaryAndText {
    XCTFail(@"TODO write test");
}

- (void)testBinary256 {
    XCTFail(@"TODO write test");
}

- (void)testTextAndBinary {
    XCTFail(@"TODO write test");
}

- (void)testPublishBinary {
    XCTFail(@"TODO write test");
}

*/
@end
