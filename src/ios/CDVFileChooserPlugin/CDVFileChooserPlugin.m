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

#import "CDVFileChooserPlugin.h"

@implementation CDVFileChooserPlugin

- (void) chooseFile:(CDVInvokedUrlCommand*)command
{
    NSOpenPanel* dialog = [NSOpenPanel openPanel];
    
    [dialog setCanChooseFiles:YES];
    [dialog setAllowsMultipleSelection:NO];
    [dialog setCanChooseDirectories:NO];
    
    if ([command.arguments count] > 0) {
        [dialog setDirectoryURL:[NSURL URLWithString:[command.arguments objectAtIndex:0]]];
    }
    
    CDVPluginResult* result = nil;
    
    if ([dialog runModal] == NSOKButton) {
        NSURL* url = [[dialog URLs] objectAtIndex:0];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[url description]];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) chooseFolder:(CDVInvokedUrlCommand*)command
{
    NSOpenPanel* dialog = [NSOpenPanel openPanel];
    
    [dialog setCanChooseFiles:NO];
    [dialog setAllowsMultipleSelection:NO];
    [dialog setCanChooseDirectories:YES];
    [dialog setCanCreateDirectories:YES];
    
    CDVPluginResult* result = nil;
    
    if ([dialog runModal] == NSOKButton) {
        NSURL* url = [[dialog URLs] objectAtIndex:0];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[url description]];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
