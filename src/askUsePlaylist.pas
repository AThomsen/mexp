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


unit askUsePlaylist;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ExtCtrls, CheckLst;

type
  TAskUsePlaylistForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    list: TCheckListBox;
    Panel2: TPanel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AskUsePlaylistForm: TAskUsePlaylistForm;

implementation

{$R *.DFM}

procedure TAskUsePlaylistForm.Button2Click(Sender: TObject);
var
   i:integer;
begin
     for i:=0 to list.Items.Count-1 do
     list.State[i] := cbChecked
end;

procedure TAskUsePlaylistForm.Button3Click(Sender: TObject);
var
   i:integer;
begin
     for i:=0 to list.Items.Count-1 do
         list.State[i] := cbUnChecked
end;

end.
