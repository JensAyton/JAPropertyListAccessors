/*

JAPropertyListAccessorsPrimitivesTests.m

Unit tests for JAPropertyListAccessors conversion primitives.


Copyright © 2008 Jens Ayton

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/


#import "JAPropertyListAccessorsPrimitivesTests.h"
#import "JAPropertyListAccessors.h"


#define EPSILON (1e-6)
#define JAAssertEqualEnough(a1, a2) \
				STAssertEqualsWithAccuracy(a1, a2, EPSILON, nil)


@interface StringValueTester: NSObject

- (NSString *) stringValue;

@end


@interface BadStringValueTester: NSObject

- (NSString *) stringValue;

@end


@implementation JAPropertyListAccessorsPrimitivesTests

- (void) testBooleanFromObject
{
	// Test that JABooleanFromObject() returns default value for objects that can't be interepreted as booleans.
	STAssertTrue(JABooleanFromObject(@"not-a-boolean", YES), nil);
	STAssertFalse(JABooleanFromObject(@"not-a-boolean", NO), nil);
	STAssertTrue(JABooleanFromObject([NSArray array], YES), nil);
	STAssertFalse(JABooleanFromObject([NSArray array], NO), nil);
	STAssertTrue(JABooleanFromObject(nil, YES), nil);
	STAssertFalse(JABooleanFromObject(nil, NO), nil);
	
	// Test that JABooleanFromObject() returns the right value for the appropriate strings.
	STAssertTrue(JABooleanFromObject(@"yes", NO), nil);
	STAssertTrue(JABooleanFromObject(@"true", NO), nil);
	STAssertTrue(JABooleanFromObject(@"on", NO), nil);
	// And one with funny capitalization
	STAssertTrue(JABooleanFromObject(@"tRUe", NO), nil);
	STAssertTrue(JABooleanFromObject(@"0.001", NO), nil);
	STAssertTrue(JABooleanFromObject(@"  -0.001 trailing junk", NO), nil);
	
	// Same for false values.
	STAssertFalse(JABooleanFromObject(@"no", YES), nil);
	STAssertFalse(JABooleanFromObject(@"false", YES), nil);
	STAssertFalse(JABooleanFromObject(@"off", YES), nil);
	STAssertFalse(JABooleanFromObject(@"fAlSe", YES), nil);
	STAssertFalse(JABooleanFromObject(@"  0.0 trailing junk", YES), nil);
	
	// Try numerical values.
	STAssertFalse(JABooleanFromObject([NSNumber numberWithInt:0], YES), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithInt:1], NO), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithInt:42], NO), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithFloat:1], NO), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithFloat:0.000001], NO), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithFloat:-0.000001], NO), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithInt:-42], NO), nil);
	
	// Oh, and boolean values too.
	STAssertFalse(JABooleanFromObject([NSNumber numberWithBool:NO], YES), nil);
	STAssertTrue(JABooleanFromObject([NSNumber numberWithBool:YES], NO), nil);
}


- (void) testFloatFromObject
{
	// Conversions which should be successful.
	JAAssertEqualEnough(JAFloatFromObject(@"0.5", NAN), 0.5f);
	JAAssertEqualEnough(JAFloatFromObject(@"-0.005", NAN), -0.005f);
	JAAssertEqualEnough(JAFloatFromObject([NSNumber numberWithFloat:0.73], NAN), 0.73f);
	JAAssertEqualEnough(JAFloatFromObject(@"42", NAN), 42.0f);
	JAAssertEqualEnough(JAFloatFromObject([NSNumber numberWithInt:3], NAN), 3.0f);
	JAAssertEqualEnough(JAFloatFromObject(@"  100 trailing junk", NAN), 100.0f);	// Leading space and trailing non-numerals should be ignored
	
	// Tests which should fail, returning default value.
	JAAssertEqualEnough(JAFloatFromObject(nil, 5), 5.0f);
	JAAssertEqualEnough(JAFloatFromObject([NSArray array], 10), 10.0f);
	JAAssertEqualEnough(JAFloatFromObject(@"thirty-seven", 15), 15.0f);
	JAAssertEqualEnough(JAFloatFromObject([NSDate date], 20), 20.0f);
}


- (void) testDoubleFromObject
{
	// Same as the float tests.
	// Conversions which should be successful.
	JAAssertEqualEnough(JADoubleFromObject(@"0.5", NAN), 0.5);
	JAAssertEqualEnough(JADoubleFromObject(@"-0.005", NAN), -0.005);
	JAAssertEqualEnough(JADoubleFromObject([NSNumber numberWithFloat:0.73], NAN), 0.73);
	JAAssertEqualEnough(JADoubleFromObject(@"42", NAN), 42.0);
	JAAssertEqualEnough(JADoubleFromObject([NSNumber numberWithInt:3], NAN), 3.0);
	JAAssertEqualEnough(JADoubleFromObject(@"  100 trailing junk", NAN), 100.0);	// Trailing non-numerals should be ignored
	
	// Tests which should fail, returning default value.
	JAAssertEqualEnough(JADoubleFromObject(nil, 5), 5.0);
	JAAssertEqualEnough(JADoubleFromObject([NSArray array], 10), 10.0);
	JAAssertEqualEnough(JADoubleFromObject(@"thirty-seven", 15), 15.0);
	JAAssertEqualEnough(JADoubleFromObject([NSDate date], 20), 20.0);
}


- (void) testNonNegativeFloatFromObject
{
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"0.0", -1), 0.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"-0.1", -1), 0.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"-1", -1), 0.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject([NSNumber numberWithFloat:-INFINITY], -1), 0.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"0.1", -1), 0.1f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"1", -1), 1.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject([NSNumber numberWithFloat:INFINITY], -1), (float)INFINITY);
	
	// Default value should be returned as-is, even if it's negative.
	JAAssertEqualEnough(JANonNegativeFloatFromObject(@"not a number", -1), -1.0f);
	JAAssertEqualEnough(JANonNegativeFloatFromObject([NSArray array], -1), -1.0f);
}


- (void) testNonNegativeDoubleFromObject
{
	// Same as the float tests.
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"0.0", -1), 0.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"-0.1", -1), 0.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"-1", -1), 0.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject([NSNumber numberWithDouble:-INFINITY], -1), 0.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"0.1", -1), 0.1);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"1", -1), 1.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject([NSNumber numberWithDouble:INFINITY], -1), (double)INFINITY);
	
	// Default value should be returned as-is, even if it's negative.
	JAAssertEqualEnough(JANonNegativeDoubleFromObject(@"not a number", -1), -1.0);
	JAAssertEqualEnough(JANonNegativeDoubleFromObject([NSArray array], -1), -1.0);
}


- (void) testStringConversion
{
	// Tests internal function StringForObject(). (Four leaks for convenience)
	STAssertNotNil([[NSArray arrayWithObject:@"Test string"] ja_stringAtIndex:0], @"string to string conversion failed");
	STAssertNotNil([[NSArray arrayWithObject:[NSNumber numberWithInt:42]] ja_stringAtIndex:0], @"number to string conversion failed");
	STAssertNotNil([[NSArray arrayWithObject:[NSDate date]] ja_stringAtIndex:0], @"date to string conversion failed");
	STAssertNotNil([[NSArray arrayWithObject:[StringValueTester new]] ja_stringAtIndex:0], @"custom object to string conversion failed");
	STAssertNil([[NSArray arrayWithObject:[BadStringValueTester new]] ja_stringAtIndex:0], @"custom object to string non-conversion failed");
	STAssertNotNil([[NSArray arrayWithObject:[NSObject new]] ja_stringAtIndex:0 defaultValue:@"default"], @"string conversion default fallback failed");
}


// Balances JA_DEFINE_CLAMP
#define TEST_CLAMP(type, typeName, min, max) \
- (void) test##typeName##FromObject \
{ \
	long long min_ = min; \
	long long max_ = max; \
	STAssertEquals(JA##typeName##FromObject(@"1", 0), (type)1, nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:max_], 0), (type)(max_), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:max_ + 1], 0), (type)(max_), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:max_ * 2], 0), (type)(max_), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:min_ + 1], 0), (type)((min_) + 1), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:min_], 0), (type)(min_), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:min_ - 1], 0), (type)(min_), nil); \
	STAssertEquals(JA##typeName##FromObject([NSNumber numberWithLongLong:(min_ - 1) * 2], 0), (type)(min_), nil); \
}


#define TEST_CLAMP_PAIR(type, typeName, minMaxSymb) \
TEST_CLAMP(type, typeName, minMaxSymb##_MIN, minMaxSymb##_MAX) \
TEST_CLAMP(unsigned type, Unsigned##typeName, 0, U##minMaxSymb##_MAX)


TEST_CLAMP_PAIR(char, Char, CHAR)
TEST_CLAMP_PAIR(short, Short, SHRT)
// Test fails in 64-bit due to overflows in the tests, not problems in the implementation.

#if INT_MAX != LLONG_MAX
TEST_CLAMP_PAIR(int, Int, INT)
#endif

#if LONG_MAX != LLONG_MAX
TEST_CLAMP_PAIR(long, Long, LONG)
#endif

@end


@implementation StringValueTester

- (NSString *) stringValue
{
	return @"test";
}

@end


@implementation BadStringValueTester: NSObject

- (NSString *) stringValue
{
	return [NSObject new];
}

@end
