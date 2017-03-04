#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSError+SCCAdditions.h"
#import "NSError+SCCAPIAdditions.h"
#import "NSError+SCCAPISerializationAdditions.h"
#import "NSURL+SCCAdditions.h"
#import "SCCAPIConnection.h"
#import "SCCAPIRequest+Serialization.h"
#import "SCCAPIRequest.h"
#import "SCCAPIResponse+Serialization.h"
#import "SCCAPIResponse.h"
#import "SCCMoney+Serialization.h"
#import "SCCMoney.h"
#import "SquareRegisterSDK.h"

FOUNDATION_EXPORT double SquareRegisterSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SquareRegisterSDKVersionString[];

