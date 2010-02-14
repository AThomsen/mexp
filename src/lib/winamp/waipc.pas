(*    This unit will allow control of Nullsofts awesome Mp3 Player
 * Winamp from within Delphi 3 Applications (it will probably work with 
 * Delphi 2 but I have not tried it).  This unit is FREEWARE if you like
 * it or have any questions about it let me know emslie@gpu.srv.ualberta.ca
 *
 *)

unit WAIPC;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, {RzFilSys, }StdCtrls, Spin;

Const
          {WM_WA_IPC = WM_USER;}
     IPC_GETVERSION = 0;
       IPC_PLAYFILE = 100;
         IPC_DELETE = 101;
      IPC_STARTPLAY = 102;
          IPC_CHDIR = 103;
      IPC_ISPLAYING = 104;
  IPC_GETOUTPUTTIME = 105;
     IPC_JUMPTOTIME = 106;
  IPC_WRITEPLAYLIST = 120;

       WINAMP_OPTIONS_EQ = 40036;
   WINAMP_OPTIONS_PLEDIT = 40040;
         WINAMP_VOLUMEUP = 40058;
       WINAMP_VOLUMEDOWN = 40059;
           WINAMP_FFWD5S = 40060;
            WINAMP_REW5S = 40061;
          WINAMP_BUTTON1 = 40044;
          WINAMP_BUTTON2 = 40045;
          WINAMP_BUTTON3 = 40046;
          WINAMP_BUTTON4 = 40047;
          WINAMP_BUTTON5 = 40048;
    WINAMP_BUTTON1_SHIFT = 40144;
    WINAMP_BUTTON2_SHIFT = 40145;
    WINAMP_BUTTON3_SHIFT = 40146;
    WINAMP_BUTTON4_SHIFT = 40147;
    WINAMP_BUTTON5_SHIFT = 40148;
     WINAMP_BUTTON1_CTRL = 40154;
     WINAMP_BUTTON2_CTRL = 40155;
     WINAMP_BUTTON3_CTRL = 40156;
     WINAMP_BUTTON4_CTRL = 40157;
     WINAMP_BUTTON5_CTRL = 40158;
         WINAMP_PREVSONG = 40198;
        WINAMP_FILE_PLAY = 40029;
    WINAMP_OPTIONS_PREFS = 40012;
      WINAMP_OPTIONS_AOT = 40019;
       WINAMP_HELP_ABOUT = 40041;



Procedure GetVersion;
{IPC_GETVERSION is sent to the window, and the return value is the version
		Version 1.55 = 0x1551
		Version 1.6b = 0x16A0
		Version 1.60 = 0x16AF
		Version 1.61 = 0x16B0
		Version 1.62 = 0x16B1
		Version 1.64 = 0x16B3
		Version 1.666 = 0x16B4
		Version 1.69 = 0x16B5
		Version 1.70 = 0x1700
		Version 1.72 = 0x1702
		Version 1.72 = 0x1703
	the command_data parameter is 0.     }

procedure AddMp3ToPlayList(mp3ToAdd:string; hwnd_winamp:HWND);
Procedure DeletePlayList(hwnd_winamp:HWND);
Procedure StartPlay(hwnd_winamp:HWND);
Procedure ChangeDir(DirToChangeTo:string; hwnd_winamp:HWND);
Function PlayBackStatus(hwnd_winamp:HWND) : integer;
{	IPC_ISPLAYING returns the status of playback.
	If it returns 1, it is playing. if it returns 3, it is paused, if it returns 0, it is not playing.
	If it returns something other than 1,3,or 0, something is screwed.
}

Function GetOutPutTime( x : integer; hwnd_winamp:HWND): Integer;
{	IPC_GETOUTPUTTIME returns the position in milliseconds of the
      	current song (lParam = 0), or the song length, in seconds (lParam = 1).
	Returns -1 if not playing or error.}
function JumpToTime(new_song_pos:integer; hwnd_winamp:HWND):integer;
{    	*ONLY AVAILABLE IN v1.60+*
	IPC_JUMPTOTIME sets the position in milliseconds of the current song (approximately)
	Returns -1 if not playing, 1 on eof, or 0 if successful }
Function WritePlaylist(hwnd_winamp:HWND) : Integer;
{    	*ONLY AVAILABLE IN v1.666+*
	IPC_WRITEPLAYLIST writes the current playlist to <winampdir>\\Winamp.pl }

// THESE MIGHT CHANGE in the future :)
//Also, you can send standard WM_COMMAND messages to the Winamp window (for other controls), including
// Send using SendMessage(hwnd_winamp,WM_COMMAND,WINAMP_OPTIONS_EQ/*orwhatever*/,0);

Procedure EQ(hwnd_winamp:HWND);
// toggles the EQ window
Procedure PlayList(hwnd_winamp:HWND);
// toggles the playlist window
Procedure VolumeUp(hwnd_winamp:HWND);
// turns the volume up a little
Procedure VolumeDown(hwnd_winamp:HWND);
// turns the volume down a little
Procedure Forward5(hwnd_winamp:HWND);
// fast forwards 5 seconds
Procedure Rewind5(hwnd_winamp:HWND);
// rewinds 5 seconds

