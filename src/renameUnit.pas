{-----------------------------------------------------------------------------
This file is part of MEXP.

    MEXP is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    MEXP is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with MEXP.  If not, see <http://www.gnu.org/licenses/>.

The Initial Developer of the Original Code is Anders Thomsen [mail at andersthomsen dot dk]

Contributions by:

-----------------------------------------------------------------------------}


unit renameUnit;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, 
  StdCtrls, VirtualTrees, Qstrings, WAIPC;

type
  TrenameForm = class(TForm)
    topLabel: TLabel;
    file1Label: TLabel;
    toLabel: TLabel;
    file2Label: TLabel;
    newNameEdit: TEdit;
    ButLabel: TLabel;
    Label2: TLabel;
    OvrBtn: TButton;
    delBtn: TButton;
    renameBut: TButton;
    cancelBtn: TButton;
    Label1: TLabel;
    procedure newNameEditChange(Sender: TObject);
    procedure file1LabelDblClick(Sender: TObject);
    procedure file2LabelDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
         playedOnce:boolean;
         procedure play(s:string);
    { Private declarations }
  public
    sourceFile:string;
    targetFile:string;
    procedure init;
    { Public declarations }
  end;

var
  renameForm: TrenameForm;

implementation

uses MainForm, defs;

{$R *.DFM}

procedure TRenameForm.play(s:string);
begin
     if fileexists(s) then
     with MainFormInstance do
     begin
          if not playedOnce then
             SaveWinplayUndo;
          playedOnce := true;
          winplaylist.clear;
          WinplayInsertFname(s, nil, amNowhere, kill_NONE, false, false);
          winplaySave(0);
          button2(hwnd_winamp)
     end
end;

procedure TRenameForm.init;
function FormatFilename(fname:String):String;
begin
     result := fname + #13 + '(' + floattoStrF(GetFileSize(fname),ffnumber,8,0) + ' bytes)'
end;
begin
     file1Label.Caption := FormatFilename(sourceFile);
     file2Label.Caption := FormatFilename(targetFile);
     newNameEdit.Text := targetFile
end;
procedure TrenameForm.newNameEditChange(Sender: TObject);
begin
     renameBut.Enabled := not Q_SameText(targetFile, newNameEdit.text)
end;

procedure TrenameForm.file1LabelDblClick(Sender: TObject);
begin
     play(sourceFile)
end;

procedure TrenameForm.file2LabelDblClick(Sender: TObject);
begin
     play(targetFile)
end;

procedure TrenameForm.FormCreate(Sender: TObject);
begin
     playedOnce := false
end;

procedure TrenameForm.FormDestroy(Sender: TObject);
begin
     if playedOnce then
        MainFormInstance.winplayundo
end;

end.
