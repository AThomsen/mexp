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


unit LanguageConstants;
interface
uses classes, Sysutils, menus, Qstrings;

         Function GetText(lanConst:integer; const params:array of string):String; overload;
         Function GetText(lanConst:integer):String; overload;
         Procedure LoadLanguage(filename:string);
         Procedure LoadMenuLanguage(filename:string);
         Procedure unloadLanguage;
Type
    TlanguageRec = packed record
                 ID:integer;
                 s:string;
    end;
    PlanguageRec = ^TlanguageRec;

Const
MENUBEGIN: String = '!BeginMenuID:';

///  General
     TXT_Yes                     :integer=1;
     TXT_No                      :integer=2;
     TXT_Cancel                  :integer=3;
     TXT_Close                   :integer=4;
     TXT_Save                    :integer=5;
     TXT_Add                     :integer=6;
     TXT_Remove                  :integer=7;
     TXT_Start                   :integer=8;
     TXT_CouldNotConnect         :integer=9;

     TXT_Done                    :integer=10;
     TXT_PleaseWait              :integer=11;
     TXT_Scanning                :integer=12;
     TXT_ScanningEx              :integer=13;
     TXT_UnSupportedFileVersion  :integer=14;
     TXT_NoDatabaseFound         :integer=18;
     TXT_CouldNotDeleteFile      :integer=19;
     TXT_Delete                  :integer=20;
     TXT_SpecifyDir              :integer=21;
     TXT_OverwriteFile           :integer=22;
     TXT_OverwriteFileAlreadyEx  :integer=23;
     TXT_CouldNotCopyFromTo      :integer=24;
     TXT_CouldNotCreateDirFileNodeCopied       :integer=25;
     TXT_FileCouldNotBeFound     :integer=26;
     TXT_MovingFromTo            :integer=27;
     TXT_FileAlreadyExists       :integer=28;
     TXT_ErrorMovingCouldNotOVR  :integer=29;
     TXT_AlreadyScanning				 :integer=30;
     TXT_QuicklistAlreadyExists	 :integer=31;
     TXT_Unknown								 :integer=32;

     TXT_ColumnFile              :integer=50;
     TXT_ColumnArtist            :integer=51;
     TXT_ColumnTitle             :integer=52;
     TXT_ColumnAlbum             :integer=53;
     TXT_ColumnGenre             :integer=54;
     TXT_ColumnYear              :integer=55;
     TXT_ColumnComment           :integer=56;
     TXT_ColumnTrack             :integer=57;
     TXT_ColumnKbps              :integer=58;
     TXT_ColumnKhz               :integer=59;
     TXT_ColumnChannels          :integer=60;
     TXT_ColumnLength            :integer=61;
     TXT_ColumnFileSize          :integer=62;
     TXT_ColumnLocation          :integer=63;
     TXT_ColumnGroups            :integer=64;
     TXT_ColumnFilePath          :integer=65;
     TXT_ColumnFileName          :integer=66;
     TXT_ColumnQuality           :integer=67;
     TXT_ColumnType              :integer=68;
     TXT_ColumnAddedToDatabase   :integer=69;
     TXT_ColumnChanged           :integer=70;
     TXT_ColumnCompilation       :integer=71;
     TXT_ColumnPlaylistPosition  :integer=72;
     TXT_ColumnEnqueuePosition 	 :integer=73;
     TXT_SampleRate							 :integer=74;
     TXT_BitRate							 	 :integer=75;
     TXT_ColumnTags							 :integer=76;
     TXT_ColumnLyrics            :integer=77;
     TXT_DirectoryStructure			 :integer=78;
     TXT_TrimmedDirectoryStructure:integer=79;
     TXT_ColumnPartOfSet				:integer = 80;
     TXT_ColumnRating						:integer = 81;
     TXT_ColumnArtistSortOrder	:integer = 82;
     TXT_ColumnAutoscanned			:integer = 83;
     TXT_ColumnPlaycount				:integer = 84;

