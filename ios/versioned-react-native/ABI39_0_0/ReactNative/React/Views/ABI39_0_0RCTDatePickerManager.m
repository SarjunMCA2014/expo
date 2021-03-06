/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI39_0_0RCTDatePickerManager.h"

#import <ABI39_0_0React/ABI39_0_0RCTUIManager.h>
#import "ABI39_0_0RCTBridge.h"
#import "ABI39_0_0RCTDatePicker.h"
#import "ABI39_0_0RCTEventDispatcher.h"
#import "ABI39_0_0UIView+React.h"

@implementation ABI39_0_0RCTConvert (UIDatePicker)

ABI39_0_0RCT_ENUM_CONVERTER(
    UIDatePickerMode,
    (@{
      @"time" : @(UIDatePickerModeTime),
      @"date" : @(UIDatePickerModeDate),
      @"datetime" : @(UIDatePickerModeDateAndTime),
      @"countdown" : @(UIDatePickerModeCountDownTimer), // not supported yet
    }),
    UIDatePickerModeTime,
    integerValue)

@end

@implementation ABI39_0_0RCTDatePickerManager

ABI39_0_0RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [ABI39_0_0RCTDatePicker new];
}

ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(date, NSDate)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(locale, NSLocale)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(minimumDate, NSDate)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(maximumDate, NSDate)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(minuteInterval, NSInteger)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(onChange, ABI39_0_0RCTBubblingEventBlock)
ABI39_0_0RCT_REMAP_VIEW_PROPERTY(mode, datePickerMode, UIDatePickerMode)
ABI39_0_0RCT_REMAP_VIEW_PROPERTY(timeZoneOffsetInMinutes, timeZone, NSTimeZone)

ABI39_0_0RCT_EXPORT_METHOD(setNativeDate : (nonnull NSNumber *)viewTag toDate : (NSDate *)date)
{
  [self.bridge.uiManager addUIBlock:^(ABI39_0_0RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    UIView *view = viewRegistry[viewTag];

    if ([view isKindOfClass:[ABI39_0_0RCTDatePicker class]]) {
      [(ABI39_0_0RCTDatePicker *)view setDate:date];
    } else {
      // This component is used in Fabric through LegacyInteropLayer.
      // `ABI39_0_0RCTPicker` view is subview of `ABI39_0_0RCTLegacyViewManagerInteropComponentView`.
      // `viewTag` passed as parameter to this method is tag of the `ABI39_0_0RCTLegacyViewManagerInteropComponentView`.
      UIView *subview = view.subviews.firstObject;
      if ([subview isKindOfClass:[ABI39_0_0RCTDatePicker class]]) {
        [(ABI39_0_0RCTDatePicker *)subview setDate:date];
      } else {
        ABI39_0_0RCTLogError(@"view type must be ABI39_0_0RCTPicker");
      }
    }
  }];
}

@end
