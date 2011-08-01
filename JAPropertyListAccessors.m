/*

JAPropertyListAccessors.m
Version 1.1


Copyright © 2007–2010 Jens Ayton

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

#import "JAPropertyListAccessors.h"


static NSSet *SetForObject(id object, NSSet *defaultValue);
static NSString *StringForObject(id object, NSString *defaultValue);


@implementation NSArray (JAPropertyListAccessors)

- (char) ja_charAtIndex:(unsigned long)index defaultValue:(char)value
{
	return JACharFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (short) ja_shortAtIndex:(unsigned long)index defaultValue:(short)value
{
	return JAShortFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (int) ja_intAtIndex:(unsigned long)index defaultValue:(int)value
{
	return JAIntFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (long) ja_longAtIndex:(unsigned long)index defaultValue:(long)value
{
	return JALongFromObject([self ja_objectAtIndexNoThrow:index], value);
}

- (long) ja_integerAtIndex:(unsigned long)index defaultValue:(long)value
{
	return JALongFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (long long) ja_longLongAtIndex:(unsigned long)index defaultValue:(long long)value
{
	return JALongLongFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned char) ja_unsignedCharAtIndex:(unsigned long)index defaultValue:(unsigned char)value
{
	return JAUnsignedCharFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned short) ja_unsignedShortAtIndex:(unsigned long)index defaultValue:(unsigned short)value
{
	return JAUnsignedShortFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned int) ja_unsignedIntAtIndex:(unsigned long)index defaultValue:(unsigned int)value
{
	return JAUnsignedIntFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned long) ja_unsignedLongAtIndex:(unsigned long)index defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned long) ja_unsignedIntegerAtIndex:(unsigned long)index defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (unsigned long long) ja_unsignedLongLongAtIndex:(unsigned long)index defaultValue:(unsigned long long)value
{
	return JAUnsignedLongLongFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (BOOL) ja_boolAtIndex:(unsigned long)index defaultValue:(BOOL)value
{
	return JABooleanFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (float) ja_floatAtIndex:(unsigned long)index defaultValue:(float)value
{
	return JAFloatFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (double) ja_doubleAtIndex:(unsigned long)index defaultValue:(double)value
{
	return JADoubleFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (float) ja_nonNegativeFloatAtIndex:(unsigned long)index defaultValue:(float)value
{
	return JANonNegativeFloatFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (double) ja_nonNegativeDoubleAtIndex:(unsigned long)index defaultValue:(double)value
{
	return JANonNegativeDoubleFromObject([self ja_objectAtIndexNoThrow:index], value);
}


- (id) ja_objectAtIndexNoThrow:(unsigned long)index
{
	return [self ja_objectAtIndexNoThrow:index defaultValue:nil];
}


- (id) ja_objectAtIndexNoThrow:(unsigned long)index defaultValue:(id)value
{
	if ([self count] <= index)  return value;
	return [self objectAtIndex:index];
}


- (id) ja_objectAtIndex:(unsigned long)index defaultValue:(id)value
{
	id					objVal = [self objectAtIndex:index];
	id					result;
	
	if (objVal != nil)  result = objVal;
	else  result = value;
	
	return result;
}


- (id) ja_objectOfClass:(Class)class atIndex:(unsigned long)index defaultValue:(id)value
{
	id					objVal = [self ja_objectAtIndexNoThrow:index];
	NSString			*result;
	
	if ([objVal isKindOfClass:class])  result = objVal;
	else  result = value;
	
	return result;
}


- (NSString *) ja_stringAtIndex:(unsigned long)index defaultValue:(NSString *)value
{
	return StringForObject([self ja_objectAtIndexNoThrow:index], value);
}


- (NSArray *) ja_arrayAtIndex:(unsigned long)index defaultValue:(NSArray *)value
{
	return [self ja_objectOfClass:[NSArray class] atIndex:index defaultValue:value];
}


- (NSSet *) ja_setAtIndex:(unsigned long)index defaultValue:(NSSet *)value
{
	return SetForObject([self ja_objectAtIndexNoThrow:index], value);
}


- (NSDictionary *) ja_dictionaryAtIndex:(unsigned long)index defaultValue:(NSDictionary *)value
{
	return [self ja_objectOfClass:[NSDictionary class] atIndex:index defaultValue:value];
}


- (NSData *) ja_dataAtIndex:(unsigned long)index defaultValue:(NSData *)value
{
	return [self ja_objectOfClass:[NSData class] atIndex:index defaultValue:value];
}


- (char) ja_charAtIndex:(unsigned long)index
{
	return [self ja_charAtIndex:index defaultValue:0];
}


- (short) ja_shortAtIndex:(unsigned long)index
{
	return [self ja_shortAtIndex:index defaultValue:0];
}


- (int) ja_intAtIndex:(unsigned long)index
{
	return [self ja_intAtIndex:index defaultValue:0];
}


- (long) ja_longAtIndex:(unsigned long)index
{
	return [self ja_longAtIndex:index defaultValue:0];
}


- (long) ja_integerAtIndex:(unsigned long)index
{
	return [self ja_integerAtIndex:index defaultValue:0];
}


- (long long) ja_longLongAtIndex:(unsigned long)index
{
	return [self ja_longLongAtIndex:index defaultValue:0];
}


- (unsigned char) ja_unsignedCharAtIndex:(unsigned long)index
{
	return [self ja_unsignedCharAtIndex:index defaultValue:0];
}


- (unsigned short) ja_unsignedShortAtIndex:(unsigned long)index
{
	return [self ja_unsignedShortAtIndex:index defaultValue:0];
}


- (unsigned int) ja_unsignedIntAtIndex:(unsigned long)index
{
	return [self ja_unsignedIntAtIndex:index defaultValue:0];
}


- (unsigned long) ja_unsignedLongAtIndex:(unsigned long)index
{
	return [self ja_unsignedLongAtIndex:index defaultValue:0];
}


- (unsigned long) ja_unsignedIntegerAtIndex:(unsigned long)index
{
	return [self ja_unsignedIntegerAtIndex:index defaultValue:0];
}


- (unsigned long long) ja_unsignedLongLongAtIndex:(unsigned long)index
{
	return [self ja_unsignedLongLongAtIndex:index defaultValue:0];
}


- (BOOL) ja_boolAtIndex:(unsigned long)index
{
	return [self ja_boolAtIndex:index defaultValue:NO];
}


- (float) ja_floatAtIndex:(unsigned long)index
{
	return JAFloatFromObject([self ja_objectAtIndexNoThrow:index], 0.0f);
}


- (double) ja_doubleAtIndex:(unsigned long)index
{
	return JADoubleFromObject([self ja_objectAtIndexNoThrow:index], 0.0);
}


- (float) ja_nonNegativeFloatAtIndex:(unsigned long)index
{
	return JANonNegativeFloatFromObject([self ja_objectAtIndexNoThrow:index], 0.0f);
}


- (double) ja_nonNegativeDoubleAtIndex:(unsigned long)index
{
	return JANonNegativeDoubleFromObject([self ja_objectAtIndexNoThrow:index], 0.0);
}


- (id) ja_objectOfClass:(Class)class atIndex:(unsigned long)index
{
	return [self ja_objectOfClass:class atIndex:index defaultValue:nil];
}


- (NSString *) ja_stringAtIndex:(unsigned long)index
{
	return [self ja_stringAtIndex:index defaultValue:nil];
}


- (NSArray *) ja_arrayAtIndex:(unsigned long)index
{
	return [self ja_arrayAtIndex:index defaultValue:nil];
}


- (NSSet *) ja_setAtIndex:(unsigned long)index
{
	return [self ja_setAtIndex:index defaultValue:nil];
}


- (NSDictionary *) ja_dictionaryAtIndex:(unsigned long)index
{
	return [self ja_dictionaryAtIndex:index defaultValue:nil];
}


- (NSData *) ja_dataAtIndex:(unsigned long)index
{
	return [self ja_dataAtIndex:index defaultValue:nil];
}

@end


@implementation NSDictionary (JAPropertyListAccessors)

- (char) ja_charForKey:(id)key defaultValue:(char)value
{
	return JACharFromObject([self objectForKey:key], value);
}


- (short) ja_shortForKey:(id)key defaultValue:(short)value
{
	return JAShortFromObject([self objectForKey:key], value);
}


- (int) ja_intForKey:(id)key defaultValue:(int)value
{
	return JAIntFromObject([self objectForKey:key], value);
}


- (long) ja_longForKey:(id)key defaultValue:(long)value
{
	return JALongFromObject([self objectForKey:key], value);
}


- (long) ja_integerForKey:(id)key defaultValue:(long)value
{
	return JALongFromObject([self objectForKey:key], value);
}


- (long long) ja_longLongForKey:(id)key defaultValue:(long long)value
{
	return JALongLongFromObject([self objectForKey:key], value);
}


- (unsigned char) ja_unsignedCharForKey:(id)key defaultValue:(unsigned char)value
{
	return JAUnsignedCharFromObject([self objectForKey:key], value);
}


- (unsigned short) ja_unsignedShortForKey:(id)key defaultValue:(unsigned short)value
{
	return JAUnsignedShortFromObject([self objectForKey:key], value);
}


- (unsigned int) ja_unsignedIntForKey:(id)key defaultValue:(unsigned int)value
{
	return JAUnsignedIntFromObject([self objectForKey:key], value);
}


- (unsigned long) ja_unsignedLongForKey:(id)key defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self objectForKey:key], value);
}


- (unsigned long) ja_unsignedIntegerForKey:(id)key defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self objectForKey:key], value);
}


- (unsigned long long) ja_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)value
{
	return JAUnsignedLongLongFromObject([self objectForKey:key], value);
}


- (BOOL) ja_boolForKey:(id)key defaultValue:(BOOL)value
{
	return JABooleanFromObject([self objectForKey:key], value);
}


- (float) ja_floatForKey:(id)key defaultValue:(float)value
{
	return JAFloatFromObject([self objectForKey:key], value);
}


- (double) ja_doubleForKey:(id)key defaultValue:(double)value
{
	return JADoubleFromObject([self objectForKey:key], value);
}


- (float) ja_nonNegativeFloatForKey:(id)key defaultValue:(float)value
{
	return JANonNegativeFloatFromObject([self objectForKey:key], value);
}


- (double) ja_nonNegativeDoubleForKey:(id)key defaultValue:(double)value
{
	return JANonNegativeDoubleFromObject([self objectForKey:key], value);
}


- (id) ja_objectForKey:(id)key defaultValue:(id)value
{
	id					objVal = [self objectForKey:key];
	id					result;
	
	if (objVal != nil)  result = objVal;
	else  result = value;
	
	return result;
}


- (id) ja_objectOfClass:(Class)class forKey:(id)key defaultValue:(id)value
{
	id					objVal = [self objectForKey:key];
	id					result;
	
	if ([objVal isKindOfClass:class])  result = objVal;
	else  result = value;
	
	return result;
}


- (NSString *) ja_stringForKey:(id)key defaultValue:(NSString *)value
{
	return StringForObject([self objectForKey:key], value);
}


- (NSArray *) ja_arrayForKey:(id)key defaultValue:(NSArray *)value
{
	return [self ja_objectOfClass:[NSArray class] forKey:key defaultValue:value];
}


- (NSSet *) ja_setForKey:(id)key defaultValue:(NSSet *)value
{
	return SetForObject([self objectForKey:key], value);
}


- (NSDictionary *) ja_dictionaryForKey:(id)key defaultValue:(NSDictionary *)value
{
	return [self ja_objectOfClass:[NSDictionary class] forKey:key defaultValue:value];
}


- (NSData *) ja_dataForKey:(id)key defaultValue:(NSData *)value
{
	return [self ja_objectOfClass:[NSData class] forKey:key defaultValue:value];
}


- (char) ja_charForKey:(id)key
{
	return [self ja_charForKey:key defaultValue:0];
}


- (short) ja_shortForKey:(id)key
{
	return [self ja_shortForKey:key defaultValue:0];
}


- (int) ja_intForKey:(id)key
{
	return [self ja_intForKey:key defaultValue:0];
}


- (long) ja_longForKey:(id)key
{
	return [self ja_longForKey:key defaultValue:0];
}


- (long) ja_integerForKey:(id)key
{
	return [self ja_integerForKey:key defaultValue:0];
}


- (long long) ja_longLongForKey:(id)key
{
	return [self ja_longLongForKey:key defaultValue:0];
}


- (unsigned char) ja_unsignedCharForKey:(id)key
{
	return [self ja_unsignedCharForKey:key defaultValue:0];
}


- (unsigned short) ja_unsignedShortForKey:(id)key
{
	return [self ja_unsignedShortForKey:key defaultValue:0];
}


- (unsigned int) ja_unsignedIntForKey:(id)key
{
	return [self ja_unsignedIntForKey:key defaultValue:0];
}


- (unsigned long) ja_unsignedLongForKey:(id)key
{
	return [self ja_unsignedLongForKey:key defaultValue:0];
}


- (unsigned long) ja_unsignedIntegerForKey:(id)key
{
	return [self ja_unsignedIntegerForKey:key defaultValue:0];
}


- (unsigned long long) ja_unsignedLongLongForKey:(id)key
{
	return [self ja_unsignedLongLongForKey:key defaultValue:0];
}


- (BOOL) ja_boolForKey:(id)key
{
	return [self ja_boolForKey:key defaultValue:NO];
}


- (float) ja_floatForKey:(id)key
{
	return JAFloatFromObject([self objectForKey:key], 0.0f);
}


- (double) ja_doubleForKey:(id)key
{
	return JADoubleFromObject([self objectForKey:key], 0.0);
}


- (float) ja_nonNegativeFloatForKey:(id)key
{
	return JANonNegativeFloatFromObject([self objectForKey:key], 0.0f);
}


- (double) ja_nonNegativeDoubleForKey:(id)key
{
	return JANonNegativeDoubleFromObject([self objectForKey:key], 0.0);
}


- (id) ja_objectOfClass:(Class)class forKey:(id)key
{
	return [self ja_objectOfClass:class forKey:key defaultValue:nil];
}


- (NSString *) ja_stringForKey:(id)key
{
	return [self ja_stringForKey:key defaultValue:nil];
}


- (NSArray *) ja_arrayForKey:(id)key
{
	return [self ja_arrayForKey:key defaultValue:nil];
}


- (NSSet *) ja_setForKey:(id)key
{
	return [self ja_setForKey:key defaultValue:nil];
}


- (NSDictionary *) ja_dictionaryForKey:(id)key
{
	return [self ja_dictionaryForKey:key defaultValue:nil];
}


- (NSData *) ja_dataForKey:(id)key
{
	return [self ja_dataForKey:key defaultValue:nil];
}

@end


@implementation NSUserDefaults (JAPropertyListAccessors)

- (char) ja_charForKey:(NSString *)key defaultValue:(char)value
{
	return JACharFromObject([self objectForKey:key], value);
}


- (short) ja_shortForKey:(NSString *)key defaultValue:(short)value
{
	return JAShortFromObject([self objectForKey:key], value);
}


- (int) ja_intForKey:(NSString *)key defaultValue:(int)value
{
	return JAIntFromObject([self objectForKey:key], value);
}


- (long) ja_longForKey:(NSString *)key defaultValue:(long)value
{
	return JALongFromObject([self objectForKey:key], value);
}


- (long) ja_integerForKey:(NSString *)key defaultValue:(long)value
{
	return JALongFromObject([self objectForKey:key], value);
}


- (long long) ja_longLongForKey:(NSString *)key defaultValue:(long long)value
{
	return JALongLongFromObject([self objectForKey:key], value);
}


- (unsigned char) ja_unsignedCharForKey:(NSString *)key defaultValue:(unsigned char)value
{
	return JAUnsignedCharFromObject([self objectForKey:key], value);
}


- (unsigned short) ja_unsignedShortForKey:(NSString *)key defaultValue:(unsigned short)value
{
	return JAUnsignedShortFromObject([self objectForKey:key], value);
}


- (unsigned int) ja_unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)value
{
	return JAUnsignedIntFromObject([self objectForKey:key], value);
}


- (unsigned long) ja_unsignedLongForKey:(NSString *)key defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self objectForKey:key], value);
}


- (unsigned long) ja_unsignedIntegerForKey:(NSString *)key defaultValue:(unsigned long)value
{
	return JAUnsignedLongFromObject([self objectForKey:key], value);
}


- (unsigned long long) ja_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long)value
{
	return JAUnsignedLongLongFromObject([self objectForKey:key], value);
}


- (BOOL) ja_boolForKey:(NSString *)key defaultValue:(BOOL)value
{
	return JABooleanFromObject([self objectForKey:key], value);
}


- (float) ja_floatForKey:(NSString *)key defaultValue:(float)value
{
	return JAFloatFromObject([self objectForKey:key], value);
}


- (double) ja_doubleForKey:(NSString *)key defaultValue:(double)value
{
	return JADoubleFromObject([self objectForKey:key], value);
}


- (float) ja_nonNegativeFloatForKey:(NSString *)key defaultValue:(float)value
{
	return JANonNegativeFloatFromObject([self objectForKey:key], value);
}


- (double) ja_nonNegativeDoubleForKey:(NSString *)key defaultValue:(double)value
{
	return JANonNegativeDoubleFromObject([self objectForKey:key], value);
}


- (id) ja_objectForKey:(NSString *)key defaultValue:(id)value
{
	id					objVal = [self objectForKey:key];
	id					result;
	
	if (objVal != nil)  result = objVal;
	else  result = value;
	
	return result;
}


- (id) ja_objectOfClass:(Class)class forKey:(NSString *)key defaultValue:(id)value
{
	id					objVal = [self objectForKey:key];
	id					result;
	
	if ([objVal isKindOfClass:class])  result = objVal;
	else  result = value;
	
	return result;
}


- (NSString *) ja_stringForKey:(NSString *)key defaultValue:(NSString *)value
{
	return StringForObject([self objectForKey:key], value);
}


- (NSArray *) ja_arrayForKey:(NSString *)key defaultValue:(NSArray *)value
{
	return [self ja_objectOfClass:[NSArray class] forKey:key defaultValue:value];
}


- (NSSet *) ja_setForKey:(NSString *)key defaultValue:(NSSet *)value
{
	return SetForObject([self objectForKey:key], value);
}


- (NSDictionary *) ja_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)value
{
	return [self ja_objectOfClass:[NSDictionary class] forKey:key defaultValue:value];
}


- (NSData *) ja_dataForKey:(NSString *)key defaultValue:(NSData *)value
{
	return [self ja_objectOfClass:[NSData class] forKey:key defaultValue:value];
}


- (char) ja_charForKey:(NSString *)key
{
	return [self ja_charForKey:key defaultValue:0];
}


- (short) ja_shortForKey:(NSString *)key
{
	return [self ja_shortForKey:key defaultValue:0];
}


- (int) ja_intForKey:(NSString *)key
{
	return [self ja_intForKey:key defaultValue:0];
}


- (long) ja_longForKey:(NSString *)key
{
	return [self ja_longForKey:key defaultValue:0];
}


- (long long) ja_longLongForKey:(NSString *)key
{
	return [self ja_longLongForKey:key defaultValue:0];
}


- (unsigned char) ja_unsignedCharForKey:(NSString *)key
{
	return [self ja_unsignedCharForKey:key defaultValue:0];
}


- (unsigned short) ja_unsignedShortForKey:(NSString *)key
{
	return [self ja_unsignedShortForKey:key defaultValue:0];
}


- (unsigned int) ja_unsignedIntForKey:(NSString *)key
{
	return [self ja_unsignedIntForKey:key defaultValue:0];
}


- (unsigned long) ja_unsignedLongForKey:(NSString *)key
{
	return [self ja_unsignedLongForKey:key defaultValue:0];
}


- (long) ja_integerForKey:(NSString *)key
{
	return [self ja_integerForKey:key defaultValue:0];
}


- (unsigned long) ja_unsignedIntegerForKey:(NSString *)key
{
	return [self ja_unsignedIntegerForKey:key defaultValue:0];
}


- (BOOL) ja_boolForKey:(NSString *)key
{
	return [self ja_boolForKey:key defaultValue:NO];
}


- (unsigned long long) ja_unsignedLongLongForKey:(NSString *)key
{
	return [self ja_unsignedLongLongForKey:key defaultValue:0];
}


- (float) ja_nonNegativeFloatForKey:(NSString *)key
{
	return JANonNegativeFloatFromObject([self objectForKey:key], 0.0f);
}


- (double) ja_nonNegativeDoubleForKey:(NSString *)key
{
	return JANonNegativeDoubleFromObject([self objectForKey:key], 0.0);
}


- (id) ja_objectOfClass:(Class)class forKey:(NSString *)key
{
	return [self ja_objectOfClass:class forKey:key defaultValue:nil];
}


- (NSSet *) ja_setForKey:(NSString *)key
{
	return [self ja_setForKey:key defaultValue:nil];
}

@end


@implementation NSMutableArray (OOInserter)

- (void) ja_addInteger:(long)value
{
	[self addObject:[NSNumber numberWithLong:value]];
}


- (void) ja_addUnsignedInteger:(unsigned long)value
{
	[self addObject:[NSNumber numberWithUnsignedLong:value]];
}


- (void) ja_addFloat:(double)value
{
	[self addObject:[NSNumber numberWithDouble:value]];
}


- (void) ja_addBool:(BOOL)value
{
	[self addObject:[NSNumber numberWithBool:value]];
}


- (void) ja_insertInteger:(long)value atIndex:(unsigned long)index
{
	[self insertObject:[NSNumber numberWithLong:value] atIndex:index];
}


- (void) ja_insertUnsignedInteger:(unsigned long)value atIndex:(unsigned long)index
{
	[self insertObject:[NSNumber numberWithUnsignedLong:value] atIndex:index];
}


- (void) ja_insertFloat:(double)value atIndex:(unsigned long)index
{
	[self insertObject:[NSNumber numberWithDouble:value] atIndex:index];
}


- (void) ja_insertBool:(BOOL)value atIndex:(unsigned long)index
{
	[self insertObject:[NSNumber numberWithBool:value] atIndex:index];
}

@end


@implementation NSMutableDictionary (OOInserter)

- (void) ja_setInteger:(long)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithLong:value] forKey:key];
}


- (void) ja_setUnsignedInteger:(unsigned long)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithUnsignedLong:value] forKey:key];
}


- (void) ja_setLongLong:(long long)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithLongLong:value] forKey:key];
}


- (void) ja_setUnsignedLongLong:(unsigned long long)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithUnsignedLongLong:value] forKey:key];
}


- (void) ja_setFloat:(double)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithDouble:value] forKey:key];
}


- (void) ja_setBool:(BOOL)value forKey:(id)key
{
	[self setObject:[NSNumber numberWithBool:value] forKey:key];
}

@end


@implementation NSMutableSet (OOInserter)

- (void) ja_addInteger:(long)value
{
	[self addObject:[NSNumber numberWithLong:value]];
}


- (void) ja_addUnsignedInteger:(unsigned long)value
{
	[self addObject:[NSNumber numberWithUnsignedLong:value]];
}


- (void) ja_addFloat:(double)value
{
	[self addObject:[NSNumber numberWithDouble:value]];
}


- (void) ja_addBool:(BOOL)value
{
	[self addObject:[NSNumber numberWithBool:value]];
}

@end


long long JALongLongFromObject(id object, long long defaultValue)
{
	long long llValue;
	
	if ([object respondsToSelector:@selector(longLongValue)])  llValue = [object longLongValue];
	else if ([object respondsToSelector:@selector(longValue)])  llValue = [object longValue];
	else if ([object respondsToSelector:@selector(intValue)])  llValue = [object intValue];
	else llValue = defaultValue;
	
	return llValue;
}


unsigned long long JAUnsignedLongLongFromObject(id object, unsigned long long defaultValue)
{
	unsigned long long ullValue;
	
	if ([object respondsToSelector:@selector(unsignedLongLongValue)])  ullValue = [object unsignedLongLongValue];
	else if ([object respondsToSelector:@selector(unsignedLongValue)])  ullValue = [object unsignedLongValue];
	else if ([object respondsToSelector:@selector(unsignedIntValue)])  ullValue = [object unsignedIntValue];
	else if ([object respondsToSelector:@selector(intValue)])  ullValue = [object intValue];
	else ullValue = defaultValue;
	
	return ullValue;
}


static inline BOOL IsSpaceOrTab(int value)
{
	return value == ' ' || value == '\t';
}


static BOOL IsZeroString(NSString *string)
{
	/*	I don't particularly like regexps, but there are occasions...
		To match NSString's behaviour for intValue etc. with non-zero numbers,
		we need to skip any leading spaces or tabs (but not line breaks), get
		an optional minus sign, then at least one 0. Any trailing junk is
		ignored. It is assumed that this function is called for strings whose
		numerical value has already been determined to be 0.
	*/
	
	unsigned long i = 0, count = [string length];