//Main List
     TXT_UsePlaylistCaption      :integer=100;
     TXT_UsePlaylistText         :integer=101;
     TXT_ErrorAssigningVal       :integer=102;
     TXT_AGroupNamedText         :integer=103;
     TXT_SearchForNewFiles       :integer=104;
     TXT_SearchForFiles          :integer=105;
     TXT_SearchingDir            :integer=106;
     TXT_NoFilesFoundCancelling  :integer=107;
     TXT_FoundFilesUpdatingList  :integer=108;
     TXT_ScanningFiles           :integer=109;
     TXT_FileOfFname             :integer=110;
     TXT_ErrorReading            :integer=111;
     TXT_SelectFileToSaveAppend  :integer=112;
     TXT_SaveCurrentSearchMask   :integer=113;
     TXT_CannotDeleteToplist     :integer=114;
     TXT_EnterNewQLnameCaption   :integer=115;
     TXT_EnterNewQLnameText      :integer=116;
     TXT_DeleteTheDatabase       :integer=117;
     TXT_DeleteDatabase          :integer=118;
     TXT_CannotRenameToplist     :integer=119;
     TXT_RenameQuicklist         :integer=120;
     TXT_CouldNotRenameQL        :integer=121;
     TXT_CopyingFiles            :integer=122;
     TXT_DeviceNotPresentDontScan:integer=123;
     TXT_SelectFileToAppend      :integer=124;
     TXT_PlayedOneTime           :integer=125;
     TXT_PlayedXtimes            :integer=126;
     TXT_CouldNotRenameDir       :integer=127;
     TXT_NotAllFilesFoundInDB    :integer=128;
     TXT_CouldNotOpenPLforWriting:integer=129;
     TXT_ErrorCreatingFile       :integer=130;
     TXT_DeletePlaylist          :integer=131;
     TXT_DeleteThePlaylist       :integer=132;
		 TXT_SelectUndoFile          :integer=133;
		 TXT_SearchIn								 :integer=134;
     TXT_OptimizingDatabase			 :integer=135;

     TXT_SearchOr                :integer=150;
     TXT_SearchAnd               :integer=151;
     TXT_AddToQL                 :integer=152;
     TXT_CopyToHD                :integer=153;
     TXT_ConvertToArtistAlbum    :integer=154;
     TXT_OnlyShowSelectedGroups  :integer=155;
		 TXT_ConfigureGroups         :integer=156;
		 TXT_FileMustBeInAllCheckedGroups: integer= 157;
		 TXT_Exclusive								:integer=158;
		 TXT_AndOperator							:integer=159;

//Main List - GUI (2)
		 TXT_guiGlobalShortCuts			 :integer=169;
		 TXT_guiMainList             :integer=170;
     TXT_guiPlaylist             :integer=171;
     TXT_guiTree                 :integer=172;
     TXT_guiQuicklist            :integer=173;
     TXT_guiQuicklistPLcon       :integer=174;
     TXT_guiCollapseAll          :integer=175;
     TXT_guiAll                  :integer=176;
     TXT_guiGroups               :integer=177;
     TXT_guiClear                :integer=178;
		 TXT_guiRepeat               :integer=179;
		 TXT_guiShuffle              :integer=180;

		 TXT_PreviousHint            :integer=181;
		 TXT_PlayHint             	 :integer=182;
		 TXT_NextHint             	 :integer=183;
     ///
     TXT_SearchLabelHint         :integer=184;
     TXT_GroupLabelHint          :integer=185;
     TXT_f0Hint                  :integer=186;
     TXT_MinimizeWinplayHint     :integer=187;
     TXT_repLabelHint            :integer=188;
     TXT_ClearButtonHint         :integer=189;
     TXT_ShuLabelHint            :integer=190;
     TXT_AllButtonHint           :integer=191;
     TXT_CollapseButtonHint      :integer=192;
     TXT_MinimizeQ2Hint          :integer=193;
     TXT_MinimizeQ1Hint          :integer=194;
     TXT_ChangeTrackTo123Hint    :integer=195;

TXT_SetGenreTo									:integer=196;
TXT_SetRatingTo                 :integer=197;

TXT_GetMoreSkinsHere						:integer=219;
TXT_NoSkinsFound								:integer=220;
TXT_CorruptDatabasefile					:integer=221;
TXT_TotalPlayingTime						:integer=222;
TXT_ChangeTrackNo								:integer=223;
TXT_EnterFirstTrackNo						:integer=224;
TXT_CouldNotRenamePlaylist			:integer=225;

TXT_SetArtistTo                 :integer=226;
TXT_SetAlbumTo                  :integer=227;
TXT_RemoveFromGenre             :integer=228;
TXT_AddToGenre                  :integer=229;
TXT_RemoveFromGroup             :integer=230;
TXT_AddToGroup                  :integer=231;
TXT_UnsetCompilation            :integer=232;
TXT_SetCompilation              :integer=233;
TXT_SetCompilationAlbumTo       :integer=234;
TXT_TagFiles                    :integer=235;

TXT_Stopped											:integer=236;
TXT_Paused											:integer=237;
TXT_Playing											:integer=238;

