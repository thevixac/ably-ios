//
//  ARTStats.m
//  ably-ios
//
//  Created by Jason Choy on 09/12/2014.
//  Copyright (c) 2014 Ably. All rights reserved.
//

#import "ARTStats.h"

@implementation ARTStatsMessageCount

- (instancetype)initWithCount:(double)count data:(double)data {
    self = [super init];
    if (self) {
        _count = count;
        _data = data;
    }
    return self;
}

@end

@implementation ARTStatsMessageTypes

- (instancetype)initWithAll:(ARTStatsMessageCount *)all messages:(ARTStatsMessageCount *)messages presence:(ARTStatsMessageCount *)presence {
    self = [super init];
    if (self) {
        _all = all;
        _messages = messages;
        _presence = presence;
    }
    return self;
}

@end

@implementation ARTStatsMessageTraffic

- (instancetype)initWithAll:(ARTStatsMessageTypes *)all realtime:(ARTStatsMessageTypes *)realtime rest:(ARTStatsMessageTypes *)rest push:(ARTStatsMessageTypes *)push httpStream:(ARTStatsMessageTypes *)httpStream {
    self = [super init];
    if (self) {
        _all = all;
        _realtime = realtime;
        _rest = rest;
        _push = push;
        _httpStream = httpStream;
    }
    return self;
}

@end

@implementation ARTStatsResourceCount

- (instancetype)initWithOpened:(double)opened peak:(double)peak mean:(double)mean min:(double)min refused:(double)refused {
    self = [super init];
    if (self) {
        _opened = opened;
        _peak = peak;
        _mean = mean;
        _min = min;
        _refused = refused;
    }
    return self;
}

@end

@implementation ARTStatsConnectionTypes

- (instancetype)initWithAll:(ARTStatsResourceCount *)all plain:(ARTStatsResourceCount *)plain tls:(ARTStatsResourceCount *)tls {
    self = [super init];
    if (self) {
        _all = all;
        _plain = plain;
        _tls = tls;
    }
    return self;
}

@end

@implementation ARTStatsRequestCount

- (instancetype)initWithSucceeded:(double)succeeded failed:(double)failed refused:(double)refused {
    self = [super init];
    if (self) {
        _succeeded = succeeded;
        _failed = failed;
        _refused = refused;
    }
    return self;
}

@end

@implementation ARTStats

- (instancetype)initWithAll:(ARTStatsMessageTypes *)all inbound:(ARTStatsMessageTraffic *)inbound outbound:(ARTStatsMessageTraffic *)outbound persisted:(ARTStatsMessageTypes *)persisted connections:(ARTStatsConnectionTypes *)connections channels:(ARTStatsResourceCount *)channels apiRequests:(ARTStatsRequestCount *)apiRequests tokenRequests:(ARTStatsRequestCount *)tokenRequests {
    self = [super init];
    if (self) {
        _all = all;
        _inbound = inbound;
        _outbound = outbound;
        _persisted = persisted;
        _connections = connections;
        _channels = channels;
        _apiRequests = apiRequests;
        _tokenRequests = tokenRequests;
    }
    return self;
}

@end
