{******************************************************************************}
{                                                                              }
{ DiskSpace64, Version 2.0                                                     }
{                                                                              }
{ The contents of this file are subject to the Mozilla Public License Version  }
{ 1.0 (the "License"); you may not use this file except in compliance with the }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ The Original Code is DiskSpace64.pas.                                        }
{                                                                              }
{ The Initial Developer of the Original Code is Peter J. Haas. Portions        }
{ created by Peter J. Haas are Copyright (C) 1999-2001 Peter J. Haas. All      }
{ Rights Reserved.                                                             }
{                                                                              }
{ Contributor(s):                                                              }
{   Hendrik Friedel, Udo Nesshoever, Christian Hintz (testing)                 }
{                                                                              }
{                                                                              }
{ Contact:     (if possible you write in german language)                      }
{   EMail:     PeterJHaas@t-online.de                                          }
{   HomePage:  http://home.t-online.de/home/PeterJHaas/delphi.htm              }
{                                                                              }
{                                                                              }
{ Limitations:                                                                 }
{   Delphi 2 to 5                                                              }
{   Win9x, Win NT, Win 2000                                                    }
{   FAT, FAT32, NTFS, CDFS                                                     }
{                                                                              }
{ Tested with:                                                                 }
{   - Delphi 2.0                                                               }
{   - Delphi 3.02                                                              }
{   - Delphi 4.03                               (tested only with Version 1)   }
{   - Delphi 5.0 UP 1                                                          }
{                                                                              }
{   - Win95 de, Win95 SR2.1 de,                 (tested only with Version 1)   }
{   - Win98 First Edition de,                   (tested only with Version 1)   }
{   - Win98 Second Edition de,                                                 }
{   - Win NT 4.0 (SP6a) de                      (tested only with Version 1)   }
{   - Win 2000 Professional, de                                                }
{                                                                              }
{   - FAT, FAT32, NTFS, CDFS                                                   }
{   - FAT, FAT32, CDFS over Windows Network (UNC and mapped)                   }
{   - mapped drives NT and Novell 3.12          (tested only with Version 1)   }
{                                                                              }
{                                                                              }
{ History:                                                                     }
{   2000-03-25                                                                 }
{     Version 0.9 beta                                                         }
{   2000-04-08                                                                 }
{     Version 1.0: final release, without Changes                              }
{   2001-04-10                                                                 }
{     Version 2.0: add support for UNC in Delphi 5                             }
{                                                                              }
{                                                                              }
{******************************************************************************}

unit DiskSpace64;

interface
uses
  Windows, SysUtils;

// Delphi 2
{$ifdef Ver90}
{$define NoInt64}
{$define NoSysUtilsGetDiskFreeSpaceEx}
{$endif}

// Delphi 3
{$ifdef Ver100}
{$define NoInt64}
{$define NoSysUtilsGetDiskFreeSpaceEx}
{$endif}

// Delphi 4,  this definition can be remove possibly
{$ifdef Ver120}
{$define NoSysUtilsGetDiskFreeSpaceEx}
{$endif}

type
  PDS64Long = ^TDS64Long;
  {$ifdef NoInt64}
  TDS64Long = Comp;
  {$else}
  TDS64Long = Int64;
  {$endif}

// APath must contain at least the drive letter and a ':' or must be empty
// empty => current drive

// Delphi 2 return 0, if the call failed,
// all another Delphi versions create a EWin32Error 


// return the total number of free bytes on the disk that are available to
// the user associated with the calling thread
function GetFreeSpace64(const APath: String): TDS64Long;

// return the total number of bytes on the disk that are available to the
// user associated with the calling thread
function GetTotalSpace64(const APath: String): TDS64Long;

implementation

// return the root (e.g. 'C:\')
function ExtractFileRoot(const APath: String): String;
begin
  {$ifdef Ver90}
  if (Length(APath) >= 2) and (APath[2] = ':') then
    Result := Copy(APath, 1, 2)
  else
  {$endif}
  Result := ExtractFileDrive(APath);
  if Length(Result) = 0 then Exit;
  if Result[Length(Result)] <> '\' then Result := Result + '\';
end;

// Support for GetDiskFreeSpaceEx

{$ifdef NoSysUtilsGetDiskFreeSpaceEx}
type
  TGetDiskFreeSpaceExFunc =
     function(lpDirectoryName: PChar;
              var lpFreeBytesAvailableToCaller,
                  lpTotalNumberOfBytes: TDS64Long;
              lpTotalNumberOfFreeBytes: PDS64Long): Bool; stdcall;

var
  GetDiskFreeSpaceEx : TGetDiskFreeSpaceExFunc = Nil;

function SubstGetDiskFreeSpaceEx(DirectoryName: PChar;
                                 var FreeBytesAvailableToCaller,
                                     TotalNumberOfBytes: TDS64Long;
                                 TotalNumberOfFreeBytes: PDS64Long): Bool; stdcall;
var
  BytesPerCluster : TDS64Long;
  SectorsPerCluster     : DWord;
  BytesPerSector        : DWord;
  NumberOfFreeClusters  : DWord;
  TotalNumberOfClusters : DWord;
begin
  Result := GetDiskFreeSpace(DirectoryName,
                             SectorsPerCluster,
                             BytesPerSector,
                             NumberOfFreeClusters,
                             TotalNumberOfClusters);
  if Result then begin
    BytesPerCluster := SectorsPerCluster * BytesPerSector;
    FreeBytesAvailableToCaller := BytesPerCluster * NumberOfFreeClusters;
    TotalNumberOfBytes := BytesPerCluster * TotalNumberOfClusters;
    if Assigned(TotalNumberOfFreeBytes) then
      TotalNumberOfFreeBytes^ := FreeBytesAvailableToCaller;
  end;
end;

procedure Init;
var
  KernalDLL : THandle;
begin
  KernalDLL := GetModuleHandle('Kernel32.DLL');
  if KernalDLL <> 0 then
    GetDiskFreeSpaceEx := GetProcAddress(KernalDLL, 'GetDiskFreeSpaceExA');
  if Not Assigned(GetDiskFreeSpaceEx) then
    GetDiskFreeSpaceEx := @SubstGetDiskFreeSpaceEx;
end;
{$endif}

procedure GetSpace64(const APath: String;
                     var ATotalBytes, AFreeBytes: TDS64Long);
begin
  if Not {$ifndef NoSysUtilsGetDiskFreeSpaceEx}SysUtils.{$endif}
         GetDiskFreeSpaceEx(Pointer(ExtractFileRoot(APath)),
                            AFreeBytes, ATotalBytes, Nil) then
    {$ifdef Ver90}
    begin
      ATotalBytes := 0;
      AFreeBytes  := 0;
    end;
    {$else}
    RaiseLastWin32Error;
    {$endif}
end;

function GetFreeSpace64(const APath: String): TDS64Long;
var
  x : TDS64Long;
begin
  GetSpace64(APath, x, Result);
end;

function GetTotalSpace64(const APath: String): TDS64Long;
var
  x : TDS64Long;
begin
  GetSpace64(APath, Result, x);
end;

initialization
{$ifdef NoSysUtilsGetDiskFreeSpaceEx}
  Init;
{$endif}
finalization
end.