TXT_Mono												:integer=239;
TXT_Stereo											:integer=240;

TXT_FilenameLength							:integer=241;

TXT_UnlockPartyMode							:integer=242;
TXT_EnterPassword               :integer=243;
TXT_RetypePassword							:integer=244;
TXT_EnablePartyMode							:integer=245;
TXT_PasswordDoesntMatch					:integer=246;
TXT_PartyOn											:integer=247;

TXT_Groups											:integer=250;
TXT_Playlists										:integer=251;
TXT_Compilations								:integer=252;

TXT_RemoveFromDB								:integer=253;
TXT_RemoveFromDBText						:integer=254;

TXT_RepairPlaylist							:integer=255;
TXT_RepairPlaylistAsk						:integer=256;

TXT_SetYearTo										:integer=257;

//Preferences
     TXT_WritingVBR              :integer=300;
     TXT_AddText                 :integer=301;
     TXT_BeforeScanningAdd       :integer=308;
     TXT_FontsAndColors          :integer=309;
     TXT_Licence                 :integer=310;

//Preferences GUI
     TXT_guiPreferences          :integer=400;
     TXT_guiPrimDbName           :integer=401;
     TXT_guiMp3PathsGB           :integer=402;
     TXT_guiMp3sToScanNote       :integer=403;
     TXT_TextColor               :integer=404;
     TXT_guiScanPlaylists        :integer=405;
     TXT_guiAutoAddGroups        :integer=406;
     TXT_guiRepairVBR            :integer=407;
     TXT_guiScan                 :integer=408;
     TXT_guiExcludeList          :integer=409;
     TXT_guiExludeListText       :integer=410;
     TXT_guiCopyToMyMusicGB      :integer=411;
     TXT_guiCopyToMyMusicText1   :integer=412;
     TXT_guiCopyToMyMusicText2   :integer=413;
     TXT_Patterns                :integer=414;
     TXT_guiMyMusic              :integer=415;
     TXT_guiSettings             :integer=416;
     TXT_LoadDatabase            :integer=417;
     TXT_OnWinampStartup         :integer=418;
     TXT_OnFirstTimeShowed       :integer=419;
     TXT_AutoSearch              :integer=420;
     TXT_SearchMode              :integer=421;
     TXT_SearchAsYouType         :integer=422;
     TXT_SearchAfterxxxTime      :integer=423;
     TXT_SearchOnEnter           :integer=424;
     TXT_SearchModeText          :integer=425;

     TXT_guiDragNDrop            :integer=426;
     TXT_guiDragNDrop11          :integer=427;
     TXT_guiDragNDrop12          :integer=428;
     TXT_guiDragNDrop21          :integer=429;
     TXT_guiDragNDrop22          :integer=430;

     TXT_guiSaveSearch           :integer=431;
     TXT_guiSaveSearcString      :integer=432;
     TXT_guiSaveSearchTreeSel    :integer=433;

     TXT_guiAutoResetSearch      :integer=434;
     TXT_guiEnableReset          :integer=435;
     TXT_guiTreeViceVersa        :integer=436;

     TXT_guiDefaultOperator      :integer=437;
     TXT_guiDefaultOperator1     :integer=438;
     TXT_guiDefaultOperator2     :integer=439;

     TXT_guiAppearence           :integer=440;
     TXT_guiProgramIcons         :integer=441;
     TXT_guiProgramIcons1        :integer=442;
     TXT_guiProgramIcons2        :integer=443;

     TXT_guiToplist              :integer=444;
     TXT_guiIncludeToplist       :integer=445;
     TXT_guiNrOfSongsInToplist   :integer=446;
     TXT_guiShowPlayCount        :integer=447;

     TXT_guiScrollBar            :integer=448;
     TXT_guiRegular              :integer=449;
     TXT_guiFlat                 :integer=450;
     TXT_guiWinampStyle          :integer=451;

     TXT_guiAutoResizeColumns    :integer=452;

     TXT_guiFileSizeCol          :integer=453;
     TXT_guiFileSizeCol1         :integer=454;
     TXT_guiFileSizeCol2         :integer=455;

     TXT_guiShowHints            :integer=456;
     TXT_guiShowHintsToolTip     :integer=457;

     TXT_guiSampleRateCol        :integer=458;
     TXT_guiSampleRateCol1       :integer=459;
     TXT_guiSampleRateCol2       :integer=460;

     TXT_guiTagCorrecting        :integer=461;
     TXT_guiTagCorretingText     :integer=462;
     TXT_guiIfArtistUndef        :integer=463;
     TXT_guiConvert_to           :integer=464;
     TXT_guiRemoveBrackets       :integer=465;
     TXT_guiTitleCropFilename    :integer=466;
     TXT_guiAdvancedTrackCalc    :integer=467;
     TXT_guiUseSubDirs           :integer=468;

     TXT_guiKeyboardShortcuts    :integer=469;
     TXT_guiShortTree1           :integer=470;
     TXT_guiShortTree2           :integer=471;
     TXT_guiEnterNewShortcut     :integer=472;
     TXT_guiApplyToSelected      :integer=473;

     TXT_guiFreeTextFields       :integer=482;

     TXT_guiUsers                :integer=490;
     TXT_guiEnableMultipleUsers  :integer=491;
     TXT_guiCurrentUser          :integer=492;
     TXT_guiUserDBSavedIn        :integer=493;
     TXT_guiUsersText            :integer=494;
		 TXT_restartSettings         :integer=495;

     TXT_UseCustomDatabaseColor	:integer=496;

		 TXT_guiAutoResizeColumnHeaders : integer=500;
		 TXT_Columns									:integer=501;
		 TXT_guiHideInfoShownInTree		:integer=502;

     TXT_CorrectTags							:integer = 503;

		 TXT_guiTrayIconOptions				 :integer = 510;
		 TXT_guiTrayIconOptions1			 :integer = 511;
		 TXT_guiTrayIconOptions2			 :integer = 512;

		 TXT_CalcCRC									 :integer = 513;


