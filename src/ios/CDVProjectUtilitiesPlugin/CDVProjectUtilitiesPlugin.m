/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVProjectUtilitiesPlugin.h"
#import <Cordova/ShellUtils.h>

@implementation CDVProjectUtilitiesPlugin

- (void) createNewProject:(CDVInvokedUrlCommand*)command
{
    NSString* cmdFormat = @"cd %@;bin/create %@ %@ %@ %@";
    
    NSString* cordovaPath = [command.arguments objectAtIndex:0];
    BOOL shared = [[command.arguments objectAtIndex:1] boolValue];
    NSString* pathToNewProject = [command.arguments objectAtIndex:2];
    NSString* packageName = [command.arguments objectAtIndex:3];
    NSString* projectName = [command.arguments objectAtIndex:4];
    
    NSURL* ctemp = [NSURL URLWithString:cordovaPath];
    NSURL* ptemp = [NSURL URLWithString:pathToNewProject];
    
    NSString* cmd = [NSString stringWithFormat:cmdFormat,
                     ctemp.path,
                     shared? @"--shared" : @"",
                     ptemp.path,
                     packageName,
                     projectName
                     ];
    [ShellUtils executeShellTaskAsync:cmd withCallbackId:command.callbackId forPlugin:self];
}

@end
