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


unit groupsunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, ActiveX,
  StdCtrls, VirtualTrees, QStrings, inuptbox2U, MEXPtypes;

type
  Tgroupsform = class(TForm)
    Button1: TButton;
    Label4: TLabel;
    GroupTree: TVirtualStringTree;
    Button2: TButton;
    Button3: TButton;
    procedure GroupTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var Text: WideString);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GroupTreeChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure GroupTreeDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure GroupTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure GroupTreeNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure GroupTreeEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
  private
  	procedure FillTree;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  groupsform: Tgroupsform;

implementation

uses MainForm, defs;

Type
	TNodeData = Record
  	group: PGroupRec;
    index: Integer;
  end;
  PNodeData = ^TNodeData;

{$R *.DFM}

procedure Tgroupsform.GroupTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var Text: WideString);
var
	nd: PNodeData;
begin
	nd := GroupTree.GetNodeData(node);
	text := nd.Group.Name
end;

procedure Tgroupsform.Button2Click(Sender: TObject);
var
	s:String;
  gr:PgroupRec;
  nameExists: boolean;
  i: integer;
begin
	s:='';
	if not MainFormInstance.Inputboxx('Add new group', 'Enter the name of the new group:', s) then
		exit;
	Q_trimInPlace(s);
	if length(s) <> 0 then
	begin
  	//Check if there's another group with this name
  	nameExists := false;
	  for i:=0 to GroupList.Count-1 do
	  	nameExists := nameExists or Q_SameText(PGroupRec(GroupList.Items[i]).Name, s);
	  if nameExists then
  	begin
	  	MainFormInstance.ShowmessageX('Cannot add new group - a group named "' + s + '" already exists.');
	    exit
	  end;

		new(gr);
		gr.name := s;
		gr.Checkstate := GroupCheckState_Checked;
		groupList.Add(gr);
    FillTree;
	end
end;

procedure Tgroupsform.Button3Click(Sender: TObject);
var     aNode : PVirtualNode;
        i, x, x2, groupToDeleteIdx, answer: integer;
        rec: Prec;
        nd: PNodeData;
        tagValues : PTagValues;
        recs, tagValuesList, rollBackValues: TList;
begin
  if (grouptree.GetFirstSelected <> nil) then
  begin
  	answer :=	MainFormInstance.YesNoBox3Btn('Delete group', 'Do you want to delete this group from the file-tags as well?', 'Yes', 'No, just delete the group', 'Cancel', 1);
    if answer <> 3 then
    begin
      screen.cursor := crhourglass;
      GroupTree.BeginUpdate;
      aNode := grouptree.GetFirstSelected;
      nd := groupTree.GetNodeData(aNode);
      groupToDeleteIdx := nd.index;

      recs := TList.Create;
      tagValuesList := TList.Create;
      rollBackValues := TList.Create;

      for i:=0 to reclist.Count-1 do
      	if MainFormInstance.hasGroup(prec(reclist.Items[i]).Groups, groupToDeleteIdx) then
        begin
        	recs.Add(reclist.Items[i]);
          New(tagValues);
          SetLength(tagValues^, 1);
          tagValues^[0].field := FRemoveGroup;
      		tagValues^[0].value := PGroupRec(groupList.items[groupToDeleteIdx]).Name;
          tagValuesList.Add(tagValues);

          New(tagValues);
          SetLength(tagValues^, 1);
          tagValues^[0].field := FAddGroup;
      		tagValues^[0].value := PGroupRec(groupList.items[groupToDeleteIdx]).Name;
          rollBackValues.Add(tagValues)
        end;

        if MainFormInstance.UpdateRecValues(recs, tagValuesList, rollBackValues, 'Deleting group from tag...', true, answer=1) <> UpdateRecValuesResult_Cancelled then
        begin
        	for i:=0 to reclist.count-1 do
		      begin
    		    rec := reclist.Items[i];

            if length(rec.Groups) > 0 then
		        begin
	  	        for x:=0 to length(rec.Groups)-1 do
		          begin
                if rec.Groups[x] = groupToDeleteIdx then
                begin
                  for x2:=x to length(rec.groups)-2 do
                    rec.Groups[x2] := rec.Groups[x2+1];
                  setLength(rec.Groups, length(rec.Groups)-1)
                end
                else
                  if rec.Groups[x] > groupToDeleteIdx then
                    rec.Groups[x] := rec.Groups[x]-1
              end
            end
          end;

	    	dispose(PGroupRec(groupList.items[groupToDeleteIdx]));
  	  	groupList.Delete(groupToDeleteIdx);
        FillTree;
      end;

      GroupTree.EndUpdate;
      screen.cursor := crdefault
    end
  end
end;

procedure Tgroupsform.GroupTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
	Button3.Enabled := GroupTree.Selected[Node]
end;

procedure TGroupsForm.FillTree;
var
	i: Integer;
  nd: PNodeData;
  aNode: PVirtualNode;
begin
	GroupTree.BeginUpdate;
	GroupTree.RootNodeCount := GroupList.Count;
  aNode := GroupTree.GetFirst;
  for i:=0 to GroupList.Count-1 do
  begin
  	nd := GroupTree.GetNodeData(aNode);
    nd.group := GroupList.Items[i];
    nd.index := i;
    aNode := GroupTree.GetNext(aNode);
  end;
  GroupTree.EndUpdate
end;

procedure Tgroupsform.FormCreate(Sender: TObject);
begin
	Icon := MainFormInstance.Icon1.picture.icon;
  GroupTree.NodeDataSize := SizeOf(TNodeData);
  FillTree;
end;

procedure Tgroupsform.GroupTreeDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
	Accept := ((Mode = dmAbove) or (Mode = dmBelow) or (Mode = dmOnNode)) and (Sender = Source)
end;

procedure Tgroupsform.GroupTreeDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
	attMode: TVTNodeAttachMode;

  tbl: array of byte;
  aNode: PVirtualNode;
  nd: PNodeData;

  i, j: integer;
  rec: PRec;
begin
	attMode := amNoWhere;
	case Mode of
    dmAbove, dmOnNode: attMode := amInsertBefore;
    dmBelow: attMode := amInsertAfter;

  end;

	sender.MoveTo(Sender.GetFirstSelected, Sender.DropTargetNode, attMode, false);

  SetLength(tbl, groupList.Count);
  aNode := GroupTree.GetFirst;
  while aNode <> nil do
  begin
		nd := GroupTree.GetNodeData(aNode);
    tbl[nd.Index] := aNode.Index;
    nd.Index := aNode.Index;
    GroupList.Items[nd.Index] := nd.group;
    aNode := GroupTree.GetNext(aNode)
  end;

  for i:=0 to Reclist.Count-1 do
  begin
  	rec := Reclist.Items[i];
    for j:=0 to Length(rec.Groups)-1 do
    	rec.Groups[j] := tbl[rec.Groups[j]]
  end;

  Finalize(tbl)
end;

procedure Tgroupsform.GroupTreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
	nd: PNodeData;
begin
	nd := Sender.GetNodeData(Node);
  MainFormInstance.ChangeGroupName(nd.Group, newtext)
end;

procedure Tgroupsform.GroupTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
	Allowed := true
end;

end.