//Pref Tree
	TXT_DblClkTree			:integer = 514;
  TXT_Toggle					:integer = 515;
  TXT_PlayAll					:integer = 516;
  TXT_EnqueueAll			:integer = 517;

  TXT_HelpGuide				:integer = 520;
  TXT_CorrectCasing		:integer = 521;
  TXT_AssignShortcut	:integer = 522;
  TXT_SpecialKeys			:integer = 523;
  TXT_UseEnterKey			:integer	= 524;
  TXT_UseSpaceKey			:integer = 525;
  TXT_Bold            :integer = 526;
  TXT_Italic					:integer = 527;

  TXT_DefaultSettings	:integer	= 528;
  TXT_autoformatNewText		:integer = 529;
	TXT_SyncTabs		:integer = 530;
	TXT_SaveGroups		:integer = 531;
	TXT_EnableOnTabChange		:integer = 532;
	TXT_AlwaysCopyFromDB		:integer = 533;
	TXT_AutoCopyFromDB		:integer = 534;
	TXT_AutoGetLyrics		:integer = 535;
	TXT_CloseEditorAfterSave		:integer = 536;
	TXT_HideOnEdit		:integer = 537;
	TXT_StripId3v2FromUnsupported		:integer = 538;
  TXT_EditingValuesInMainList		:integer = 539;
  TXT_UpdateFileTags						:integer = 540;
  TXT_UpdateFileTagsNote				:integer = 541;

  TXT_CheckForNewVersion		:integer = 542;
	TXT_GotoHomepage					:integer = 543;

  TXT_ShowGroupsAtFilter		:integer = 544;
	TXT_ShowGroupsInTree		:integer = 545;
	TXT_ShowGroupSettingsInTree		:integer = 546;

  TXT_SelectionRectangle		:integer = 547;
  TXT_OutLined							:integer = 548;
  TXT_Solid									:integer = 549;

  TXT_ThisCanBeToggledWithALT	:integer = 550;

  TXT_PressingEnterInSearchField : integer = 551;
  TXT_Nothing										 : integer = 552;

  TXT_DoubleclickingTheList			 : integer = 553;
  TXT_Play                       : integer = 554;
  TXT_Enqueue                    : integer = 555;
  TXT_EnqueueAndPlay             : integer = 556;
  TXT_PunchIn                    : integer = 557;
  TXT_PunchInAndPlay             : integer = 558;
  TXT_FocusPlayingSongOnChange	 : integer = 559;
  TXT_Enabled										 : integer = 560;
//  TXT_NumberOfTitlesWithSameArtist		:integer = 561;
	TXT_AutoAdjustTreeOnResize		:integer = 562;