#define PEEK() ((i >= count) ? -1 : [string characterAtIndex:i])
	
	while (IsSpaceOrTab(PEEK()))  ++i;	// Skip spaces and tabs
	if (PEEK() == ' ')  ++i;			// Skip optional hyphen-minus
	return PEEK() == '0';				// If this is a 0, it's a numerical string.
	
#undef PEEK
}


static BOOL BooleanFromString(NSString *string, BOOL defaultValue)
{
	if (NSOrderedSame == [string caseInsensitiveCompare:@"yes"] ||
		NSOrderedSame == [string caseInsensitiveCompare:@"true"] ||
		NSOrderedSame == [string caseInsensitiveCompare:@"on"] ||
		[string doubleValue] != 0.0)	// Floating point is used so values like @"0.1" are treated as nonzero.
	{
		return YES;
	}
	else if (NSOrderedSame == [string caseInsensitiveCompare:@"no"] ||
			 NSOrderedSame == [string caseInsensitiveCompare:@"false"] ||
			 NSOrderedSame == [string caseInsensitiveCompare:@"off"] ||
			 IsZeroString(string))
	{
		return NO;
	}
	return defaultValue;
}


BOOL JABooleanFromObject(id object, BOOL defaultValue)
{
	BOOL result;
	
	if ([object isKindOfClass:[NSString class]])
	{
		result = BooleanFromString(object, defaultValue);
	}
	else
	{
		if ([object respondsToSelector:@selector(boolValue)])  result = [object boolValue];
		else if ([object respondsToSelector:@selector(intValue)])  result = [object intValue] != 0;
		else result = defaultValue;
	}
	
	return result;
}