// the following are the five main control buttons, with optionally shift or control pressed
// (for the exact functions of each, just try it out)
Procedure Button1(hwnd_winamp:HWND);
Procedure Button2(hwnd_winamp:HWND);
Procedure Button3(hwnd_winamp:HWND);
Procedure Button4(hwnd_winamp:HWND);
Procedure Button5(hwnd_winamp:HWND);
Procedure Button1_Shift(hwnd_winamp:HWND);
Procedure Button2_Shift(hwnd_winamp:HWND);
Procedure Button3_Shift(hwnd_winamp:HWND);
Procedure Button4_Shift(hwnd_winamp:HWND);
Procedure Button5_Shift(hwnd_winamp:HWND);
Procedure Button1_CTRL(hwnd_winamp:HWND);
Procedure Button2_CTRL(hwnd_winamp:HWND);
Procedure Button3_CTRL(hwnd_winamp:HWND);
Procedure Button4_CTRL(hwnd_winamp:HWND);
Procedure Button5_CTRL(hwnd_winamp:HWND);
Procedure PrevSong(hwnd_winamp:HWND);
// always goes to the previous song (unlike button 1), 1.666+
Procedure PopUpLoadFile(hwnd_winamp:HWND);
// pops up the load file(s) box
Procedure PopUpPreferences(hwnd_winamp:HWND);
// pops up the preferences
Procedure AlwaysOnTop(hwnd_winamp:HWND);
// toggles always on top
Procedure PopUpAboutBox(hwnd_winamp:HWND);
// pops up the about box :)


implementation

//Var hWnd_WinAmp : hWnd;

{Procedure GethWnd_WinAmp;
Begin
 hwnd_winamp := FindWindow('Winamp v1.x', nil);
End;}

Procedure GetVersion;
Begin{
	IPC_GETVERSION is sent to the window, and the return value is the version
		Version 1.55 = 0x1551
		Version 1.6b = 0x16A0
		Version 1.60 = 0x16AF
		Version 1.61 = 0x16B0
		Version 1.62 = 0x16B1
		Version 1.64 = 0x16B3
		Version 1.666 = 0x16B4
		Version 1.69 = 0x16B5
		Version 1.70 = 0x1700
		Version 1.72 = 0x1702
		Version 1.72 = 0x1703
	the command_data parameter is 0.
	so,
	if (SendMessage(hwnd_winamp,WM_WA_IPC,0,IPC_GETVERSION) != 0x1551)
		MessageBox(NULL,"Error, Winamp 1.55 not found","Warning",MB_OK);
}end;

procedure AddMp3ToPlayList(mp3ToAdd:string; hwnd_winamp:HWND);
Var
x : integer;
begin
  Mp3ToAdd:=MP3ToAdd+#0;
  for x:=0 to Length(MP3ToAdd) do
      PostMessage(hwnd_winamp,wm_user,ord(mp3toadd[x]),IPC_PLAYFILE);
  PostMessage(hwnd_winamp,wm_user,0,IPC_PLAYFILE);
end;

Procedure DeletePlayList(hwnd_winamp:HWND);
begin
  SendMessage(hwnd_winamp,WM_USER,0,IPC_DELETE);
end;

Procedure StartPlay(hwnd_winamp:HWND);
begin
  SendMessage(hwnd_winamp,WM_USER,0,IPC_STARTPLAY);
end;

Procedure ChangeDir(DirToChangeTo:string; hwnd_winamp:HWND);
Var
x : integer;
begin
  DirToChangeTo:=DirToChangeTo+#0;
for x:=0 to Length(DirToChangeTo) do
  PostMessage(hwnd_winamp,wm_user,ord(DirToChangeTo[x]),IPC_CHDIR);
  PostMessage(hwnd_winamp,wm_user,0,IPC_CHDIR);
end;

Function PlayBackStatus(hwnd_winamp:HWND) : integer;
{	IPC_ISPLAYING returns the status of playback.
	If it returns 1, it is playing. if it returns 3, it is paused, if it returns 0, it is not playing.
	If it returns something other than 1,3,or 0, something is screwed.
}
Begin
  PlayBackStatus:= SendMessage(hwnd_winamp,WM_USER,0,IPC_ISPLAYING);
End;


Function GetOutPutTime( x : integer; hwnd_winamp:HWND): Integer;
{	IPC_GETOUTPUTTIME returns the position in milliseconds of the
      	current song (lParam = 0), or the song length, in seconds (lParam = 1).
	Returns -1 if not playing or error.}
begin
  if x = 0 then
   GetOutPutTime := SendMessage(hwnd_winamp,WM_USER,x,IPC_GETOUTPUTTIME)
   else
  if x = 1 then
   GetOutPutTime := SendMessage(hwnd_winamp,WM_USER,x,IPC_GETOUTPUTTIME);
end;

function JumpToTime(new_song_pos:integer; hwnd_winamp:HWND):integer;
{    	*ONLY AVAILABLE IN v1.60+*
	IPC_JUMPTOTIME sets the position in milliseconds of the current song (approximately)
	Returns -1 if not playing, 1 on eof, or 0 if successful }