//	TXT_TheFixNote								:integer = 563;
//	TXT_TheFix										:integer = 564;
	TXT_IndividualSO							:integer = 565;
  TXT_Tagging										:integer = 566;
  TXT_AllowXxxOnDrop						:integer = 567;
	TXT_TreeTagAltPressed					:integer = 568;
	TXT_TreeTagShowConfirm					:integer = 569;
	TXT_ShowCompilations		:integer = 570;
	TXT_CompilationsInSubTree				:integer = 571;
  TXT_CompilationPlacement        :integer = 572;
  TXT_Before                      :integer = 573;
  TXT_MergeWithOtherNodes         :integer = 574;
  TXT_After                       :integer = 575;
  TXT_winplaylistEntryFormatting  :integer = 576;
  TXT_CompilationFiles            :integer = 577;
  TXT_UsePattern                  :integer = 578;
  TXT_ControlWinampPlaylist				:integer = 579;
  TXT_ControlWinampPlaylistText		:integer = 580;
  TXT_IgnoreDuplicates						:integer = 581;
  TXT_IgnoreNew                   :integer = 582;
  TXT_ReplaceExisting							:integer = 583;
	TXT_ContinuousPlay							:integer = 584;
  TXT_continuousPlayText					:integer = 585;
  TXT_WinplayShowColumns					:integer = 586;
  TXT_WinplayShowColumnsNote			:integer = 587;
  TXT_DblClickQuicklist						:integer = 588;
  TXT_AddEntireListAndPlaySel			:integer = 589;
  TXT_PlaySelSong									:integer = 590;
  TXT_EnqueueSelSong							:integer = 591;
  TXT_PunchInSelSong							:integer = 592;

  TXT_SelectSkin									:integer = 593;
  TXT_EditSkin										:integer = 594;
  TXT_AutoChangeSkin							:integer = 595;
  TXT_AllowColorOverride					:integer = 596;

  TXT_DisableDBmanagement		:integer = 597;
	TXT_DisableTagging		:integer = 598;
	TXT_DisableDeleteFromHD		:integer = 599;
	TXT_DisableOrganizeDuplicateFiles		:integer = 600;
	TXT_DisableEditQuicklist		:integer = 601;
	TXT_DisableEditPlaylist		:integer = 602;
	TXT_DisableDeleteMoveWinampPlaylist		:integer = 603;
	TXT_AlwaysEnqueueToWP		:integer = 604;
	TXT_PartyLockColumns		:integer = 605;
	TXT_PartyAllKeySearches		:integer = 606;
	TXT_PartyDisablePlaybackControls		:integer = 607;
	TXT_PartyDisableVolumeControl		:integer = 608;
	TXT_partyDisableRemote		:integer = 609;
	TXT_AlwaysEnableKill		:integer = 610;
  TXT_LimitMEXP						:integer = 611;
  TXT_LockWindows					:integer = 612;
	TXT_LockAltTab					:integer = 613;
	TXT_LockCtrlAltDel			:integer = 614;
  TXT_SaveDatabase			 	:integer = 615;
  TXT_SaveDBText					:integer = 616;
  TXT_SaveDBNote					:integer = 617;
  TXT_SkipId3v1Genre			:integer = 618;
  TXT_CaseSensitiveSort	  :integer = 619;
  TXT_ShowCoverText			  :integer = 620;
  TXT_ShowCoverShowHideMB	:integer = 621;
  TXT_ShowImages					:integer = 622;
  TXT_dontAddIfExistsInWinplay: integer = 623;
  TXT_ScanAllFiles				:integer = 624;
  TXT_ScanNewFiles				:integer = 625;
  TXT_CancelScan					:integer = 626;
  TXT_LockMouse						:integer = 627;
  TXT_RelativePlaylistPath:integer = 628;
  TXT_ShowTotalDurationLabel: integer = 629;
  TXT_DontChange					:integer = 630;

  TXT_MusicDatabase				:integer = 1000;
  TXT_AutoScan						:integer = 1001;
  TXT_TagCorrecting				:integer = 1002;
  TXT_TagEditor						:integer = 1003;
	TXT_PartyMode						:integer = 1004;
  TXT_Skins								:integer = 1005;
  TXT_SplitterCaptionBars	:integer = 1006;
  TXT_CaptionBarButtons		:integer = 1007;
  TXT_PlayingText					:integer = 1008;
  TXT_Users								:integer = 1009;
  TXT_CheckForUpdate			:integer = 1011;
  TXT_About								:integer = 1012;
  TXT_Credits							:integer = 1013;
	TXT_ShortcutAlreadyAssignedTo	: integer = 1014;
  TXT_ShortcutAlreadyAssignedToGlobal	: integer = 1015;
	TXT_Connecting					:integer = 1016;
  TXT_NewVersionavailable :integer = 1017;
  TXT_NoNewAvailable			:integer = 1018;
  TXT_Author							:integer = 1019;
  TXT_CorrespondTo				:integer = 1020;
  TXT_Prompt							:integer = 1021;
  TXT_FileTypes						:integer = 1022;
  TXT_CustomFields				:integer = 1023;
  TXT_CustomField					:integer = 1024;

  TXT_NewTreeStructure		:integer = 1100;
  TXT_ViewModes						:integer = 1101;
  TXT_RevertSelectedViewMode: integer = 1102;
  TXT_RevertAllViewModes	:integer = 1103;
  TXT_RevertSelectedViewModeMsg: integer = 1104;
  TXT_RevertAllViewModesMsg	:integer = 1105;
  TXT_NewNode							:integer = 1106;
  TXT_DeleteNode					:integer = 1107;
  TXT_IncludeCompilations	:integer = 1108;
  TXT_SelectedViewMode		:integer = 1109;
  TXT_TreeCover						:integer = 1110;

  TXT_CompilationContainer:integer = 1120;
	TXT_Artists             :integer = 1121;
	TXT_Albums              :integer = 1122;
  TXT_Year_Albums         :integer = 1123;
  TXT_Artist_albums       :integer = 1124;
	TXT_Genres              :integer = 1125;
  TXT_Drives              :integer = 1126;
	TXT_Directories         :integer = 1127;
  TXT_TrimmedDirectories	:integer = 1128;
  TXT_RecursiveFilter			:integer = 1129;
  TXT_Sets								:integer = 1130;
  TXT_ArtistsSortOrder		:integer = 1131;
  TXT_Years								:integer = 1132;
  TXT_Decades							:integer = 1133;
  TXT_DecadeIes						:integer = 1334;
  TXT_AlbumCovers					:integer = 1335;
  TXT_Ratings							:integer = 1336;

  TXT_NewCustomField			:integer = 1150;
  TXT_SpecifyCustomName		:integer = 1151;
  TXT_SelectDataType			:integer = 1152;
  TXT_Text								:integer = 1153;
  TXT_Integer							:integer = 1154;
  TXT_FloatingPointNumber	:integer = 1155;

  TXT_DeleteFileTypeQ			:integer = 1200;
  TXT_DeleteFileTypeQText	:integer = 1201;			

