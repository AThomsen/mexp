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


unit delfiles;

interface

uses Windows, SysUtils, Classes, Forms, Controls, StdCtrls, ExtCtrls;

type
  Tdeletefromhd = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
		Bevel1: TBevel;
    Label1: TLabel;
    files: TListBox;
    DeleteEmtyDirs: TCheckBox;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
		{ Public declarations }
  end;

var
  deletefromhd: Tdeletefromhd;

implementation

uses MainForm;

{$R *.DFM}

procedure Tdeletefromhd.CancelBtnClick(Sender: TObject);
begin
        deletefromhd.close
end;

procedure Tdeletefromhd.FormShow(Sender: TObject);
begin
     deleteFromHD.FocusControl(okBtn)
end;

procedure Tdeletefromhd.FormCreate(Sender: TObject);
begin
     Icon := MainFormInstance.Icon1.picture.icon;
end;

end.
