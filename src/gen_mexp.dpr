library gen_mexp;

{%ToDo 'gen_mexp.todo'}
{%File 'MEXP\Languages\english.lan'}
{%File 'MEXP\Languages\english.mnu'}
{%ToDo 'mexp.todo'}
{%File 'readme.txt'}

uses
//  FastMove,
  Forms,
  windows,
  shellapi,
  messages,
  sysutils,
  MyTBits in 'lib\TMyTBits.pas',
  Defs in 'Defs.pas',
  MainForm in 'MainForm.pas' {MainForm},
  prefernces in 'prefernces.pas' {pref},
  delfiles in 'delfiles.pas' {deletefromhd},
  dbprefe in 'dbprefe.pas' {dbpref},
  groupsunit in 'groupsunit.pas' {groupsform},
  addgroupU in 'addgroupU.pas' {addgroup},
  DubWiz in 'DubWiz.pas' {DubWizForm},
  inuptbox2U in 'lib\controls\inuptbox2U.pas' {InputBox2},
  OrganizeFiles in 'OrganizeFiles.pas' {OrgFiles},
  TagEditor in 'TagEditor.pas' {Editor},
  QStringList in 'QStringList.pas',
  QCSStringList in 'QCSStringList.pas',
  NetDirTest in 'lib\NetDirTest.pas',
  FileTreePreview in 'FileTreePreview.pas' {FilePreviewForm},
  renameUnit in 'renameUnit.pas' {renameForm},
  UndoListU in 'UndoListU.pas' {undoListForm},
  LanguageConstants in 'LanguageConstants.pas',
  askUsePlaylist in 'askUsePlaylist.pas' {AskUsePlaylistForm},
  TagCutterUnit in 'TagCutterUnit.pas' {TagCutter},
  cddbUnit in 'cddbUnit.pas' {CddbForm},
  Snap in 'Snap.pas',
  SpecialPanel in 'lib\controls\SpecialPanel.pas',
  MexpIniFile in 'MexpIniFile.pas',
  ExPopupList in 'lib\controls\ExPopupList.pas',
  MEXPtypes in 'MEXPtypes.pas',
  MyMemoryStream in 'lib\MyMemoryStream.pas',
  RecHashTable in 'RecHashTable.pas',
  MyId3v2Base in 'lib\audio\MyId3v2Base.pas';

exports
 	winampGetGeneralPurposePlugin;
begin
end.