//TagCutter
     TXT_CutterReplace           :integer=1500;
     TXT_CutterInsertText        :integer=1501;
     TXT_CutterCut               :integer=1502;
     TXT_CutterCutLeft           :integer=1503;
     TXT_CutterCutRight          :integer=1504;
     TXT_CutterCommands          :integer=1505;
     TXT_CutterCommand           :integer=1506;
     TXT_CutterField             :integer=1507;
     TXT_CutterReplaceCmd        :integer=1508;
     TXT_CutterInsertCmd         :integer=1509;
     TXT_CutterTrimCmd           :integer=1510;
     TXT_CutterCutCmd            :integer=1511;
     TXT_CutterCutLeftCmd        :integer=1512;
     TXT_CutterCutRightCmd       :integer=1513;
     TXT_CutterInsertTextEdit    :integer=1514;
     TXT_CutterInsertBefore      :integer=1515;
     TXT_CutterAppend            :integer=1516;
		 TXT_CutterInsertAtPos       :integer=1517;
		 TXT_Trim										 :integer=1535;	

     TXT_CutterCutLabel          :integer=1518;
     TXT_CutterCharacters        :integer=1519;

     TXT_CutterFromLabel         :integer=1520;
     TXT_CutterToLabel           :integer=1521;

     TXT_CutterReplaceLabel      :integer=1522;
     TXT_CutterWithLabel         :integer=1523;

     TXT_CutterPreview           :integer=1524;
     TXT_CutterOldValue          :integer=1525;
     TXT_CutterNewValue          :integer=1526;
     TXT_CutterOptions           :integer=1527;
     TXT_UpdateTags              :integer=1528;
		 TXT_SpecifyTags             :integer=1529;

     TXT_TagCutterCaption        :integer=1531;

//Auto Scan
     TXT_AutoScanCaption         :integer=1540;
     TXT_AutoScanText            :integer=1541;
     TXT_AutoScanScanSub         :integer=1542;
     TXT_AutoScanOnceADay        :integer=1543;
     TXT_AutoScanMoveText        :integer=1544;