Begin
  JumpToTIme:=SendMessage(hwnd_winamp,WM_USER,new_song_pos,IPC_JUMPTOTIME);
End;

Function WritePlaylist(hwnd_winamp:HWND) : Integer;
{    	*ONLY AVAILABLE IN v1.666+*
	IPC_WRITEPLAYLIST writes the current playlist to <winampdir>\\Winamp.pl }
Begin
 WritePlayList :=  SendMessage(hwnd_winamp,WM_USER,0,IPC_WRITEPLAYLIST);
{	(cursong is the index of the current song in the playlist)   }
End;


// THESE MIGHT CHANGE in the future :)
//Also, you can send standard WM_COMMAND messages to the Winamp window (for other controls), including
// Send using SendMessage(hwnd_winamp,WM_COMMAND,WINAMP_OPTIONS_EQ/*orwhatever*/,0);

Procedure ExecuteMessage(MessageToExecute:integer; hwnd_winamp:HWND);
Begin
  SendMessage(hwnd_winamp,WM_COMMAND,MessageToExecute,0);
End;

Procedure EQ(hwnd_winamp:HWND);
// toggles the EQ window
Begin
     ExecuteMessage(WINAMP_OPTIONS_EQ, hwnd_winamp);
End;

Procedure PlayList(hwnd_winamp:HWND);
// toggles the playlist window
Begin
      ExecuteMessage(WINAMP_OPTIONS_PLEDIT, hwnd_winamp);
End;

Procedure VolumeUp(hwnd_winamp:HWND);
// turns the volume up a little
begin
     ExecuteMessage(WINAMP_VOLUMEUP, hwnd_winamp);
End;

Procedure VolumeDown(hwnd_winamp:HWND);
// turns the volume down a little
Begin
     ExecuteMessage(WINAMP_VOLUMEDOWN, hwnd_winamp);
End;

Procedure Forward5(hwnd_winamp:HWND);
// fast forwards 5 seconds
Begin
ExecuteMessage(WINAMP_FFWD5S, hwnd_winamp);
End;

Procedure Rewind5(hwnd_winamp:HWND);
// rewinds 5 seconds
begin
ExecuteMessage(WINAMP_REW5S, hwnd_winamp);
End;


// the following are the five main control buttons, with optionally shift or control pressed
// (for the exact functions of each, just try it out)
Procedure Button1(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON1, hwnd_winamp);
End;

Procedure Button2(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON2, hwnd_winamp);
End;

Procedure Button3(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON3, hwnd_winamp);
End;

Procedure Button4(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON4, hwnd_winamp);
End;

Procedure Button5(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON5, hwnd_winamp);
End;

Procedure Button1_Shift(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON1_SHIFT, hwnd_winamp);
End;

Procedure Button2_Shift(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON2_SHIFT, hwnd_winamp);
End;

Procedure Button3_Shift(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON3_SHIFT, hwnd_winamp);
End;

Procedure Button4_Shift(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON4_SHIFT, hwnd_winamp);
End;

Procedure Button5_Shift(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_BUTTON5_SHIFT, hwnd_winamp);
End;

Procedure Button1_CTRL(hwnd_winamp:HWND);
Begin
 ExecuteMessage(WINAMP_BUTTON1_CTRL, hwnd_winamp);
End;
Procedure Button2_CTRL(hwnd_winamp:HWND);
Begin
 ExecuteMessage(WINAMP_BUTTON2_CTRL, hwnd_winamp);
End;
Procedure Button3_CTRL(hwnd_winamp:HWND);
Begin
 ExecuteMessage(WINAMP_BUTTON3_CTRL, hwnd_winamp);
End;
Procedure Button4_CTRL(hwnd_winamp:HWND);
Begin
 ExecuteMessage(WINAMP_BUTTON4_CTRL, hwnd_winamp);
End;
Procedure Button5_CTRL(hwnd_winamp:HWND);
Begin
 ExecuteMessage(WINAMP_BUTTON5_CTRL, hwnd_winamp);
End;


Procedure PrevSong(hwnd_winamp:HWND);
Begin
ExecuteMessage(WINAMP_PREVSONG, hwnd_winamp);
// always goes to the previous song (unlike button 1), 1.666+
End;

Procedure PopUpLoadFile(hwnd_winamp:HWND);
// pops up the load file(s) box
Begin
ExecuteMessage(WINAMP_FILE_PLAY, hwnd_winamp);
End;

Procedure PopUpPreferences(hwnd_winamp:HWND);
// pops up the preferences
Begin
ExecuteMessage(WINAMP_OPTIONS_PREFS, hwnd_winamp);
End;

Procedure AlwaysOnTop(hwnd_winamp:HWND);
// toggles always on top
Begin
ExecuteMessage(WINAMP_OPTIONS_AOT, hwnd_winamp);
End;

Procedure PopUpAboutBox(hwnd_winamp:HWND);
// pops up the about box :)
Begin
ExecuteMessage(WINAMP_HELP_ABOUT, hwnd_winamp);
End;


end.
