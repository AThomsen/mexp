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

unit addgroupU;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, 
  StdCtrls;

type
  Taddgroup = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Label2: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  addgroup: Taddgroup;

implementation

uses MainForm;

{$R *.DFM}

procedure Taddgroup.Button3Click(Sender: TObject);
begin
	if listbox1.SelCount = 0 then
  	MainFormInstance.showmessageX('Please select a group from the list')
  else
  	addgroup.ModalResult := mrok
end;

procedure Taddgroup.FormCreate(Sender: TObject);
begin
	Icon := MainFormInstance.Icon1.picture.icon;
end;

end.