float JAFloatFromObject(id object, float defaultValue)
{
	float result;
	
	if ([object respondsToSelector:@selector(floatValue)])
	{
		result = [object floatValue];
		if (result == 0.0f && [object isKindOfClass:[NSString class]] && !IsZeroString(object))  return defaultValue;
	}
	else if ([object respondsToSelector:@selector(doubleValue)])  result = [object doubleValue];
	else if ([object respondsToSelector:@selector(intValue)])  result = [object intValue];
	else result = defaultValue;
	
	return result;
}


double JADoubleFromObject(id object, double defaultValue)
{
	double result;
	
	if ([object respondsToSelector:@selector(doubleValue)])
	{
		result = [object doubleValue];
		if (result == 0.0 && [object isKindOfClass:[NSString class]] && !IsZeroString(object))  return defaultValue;
	}
	else if ([object respondsToSelector:@selector(floatValue)])  result = [object floatValue];
	else if ([object respondsToSelector:@selector(intValue)])  result = [object intValue];
	else result = defaultValue;
	
	return result;
}


float JANonNegativeFloatFromObject(id object, float defaultValue)
{
	float result;
	
	if ([object respondsToSelector:@selector(floatValue)])
	{
		result = [object floatValue];
		if (result == 0.0f && [object isKindOfClass:[NSString class]] && !IsZeroString(object))  return defaultValue;
	}
	else if ([object respondsToSelector:@selector(doubleValue)])  result = [object doubleValue];
	else if ([object respondsToSelector:@selector(intValue)])  result = [object intValue];
	else return defaultValue;	// Don't clamp default
	
	return fmaxf(result, 0.0f);
}


double JANonNegativeDoubleFromObject(id object, double defaultValue)
{
	double result;
	
	if ([object respondsToSelector:@selector(doubleValue)])
	{
		result = [object doubleValue];
		if (result == 0.0 && [object isKindOfClass:[NSString class]] && !IsZeroString(object))  return defaultValue;
	}
	else if ([object respondsToSelector:@selector(floatValue)])  result = [object floatValue];
	else if ([object respondsToSelector:@selector(intValue)])  result = [object intValue];
	else return defaultValue;	// Don't clamp default
	
	return fmax(result, 0.0);
}


static NSSet *SetForObject(id object, NSSet *defaultValue)
{
	if ([object isKindOfClass:[NSArray class]])  return [NSSet setWithArray:object];
	else if ([object isKindOfClass:[NSSet class]])  return [[object copy] autorelease];
	
	else return defaultValue;
}


static NSString *StringForObject(id object, NSString *defaultValue)
{
	if ([object isKindOfClass:[NSString class]])  return object;
	if ([object isKindOfClass:[NSDate class]])  return [object description];
	if ([object respondsToSelector:@selector(stringValue)])
	{
		object = [object stringValue];
		if ([object isKindOfClass:[NSString class]])  return object;
	}
	
	return defaultValue;
}
