// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
library gen_mexp;

{%ToDo 'gen_mexp.todo'}
{%File 'Languages\english.lan'}
{%File 'Languages\english.mnu'}
{%ToDo 'mexp.todo'}
{%File 'readme.txt'}

uses
  Forms,
  windows,
  shellapi,
  messages,
  sysutils,
  MyTBits in 'lib\MyTBits.pas',
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
  QStringList in 'lib\QStringList.pas',
  QCSStringList in 'lib\QCSStringList.pas',
  NetDirTest in 'lib\NetDirTest.pas',
  FileTreePreview in 'FileTreePreview.pas' {FilePreviewForm},
  renameUnit in 'renameUnit.pas' {renameForm},
  UndoListU in 'UndoListU.pas' {undoListForm},
  LanguageConstants in 'LanguageConstants.pas',
  askUsePlaylist in 'askUsePlaylist.pas' {AskUsePlaylistForm},
  TagCutterUnit in 'TagCutterUnit.pas' {TagCutter},
  cddbUnit in 'cddbUnit.pas' {CddbForm},
  Snap in 'Snap.pas',
  MexpIniFile in 'MexpIniFile.pas',
  ExPopupList in 'lib\controls\ExPopupList.pas',
  MEXPtypes in 'MEXPtypes.pas',
  MyMemoryStream in 'lib\MyMemoryStream.pas',
  RecHashTable in 'RecHashTable.pas',
  MyId3v2Base in 'lib\audio\MyId3v2Base.pas',
  Id3tags in 'lib\audio\ID3Tags.pas',
  pngimage in 'lib\pngimage\pngimage.pas',
  zlibpas in 'lib\pngimage\zlibpas.pas',
  pnglang in 'lib\pngimage\pnglang.pas';

exports
 	winampGetGeneralPurposePlugin;
begin
end.