//Fonts & Colors
     TXT_FontColorsCaption       :integer=1550;
     TXT_FontColorsFontName      :integer=1551;
     TXT_FontColorsFontSize      :integer=1552;
     TXT_FontColorsNote          :integer=1553;
     TXT_FontColorsFontColor     :integer=1554;
     TXT_FontColorsBackgroundColor          :integer=1555;
     TXT_FontColorsSelectedTextColor        :integer=1556;
     TXT_FontColorsSelectionBarColorFoc     :integer=1557;
     TXT_FontColorsSelectionBarColorUnfoc   :integer=1558;
     TXT_FontColorsHeaderTextColor          :integer=1559;
     TXT_FontColorsSearchFieldFontColor     :integer=1560;
     TXT_FontColorsHeaderColor              :integer=1561;
//     TXT_FontColorsShuffleDisabledColor     :integer=1562;
//     TXT_FontColorsShuffleEnabledColor      :integer=1563;
     TXT_FontColorsPlayingTextColor         :integer=1564;
     TXT_FontColorsKillTextColor            :integer=1565;

     TXT_FontColorsApplyChanges             :integer=1580;



//cddbUnit
     TXT_Querying                           :integer=3000;
     TXT_FoundExact                         :integer=3001;
     TXT_FoundInexact                       :integer=3002;
     TXT_NoMatchFound                       :integer=3003;
     TXT_DatabaseEntryIsCorrupt             :integer=3004;
     TXT_ErrorConnecting                    :integer=3005;
     TXT_Ready                              :integer=3006;
     TXT_FoundMatches                       :integer=3007;
     TXT_DownloadingCDinfo                  :integer=3008;
     TXT_DatabaseEntryNotFound              :integer=3009;
     TXT_Downloaded                         :integer=3010;
     TXT_SavingFile                         :integer=3011;
     TXT_TagsSaved                          :integer=3012;
     TXT_CouldNotSaveTags                   :integer=3013;
     TXT_AutoOrderError                     :integer=3014;
     TXT_InvalidDatabaseFormat              :integer=3015;
     TXT_Unassigned                         :integer=3016;
     TXT_CouldNotSwap                       :integer=3017;
     TXT_cddbChangeUserText                 :integer=3018;
     TXT_InvalidMailAdress                  :integer=3019;

     TXT_CddbLookup                         :integer=3020;
     TXT_OriginalData                       :integer=3021;
     TXT_cddbData                           :integer=3022;
     TXT_Tag                                :integer=3023;
     TXT_cddbUseDragNDrop                   :integer=3024;
     TXT_SameArtist                         :integer=3025;
     TXT_AutoOrderTracks                    :integer=3026;
     TXT_onEveryCDLoad                      :integer=3027;
     TXT_Query                              :integer=3028;
     TXT_QueryText                          :integer=3029;
     TXT_Search                             :integer=3030;
     TXT_SearchArtistAlbumText              :integer=3031;
     TXT_AutoDownloadBestMatch              :integer=3032;
     TXT_SearchResults                      :integer=3033;
     TXT_ShowCorrectTracks                  :integer=3034;
     TXT_ExtData                            :integer=3035;
     TXT_Options                            :integer=3036;
     TXT_QueryServer                        :integer=3037;
     TXT_SearchServer                       :integer=3038;
     TXT_cddbUser                           :integer=3039;
     TXT_Advanced                           :integer=3040;
     TXT_artistTitleSep                     :integer=3041;
     TXT_reparse                            :integer=3042;
     TXT_Save_Options                       :integer=3043;

//Tag editor
		TXT_InvalidFormat												:integer=4000;

implementation
uses MainForm, defs;
var      languageList:Tlist;

Function GetText(lanConst:integer; const params:array of string):String;
var      i:integer;
begin
  result := GetText(lanConst);
  for i:=0 to length(params)-1 do
  	result :=Q_ReplaceStr(result, '%' + inttostr(i+1), params[i])
end;

function CompareLanguageRec(Item1, Item2: Pointer): integer;
begin
	result := PLanguageRec(Item1).ID - PLanguageRec(Item2).ID
end;

Function GetText(lanConst:integer):String;
function FindLanguageRec: PLanguageRec;	//finder i sorteret liste
var
  L, H, I, C: Integer;
begin
  L := 0;
	H := LanguageList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Planguagerec(LanguageList.List^[i]).ID - lanConst;
    if C < 0 then
    	L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := LanguageList.List^[i];
        exit
      end
    end;
  end;
  Result := nil
end;
var
	rec: PLanguageRec;
begin
	try
    rec := FindLanguageRec;
    if assigned(rec) then
    	result := Q_ReplaceStr(rec.s, '#13', CRLF)
    else
    	result := ''
  except
  	result := ''
  end
end;

Procedure LoadLanguage(filename:string);
var       f:textfile;
          s, snr:string;
          LR:Planguagerec;
