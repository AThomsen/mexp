unit ExPopupList;

interface

uses Controls; // for CM_BASE

const
  CM_MENUCLOSED    = CM_BASE - 1;
  CM_ENTERMENULOOP = CM_BASE - 2;
  CM_EXITMENULOOP  = CM_BASE - 3;

implementation

uses Messages, Forms, Menus;

Type
  TExPopupList = class( TPopupList )
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

{ TMyPopupList }

procedure TExPopupList.WndProc(var Message: TMessage);
  Procedure Send( msg: Integer );
  Begin
    If Assigned( Screen.Activeform ) Then
      Screen.ActiveForm.Perform( msg, Message.wparam, Message.lparam );
  End;
begin
  Case message.Msg Of
    WM_ENTERMENULOOP: Send( CM_ENTERMENULOOP );
    WM_EXITMENULOOP : Send( CM_EXITMENULOOP );
    WM_MENUSELECT   :
      With TWMMenuSelect( Message ) Do
        If (Menuflag = $FFFF) and (Menu = 0) Then
          Send( CM_MENUCLOSED );
  End; { Case }
  inherited;
end;

Initialization
  Popuplist.Free;
  PopupList:= TExPopupList.Create;
  // Note: will be freed by Finalization section of Menus unit.
end.