begin
  if not fileexists(filename + '.lan') then
  begin
    languageList := Tlist.create; //for at undgå fejl
    MainFormInstance.showmessagex('Could not load menu language file:' + #13 + filename + '.lan');
    exit
  end;
  try
    unloadLanguage;
    languageList := Tlist.create;
    fileMode := 0;
    assignFile(f, filename + '.lan');
    reset(f);
    readLn(f, s);
    if Q_SameTextL(Lan_FileIdent, s, length(Lan_FileIdent)) then
    while not eof(f) do
    begin
      readln(f, s);
      Q_TrimInPlace(s);
      if (length(s)>3) and not Q_SameStr(s[1]+s[2], '//') then
      begin
        snr := Q_CopyRange(s, 1, Q_StrScan(s, '=')-1);
        s := Q_CopyRange(s, Q_StrScan(s, '"')+1, Q_StrRScan(S, '"')-1);
        if (length(s)>0) and Q_IsInteger(snr) then
        begin
          new(LR);
          LR.ID := strToInt(snr);
          LR.s := s;
          languageList.Add(LR)
        end
      end
    end else
     MainFormInstance.showmessagex('Invalid language file version:' + #13 + filename + '.lan') //skal ikke oversættes
  except
  	MainFormInstance.showmessagex('Error loading language!') // skal ikke oversættes
  end;
  try
  	languageList.Sort(CompareLanguageRec);
    closeFile(f)
  except
  end
end;


Procedure LoadMenuLanguage(filename:string);
Function  findMenu(s:String):TPopupMenu;
var       i, tag:integer;
begin
  result := nil;
  Q_TrimInPlace(s);
  if Q_IsInteger(s) then
  begin
    tag := strtoInt(s);
    for i:=0 to MainFormInstance.componentcount-1 do
      if (MainFormInstance.components[i] is TPopupmenu) and (TPopupmenu(MainFormInstance.components[i]).tag = tag) then
      begin
      	result := TPopupmenu(MainFormInstance.components[i]);
       	break
      end
  end
end;
Function assignTextMenu(mu:TMenuItem; tag:integer; s:string):boolean;
var      i:integer;
begin
     result := false;
     if abs(mu.tag) = tag then
     begin
          mu.Caption := s;
          result := true
     end else
     for i:=0 to mu.Count-1 do
         if assignTextMenu(mu.Items[i], tag, s) then
         begin
              result := true;
              break
         end
end;
var       f:textfile;
          i:integer;
          s, snr:string;
          currentMenu:TPopUpMenu;
begin
     if not fileexists(filename + '.mnu') then
     begin
          MainFormInstance.showmessagex('Could not load language file:' + #13 + filename + '.mnu');
          exit
     end;
     try
     currentMenu := nil;
     fileMode := 0;
     assignFile(f, filename + '.mnu');
     reset(f);
     readLn(f, s);
     if Q_SameTextL(Lan_MenuFileIdent, s, length(Lan_MenuFileIdent)) then
     while not eof(f) do
     begin
          readln(f, s);
          if (length(s)>3) and not Q_SameStr(s[1]+s[2], '//') then
          begin
               if Q_PosText(MENUBEGIN, s)>0 then
               begin
                    currentMenu := findMenu(Q_CopyFrom(s, Q_PosText(MENUBEGIN, s) + length(MENUBEGIN)));
                    if currentMenu = nil then
                    begin
                         closeFile(f);
                         MainFormInstance.showmessagex('Invalid language file!'); //skal ikke oversættes
                         exit
                    end else continue
               end;
               if (length(s)>0) and (s[1]<>'!') and assigned(currentMenu) then
               begin
                    snr := Q_CopyRange(s, 1, Q_StrScan(s, '=')-1);
                    s := Q_CopyRange(s, Q_StrScan(s, '"')+1, Q_StrRScan(S, '"')-1);
                    if (length(s)>0) and Q_IsInteger(snr) then
                       for i:=0 to currentMenu.items.count-1 do
                           if assignTextMenu(currentMenu.items[i], strtoInt(snr), s) then
                              break
               end
          end
     end else
         MainFormInstance.showmessagex('Invalid language file version:' + #13 + filename + '.mnu')
     except
           MainFormInstance.showmessagex('Error loading language!') // skal ikke oversættes
     end;
     try
     closeFile(f)
     except end
end;

Procedure unloadLanguage;
var       i:integer;
begin
  if assigned(languageList) then
  begin
    for i:=0 to languageList.count-1 do
    	dispose(PlanguageRec(languageList.List^[i]));
    languageList.free;
    languageList := nil
  end
end;


end.

