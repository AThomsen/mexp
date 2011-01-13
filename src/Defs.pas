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


unit Defs;

interface

uses
        Windows, SysUtils, messages, controls, Graphics,
        forms, classes, ShellApi, MEXPtypes,
				MainForm,
				prefernces {in 'prefernces.pas' pref},
//				onoffconfig {in 'onoffconfig.pas' onoff},
				DubWiz,
				QStrings, QStringList, QCSStringList,
				addgroupU,
				TagEditor,
        delfiles,filectrl,
        groupsunit,
        dbprefe, inuptbox2U, Winsock,
				jvChangeNotify, snap, MexpIniFile,
				LanguageConstants, syncObjs, RecHashTable, wampmsg;

//        type TGetHTTPProc = function (HWND:hwnd; url:Pchar; filename:Pchar; dlgtitle:pchar): Integer stdcall;	//works from Winamp 2.05

        procedure AddAppStartDate(date: TDateTime);

        procedure DisplaySystrayIcon(initiallyToggled: boolean);

        function SameRect(const r1, r2: TRect): Boolean;
        function PointInRect(const pt:Tpoint; const rt:Trect):boolean;
        function RandomFilename(pathName, extension: String; returnWithPath: boolean): String;
				function FileDeleteRB(const FileName:string): boolean; //sletter filen vha. recycle bin
        function DrivePresent(drive:char):boolean;
				function GetTextWidth(const s:String; f:Tfont):integer;
        Function GetOneOrZero(const c1:integer):integer;
				Function CompInt64(const c1, c2:Int64):integer;
				Function CompCardinal(const c1, c2:cardinal):integer;
        Function CompInteger(const c1, c2:integer):integer;
        Function CompSmallInt(const c1, c2:smallInt):integer;
        Function CompByte(const c1, c2:byte):integer;
        Function CompShortInt(const c1, c2:ShortInt):integer;
        Function CompWord(const c1, c2:word):integer;
        Function CompSingle(const c1, c2:Single):integer;
        Function connectedToInternet: boolean;
        Function TimeToInt(const Time:TTime):cardinal;
        Function IntToTime(const Time:int64):TTime;
				Procedure DecTime(const Time: int64; var h, m, s, ms: Word; Const NoMsec:Boolean=false);
				Function IntTimeToStr(const time:int64; TwoMinDigits, AlwaysShowHour:Boolean):String;
				Function IntTimeToSec(const Time:int64):int64;
        Function IsInteger(const s:String): boolean;

//				Function SecToString(sec: Integer): String;
        Function NearestDiv(Number:Integer; By:Integer) :Integer;
        Procedure ChangeCursor(i:integer);
        Function GetFileAccess(const FileName : String; Read, Write:Boolean; TryUnsetReadOnlyAttribute:Boolean=false; TestShareExclusive:boolean=false):Boolean;
        Function OpenReadWriteFileStream(const FileName : String; out filemode: Integer):TFileStream;
        Function TheFix(const s:String):String;
        procedure SetFilename(rec: PRec; const newFilename:String; updateHashedReclist: boolean);
        procedure AddToTList(target:Tlist; source:Tlist);
//				function GetFileTimes(const FileName: string; var Created: TDateTime; var Accessed: TDateTime; var Modified: TDateTime): Boolean;
//        function GetFileAge(const Filename:String):TDateTime;
				function GetFileSize(const s:String):cardinal;
				function MoveFileX(const source: String; const destination: String; Overwrite: Boolean): Boolean;
//        function GetHTML(hwnd: hwnd; const url: String; const dlgTitle: String; out s: String): Boolean;

        function invertDate(date: TDateTime):TDateTime;

        function GetRelativePath(const BaseName, DestName: string): string;
        procedure GetAbsoluteFilename(BasePath: String; var filename: String);

				function GetFuzzyText(const s:string):string;

				Function RemoveBrackets(const S:String): String;

        procedure BeginSetArtistAlbumFilename;
        procedure EndSetArtistAlbumFilename;

				procedure BeginUseReclist;
        procedure EndUseReclist;

        procedure BeginUseId3v2;
        procedure EndUseId3v2;

        function GetLanguageCodeFromLanguageName(const languageName: string): String;
        function GetLanguageNameFromLanguageCode(const languageCode: string): String;
        function IndexOfLanguageCode(const languageCode: string): integer;
        Procedure FillLanguagesToTStrings(strLst: TStrings);

        Procedure InitSnap;

				Function Init: Integer; cdecl;
				Procedure Config; cdecl;
				Procedure Quit; cdecl;
//        function HookCallWndProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT stdcall;
//        function MouseHookCallWndProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT stdcall;
//				function PLWndProc(hWnd:HWND; Mess:cardinal; wparam: WPARAM; lparam: LPARAM):LRESULT stdcall;
				function WINAMPWndProc(hWnd:HWND; Mess:cardinal; wparam: WPARAM; lparam: LPARAM):LRESULT stdcall;

type
	PWinampGeneralPurposePlugin = ^TWinampGeneralPurposePlugin;
	TWinampGeneralPurposePlugin = Record
		version: Integer;
		description: PChar;
		init: Function: Integer; cdecl;
		config: Procedure; cdecl;
		quit: Procedure; cdecl;
		hwndParent: HWND;
		hDllInstance: HINST;
	end;

const
	AppName: String = 'MEXP';//Music Explorer / Music Explorer Plugin
	ver : string = '0.1.0';

	DB_FileVer : cardinal = 9;
  //8: Beta 9 rev. 2
  //9: Beta 9 rev. 2

	DBS_FileVer : cardinal = 11;
	DBPL_FileVer : cardinal = 2;
	TREE_FileVer : cardinal = 13;
	WPL_FileVer : cardinal = 4;
  COVERCACHE_FileVer : cardinal = 3;
  
	SupportedSkin_FileVer : array[1..5] of word = (1, 2, 3, 4, 5);

	FileRecIdent: smallint = 22866;

  PREDEFINED_AUDIOTYPESCOUNT = 6;
  PREDEFINED_SEARCHINFIELDCOUNT = 7;

	SkinFileIdent: Integer = -945321365;

	UseDefaultDummyFile: String = 'usedDefault.dum';
	DummyFileContents: String = 'Don''t delete!';

	Lan_FileIdent:         string = '!LanguageFileVersion1';
	Lan_MenuFileIdent:     string = '!MenuLanguageFileVersion1';

	CRLF: string = #13#10;
  BRAINFILENAME: String = 'brain://play';

	VerFileURL : String = 'http://www.mexp.dk/mexpver.txt';

  ExcludeFromDBFilename: String = 'ExludedFiles.txt';

	filesInWP:integer = 3; //antal filer der maks skal være i playlisten hvis mexp skal styre det - skal pr. 3/2003 være = 3	!!!

	invalidFileChars : string = '\/:*?"<>|';

	ColumnsToAutoResize: array [1..20] of integer = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20);
	ColumnsToAutoResizeCount = 20;

  StarNrFactor: double = 5/255;

	TWM_countUp = 0;
	TWM_countDown = 1;
	TWM_Both = 2;

	WinampGeneralPurposePlugin: TWinampGeneralPurposePlugin =
	(
		version: $10;
		description: 'MEXP';
		init: Init;
		config: Config;
		quit: Quit;
		hwndParent: 0;
		hDllInstance: 0;
	);

        htmlHeader : String = '<html>' + #13#10 + '<head>' + #13#10 + '<title>List from MEXP</title>' + #13#10 + '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-2">' + #13#10 + '</head>';
				htmlFooter : String = #13#10 + '</html>';

        autoScanFilename: String = '\Auto scan filemove undo.undo';
        undoFileIdent: String = 'MEXPUNDOFILEV1'; 

				master_MyMusic = 0;
        master_addloc  = 1;
        master_dbPref  = 2;
				master_DirSpy = 4;
				master_ScanForChanges = 5;

        kill_none = 0;
        kill_del = 1;  //delete after play
				kill_conPlay = 2; //continous play, delete after play and insert new node

        FileReadable  = 0;
        FileWriteable = 1;

          FFILENAME=0;
          FARTIST=1;
          FTITLE=2;
          FALBUM=3;
          FGENRE=4;
          FYEAR=5;
          FCOMMENT=6;
          FTRACK=7;
          FKBPS=8;
          FLENGTH=9;
          FLOCATION=10;
          FLASTCHANGED=11;
          FCHANNELS=12;
          FPLAYCOUNT=13;
          FCOMPILATION=14;
          FGROUPS=15;
          FCRC=16;
          FFSIZE=17;
          FKHZ=18;

					FFILEPATH=19;
					FFNAME=20;
          FArtistSortOrder=23;

          FAudioType=25;
          FTags=26;
          FLyrics=27;
          FAutoScanned=28;

          FDATABASETIME = 30;
          FLASTWRITEDATE = 31;

          FTotalTracks = 32;
          FTrackInfo = 33;

          FPartOfSet = 34;
          FTotalParts = 35;
          FPartOfSetText = 36;
          FRating = 37;

          Fextstr=50;           //til .m3u files
          Fscanpath=55;         //The path specified in eather prefrences or dbpref
          fArtistTitle=56;       // Artist - Title
					fQuality=60;
          FWinplayPos=61;
          FWinplayEnqueue=62;

					FAddGenre= 70;
					FRemoveGenre = 71;
					FAddGroup = 72;
					FRemoveGroup = 73;

          FCustomField = 1000;

          //Rec - FLAGS
{          RF_Playing : TRecFlag = $1;
          RF_Compilation: TRecFlag = $2;
          RF_HasId3v1: TRecFlag = $4;
          RF_HasId3v2: TRecFlag = $8;
          RF_HasApeTag: TRecFlag = $10;
          RF_HasWmaTag: TRecFlag = $20;
          RF_HasOggTag: TRecFlag = $40;
          RF_HasLyrics: TRecFlag = $80;
          RF_EqualId3: TRecFlag = $100;
          RF_AutoScanned: TRecFlag = $200;
          RF_DeletePending: TRecFlag = $400; }
          //max is $10000
          //end of FLAGS

          media_harddisk=0;
					media_cdrom=1;
          media_removable=2;
          media_network=3;

          MPEG_CM_STEREO = 0;                                                { Stereo }
					MPEG_CM_JOINT_STEREO = 1;                                    { Joint Stereo }
          MPEG_CM_DUAL_CHANNEL = 2;                                    { Dual Channel }
          MPEG_CM_MONO = 3;                                                    { Mono }
          MPEG_CM_UNKNOWN = 4;                                         { Unknown mode }

//          Channelsarray:array [0 .. 4] of string = ('Stereo', 'Joint Stereo', 'Dual', 'Mono', 'Unknown');
          MPEG_VERSION: array [0..3] of string = ('MPEG 2.5', 'MPEG ?', 'MPEG 2', 'MPEG 1');

				MaxSavedChars = 512;

        MAXGENRES = 147;
        NoGenre = 255;
        GENRES: array [-1..MAXGENRES] of String = ('',
        'Blues','Classic Rock','Country','Dance','Disco','Funk','Grunge','Hip-Hop','Jazz','Metal','New Age','Oldies',
				'Other','Pop','R&B','Rap','Reggae','Rock','Techno','Industrial','Alternative','Ska','Death Metal','Pranks',
        'Soundtrack','Euro-Techno','Ambient','Trip-Hop','Vocal','Jazz+Funk','Fusion','Trance','Classical','Instrumental',
        'Acid','House','Game','Sound Clip','Gospel','Noise','Alt. Rock','Bass','Soul','Punk','Space','Meditative',
        'Instrumental Pop','Instrumental Rock','Ethnic','Gothic','Darkwave','Techno-Industrial','Electronic','Pop-Folk',
        'Eurodance','Dream','Southern Rock','Comedy','Cult','Gangsta','Top 40','Christian Rap','Pop/Funk','Jungle',
        'Native American','Cabaret','New Wave','Psychedelic','Rave','Showtunes','Trailer','Lo-Fi','Tribal','Acid Punk',
        'Acid Jazz','Polka','Retro','Musical','Rock & Roll','Hard Rock','Folk','Folk/Rock','National Folk','Swing','Fast Fusion','Bebob',
				'Latin','Revival','Celtic','Bluegrass','Avantgarde','Gothic Rock','Progressive Rock','Psychedelic Rock','Symphonic Rock',
        'Slow Rock','Big Band','Chorus','Easy Listening','Acoustic','Humour','Speech','Chanson','Opera','Chamber Music','Sonata',
        'Symphony','Booty Bass','Primus','Porn Groove','Satire','Slow Jam','Club','Tango','Samba','Folklore',
        'Ballad','Power Ballad','Rhythmic Soul','Freestyle','Duet','Punk Rock','Drum Solo','A Cappella','Euro-House','Dance Hall',
        'Goa','Drum & Bass','Club-House','Hardcore','Terror','Indie','BritPop','Negerpunk',
				'Polsk Punk','Beat','Christian Gangsta Rap','Heavy Metal','Black Metal','Crossover','Contemporary Christian','Christian Rock',
        'Merengue','Salsa','Trash Metal','Anime','Jpop','Synthpop');

{        LanguageCodes: array [0..401] of String = (
        'abk', 'ace', 'ach', 'ada', 'aar', 'afh', 'afr', 'afa', 'aka', 'akk', 'alb/sqi', 'ale', 'alg', 'tut', 'amh'
        , 'apa', 'ara', 'arc', 'arp', 'arn', 'arw', 'arm/hye', 'art', 'asm', 'ath', 'map', 'ava', 'ave', 'awa', 'aym'
        , 'aze', 'nah', 'ban', 'bat', 'bal', 'bam', 'bai', 'bad', 'bnt', 'bas', 'bak', 'baq/eus', 'bej', 'bem', 'ben'
        , 'ber', 'bho', 'bih', 'bik', 'bin', 'bis', 'bra', 'bre', 'bug', 'bul', 'bua', 'bur/mya', 'bel', 'cad', 'car'
        , 'cat', 'cau', 'ceb', 'cel', 'cai', 'chg', 'cha', 'che', 'chr', 'chy', 'chb', 'chi/zho', 'chn', 'cho', 'chu'
        , 'chv', 'cop', 'cor', 'cos', 'cre', 'mus', 'crp', 'cpe', 'cpf', 'cpp', 'cus', 'ces/cze', 'dak', 'dan', 'del'
        , 'din', 'div', 'doi', 'dra', 'dua', 'dut/nla', 'dum', 'dyu', 'dzo', 'efi', 'egy', 'eka', 'elx', 'eng', 'enm'
				, 'ang', 'esk', 'epo', 'est', 'ewe', 'ewo', 'fan', 'fat', 'fao', 'fij', 'fin', 'fiu', 'fon', 'fra/fre', 'frm'
        , 'fro', 'fry', 'ful', 'gaa', 'gae/gdh', 'glg', 'lug', 'gay', 'gez', 'geo/kat', 'deu/ger', 'gmh', 'goh', 'gem', 'gil'
        , 'gon', 'got', 'grb', 'grc', 'ell/gre', 'kal', 'grn', 'guj', 'hai', 'hau', 'haw', 'heb', 'her', 'hil', 'him'
        , 'hin', 'hmo', 'hun', 'hup', 'iba', 'ice/isl', 'ibo', 'ijo', 'ilo', 'inc', 'ine', 'ind', 'ina', 'ine', 'iku'
				, 'ipk', 'ira', 'gai/iri', 'sga', 'mga', 'iro', 'ita', 'jpn', 'jav/jaw', 'jrb', 'jpr', 'kab', 'kac', 'kam', 'kan'
        , 'kau', 'kaa', 'kar', 'kas', 'kaw', 'kaz', 'kha', 'khm', 'khi', 'kho', 'kik', 'kin', 'kir', 'kom', 'kon'
        , 'kok', 'kor', 'kpe', 'kro', 'kua', 'kum', 'kur', 'kru', 'kus', 'kut', 'lad', 'lah', 'lam', 'oci', 'lao'
        , 'lat', 'lav', 'ltz', 'lez', 'lin', 'lit', 'loz', 'lub', 'lui', 'lun', 'luo', 'mac/mak', 'mad', 'mag', 'mai'
        , 'mak', 'mlg', 'may/msa', 'mal', 'mlt', 'man', 'mni', 'mno', 'max', 'mao/mri', 'mar', 'chm', 'mah', 'mwr', 'mas'
				, 'myn', 'men', 'mic', 'min', 'mis', 'moh', 'mol', 'mkh', 'lol', 'mon', 'mos', 'mul', 'mun', 'nau', 'nav'
        , 'nde', 'nbl', 'ndo', 'nep', 'new', 'nic', 'ssa', 'niu', 'non', 'nai', 'nor', 'nno', 'nub', 'nym', 'nya'
        , 'nyn', 'nyo', 'nzi', 'oji', 'ori', 'orm', 'osa', 'oss', 'oto', 'pal', 'pau', 'pli', 'pam', 'pag', 'pan'
        , 'pap', 'paa', 'fas/per', 'peo', 'phn', 'pol', 'pon', 'por', 'pra', 'pro', 'pus', 'que', 'roh', 'raj', 'rar'
        , 'roa', 'ron/rum', 'rom', 'run', 'rus', 'sal', 'sam', 'smi', 'smo', 'sad', 'sag', 'san', 'srd', 'sco', 'sel'
        , 'sem', 'scr', 'srr', 'shn', 'sna', 'sid', 'bla', 'snd', 'sin', 'sit', 'sio', 'sla', 'ssw', 'slk/slo', 'slv'
        , 'sog', 'som', 'son', 'wen', 'nso', 'sot', 'sai', 'esl/spa', 'suk', 'sux', 'sun', 'sus', 'swa', 'ssw', 'sve/swe'
        , 'syr', 'tgl', 'tah', 'tgk', 'tmh', 'tam', 'tat', 'tel', 'ter', 'tha', 'bod/tib', 'tig', 'tir', 'tem', 'tiv'
        , 'tli', 'tog', 'ton', 'tru', 'tsi', 'tso', 'tsn', 'tum', 'tur', 'ota', 'tuk', 'tyv', 'twi', 'uga', 'uig'
        , 'ukr', 'umb', 'und', 'urd', 'uzb', 'vai', 'ven', 'vie', 'vol', 'vot', 'wak', 'wal', 'war', 'was', 'cym/wel'
        , 'wol', 'xho', 'sah', 'yao', 'yap', 'yid', 'yor', 'zap', 'zen', 'zha', 'zul', 'zun'); }

        UnknownLanguageCode: string = 'XXX';	//used with Id3v2;

        LanguageCodes: array [0..514] of string = (      //TODO: - check where this is used
        'abk', 'ace', 'ach', 'ada', 'ady', 'ady', 'aar', 'afh', 'afr', 'afa', 'aka', 'akk', 'alb/sqi', 'ale', 'alg', 'tut', 'amh', 'apa', 'ara', 'arg', 'arc', 'arp', 'arn', 'arw', 'arm/hye', 'art', 'asm', 'ast', 'ath', 'aus', 'map',
				'ava', 'ave', 'awa', 'aym', 'aze', 'ast', 'ban', 'bat', 'bal', 'bam', 'bai', 'bad', 'bnt', 'bas', 'bak', 'baq/eus', 'btk', 'bej', 'bel', 'bem', 'ben', 'ber', 'bho', 'bih', 'bik', 'byn', 'bin', 'bis', 'byn',
				'nob', 'bos', 'bra', 'bre', 'bug', 'bul', 'bua', 'bur/mya', 'cad', 'car', 'spa', 'cat', 'cau', 'ceb', 'cel', 'cai', 'chg', 'cmc', 'cha', 'che', 'chr', 'nya', 'chy', 'chb', 'nya', 'chi/zho', 'chn', 'chp', 'cho',
				'zha', 'chu', 'chu', 'chk', 'chv', 'nwc', 'nwc', 'cop', 'cor', 'cos', 'cre', 'mus', 'crp', 'cpe', 'cpf', 'cpp', 'crh', 'crh', 'scr/hrv', 'cus', 'cze/ces', 'dak', 'dan', 'dar', 'day', 'del', 'din', 'div', 'doi',
				'dgr', 'dra', 'dua', 'dut/nld', 'dum', 'dyu', 'dzo', 'efi', 'egy', 'eka', 'elx', 'eng', 'enm', 'ang', 'myv', 'epo', 'est', 'ewe', 'ewo', 'fan', 'fat', 'fao', 'fij', 'fil', 'fin', 'fiu', 'fon', 'fre/fra',
				'frm', 'fro', 'fry', 'fur', 'ful', 'gaa', 'gla', 'glg', 'lug', 'gay', 'gba', 'gez', 'geo/kat', 'ger/deu', 'nds', 'gmh', 'goh', 'gem', 'kik', 'gil', 'gon', 'gor', 'got', 'grb', 'grc', 'gre/ell', 'grn', 'guj', 'gwi',
				'hai', 'hat', 'hat', 'hau', 'haw', 'heb', 'her', 'hil', 'him', 'hin', 'hmo', 'hit', 'hmn', 'hun', 'hup', 'iba', 'ice/isl', 'ido', 'ibo', 'ijo', 'ilo', 'smn', 'inc', 'ine', 'ind', 'inh', 'ina', 'ile',
				'iku', 'ipk', 'ira', 'gle', 'mga', 'sga', 'iro', 'ita', 'jpn', 'jav', 'jrb', 'jpr', 'kbd', 'kab', 'kac', 'kal', 'xal', 'kam', 'kan', 'kau', 'krc', 'kaa', 'kar', 'kas', 'csb', 'kaw', 'kaz', 'kha',
				'khm', 'khi', 'kho', 'kik', 'kmb', 'kin', 'kir', 'tlh', 'kom', 'kon', 'kok', 'kor', 'kos', 'kpe', 'kro', 'kua', 'kum', 'kur', 'kru', 'kut', 'kua', 'lad', 'lah', 'lam', 'lao', 'lat', 'lav', 'ltz', 'lez',
				'lim', 'lim', 'lim', 'lin', 'lit', 'jbo', 'nds', 'nds', 'dsb', 'loz', 'lub', 'lua', 'lui', 'smj', 'lun', 'luo', 'ltz', 'lus', 'mac/mkd', 'mad', 'mag', 'mai', 'mak', 'mlg', 'may/msa', 'mal', 'mlt', 'mnc', 'mdr',
				'man', 'mni', 'mno', 'glv', 'mao/mri', 'mar', 'chm', 'mah', 'mwr', 'mas', 'myn', 'men', 'mic', 'mic', 'min', 'mwl', 'mis', 'moh', 'mdf', 'mol', 'mkh', 'lol', 'mon', 'mos', 'mul', 'mun', 'nah', 'nau', 'nav',
				'nav', 'nde', 'nbl', 'ndo', 'nap', 'new', 'nep', 'new', 'nia', 'nic', 'ssa', 'niu', 'nog', 'non', 'nai', 'sme', 'nso', 'nde', 'nor', 'nob', 'nno', 'nub', 'nym', 'nya', 'nyn', 'nno', 'nyo', 'nzi', 'oci',
				'oji', 'chu', 'chu', 'nwc', 'chu', 'ori', 'orm', 'osa', 'oss', 'oss', 'oto', 'pal', 'pau', 'pli', 'pam', 'pag', 'pan', 'pap', 'paa', 'nso', 'per/fas', 'peo', 'phi', 'phn', 'fil', 'pon', 'pol', 'por', 'pra',
				'oci', 'pro', 'pan', 'pus', 'que', 'roh', 'raj', 'rap', 'rar', 'qaa-qtz', 'roa', 'rum/ron', 'rom', 'run', 'rus', 'sal', 'sam', 'smi', 'smo', 'sad', 'sag', 'san', 'sat', 'srd', 'sas', 'nds', 'sco',
				'gla', 'sel', 'sem', 'nso', 'scc/srp', 'srr', 'shn', 'sna', 'iii', 'scn', 'sid', 'sgn', 'bla', 'snd', 'sin', 'sin', 'sit', 'sio', 'sms', 'den', 'sla', 'slo/slk', 'slv', 'sog', 'som', 'son', 'snk', 'wen', 'nso', 'sot',
				'sai', 'alt', 'sma', 'nbl', 'spa', 'suk', 'sux', 'sun', 'sus', 'swa', 'ssw', 'swe', 'syr', 'tgl', 'tah', 'tai', 'tgk', 'tmh', 'tam', 'tat', 'tel', 'ter', 'tet', 'tha', 'tib/bod', 'tig', 'tir', 'tem', 'tiv',
				'tlh', 'tli', 'tpi', 'tkl', 'tog', 'ton', 'tsi', 'tso', 'tsn', 'tum', 'tup', 'tur', 'ota', 'tuk', 'tvl', 'tyv', 'twi', 'udm', 'uga', 'uig', 'ukr', 'umb', 'und', 'hsb', 'urd', 'uig', 'uzb', 'vai',
				'cat', 'ven', 'vie', 'vol', 'vot', 'wak', 'wal', 'wln', 'war', 'was', 'wel/cym', 'wol', 'xho', 'sah', 'yao', 'yap', 'yid', 'yor', 'ypk', 'znd', 'zap', 'zen', 'zha', 'zul', 'zun');

        LanguageNames: array [0..514] of string = (
        'Abkhazian', 'Achinese', 'Acoli', 'Adangme', 'Adygei', 'Adyghe', 'Afar', 'Afrihili', 'Afrikaans', 'Afro-Asiatic (Other)', 'Akan', 'Akkadian', 'Albanian', 'Aleut', 'Algonquian languages', 'Altaic (Other)', 'Amharic', 'Apache languages', 'Arabic', 'Aragonese', 'Aramaic', 'Arapaho', 'Araucanian', 'Arawak', 'Armenian', 'Artificial (Other)', 'Assamese', 'Asturian', 'Athapascan languages', 'Australian languages', 'Austronesian (Other)',
				'Avaric', 'Avestan', 'Awadhi', 'Aymara', 'Azerbaijani', 'Bable', 'Balinese', 'Baltic (Other)', 'Baluchi', 'Bambara', 'Bamileke languages', 'Banda', 'Bantu (Other)', 'Basa', 'Bashkir', 'Basque', 'Batak (Indonesia)', 'Beja', 'Belarusian', 'Bemba', 'Bengali', 'Berber (Other)', 'Bhojpuri', 'Bihari', 'Bikol', 'Bilin', 'Bini', 'Bislama', 'Blin',
				'Bokmål, Norwegian', 'Bosnian', 'Braj', 'Breton', 'Buginese', 'Bulgarian', 'Buriat', 'Burmese', 'Caddo', 'Carib', 'Castilian', 'Catalan', 'Caucasian (Other)', 'Cebuano', 'Celtic (Other)', 'Central American Indian (Other)', 'Chagatai', 'Chamic languages', 'Chamorro', 'Chechen', 'Cherokee', 'Chewa', 'Cheyenne', 'Chibcha', 'Chichewa', 'Chinese', 'Chinook jargon', 'Chipewyan', 'Choctaw',
				'Chuang', 'Church Slavic', 'Church Slavonic', 'Chuukese', 'Chuvash', 'Classical Nepal Bhasa', 'Classical Newari', 'Coptic', 'Cornish', 'Corsican', 'Cree', 'Creek', 'Creoles and pidgins(Other)', 'Creoles and pidgins, English-based (Other)', 'Creoles and pidgins, French-based (Other)', 'Creoles and pidgins, Portuguese-based (Other)', 'Crimean Tatar', 'Crimean Turkish', 'Croatian', 'Cushitic (Other)', 'Czech', 'Dakota', 'Danish', 'Dargwa', 'Dayak', 'Delaware', 'Dinka', 'Divehi', 'Dogri',
				'Dogrib', 'Dravidian (Other)', 'Duala', 'Dutch', 'Dutch, Middle (ca. 1050-1350)', 'Dyula', 'Dzongkha', 'Efik', 'Egyptian (Ancient)', 'Ekajuk', 'Elamite', 'English', 'English, Middle (1100-1500)', 'English, Old (ca.450-1100)', 'Erzya', 'Esperanto', 'Estonian', 'Ewe', 'Ewondo', 'Fang', 'Fanti', 'Faroese', 'Fijian', 'Filipino', 'Finnish', 'Finno-Ugrian (Other)', 'Fon', 'French',
				'French, Middle (ca.1400-1600)', 'French, Old (842-ca.1400)', 'Frisian', 'Friulian', 'Fulah', 'Ga', 'Gaelic', 'Gallegan', 'Ganda', 'Gayo', 'Gbaya', 'Geez', 'Georgian', 'German', 'German, Low', 'German, Middle High (ca.1050-1500)', 'German, Old High (ca.750-1050)', 'Germanic (Other)', 'Gikuyu', 'Gilbertese', 'Gondi', 'Gorontalo', 'Gothic', 'Grebo', 'Greek, Ancient (to 1453)', 'Greek, Modern (1453-)', 'Guarani', 'Gujarati', 'Gwich´in',
				'Haida', 'Haitian', 'Haitian Creole', 'Hausa', 'Hawaiian', 'Hebrew', 'Herero', 'Hiligaynon', 'Himachali', 'Hindi', 'Hiri Motu', 'Hittite', 'Hmong', 'Hungarian', 'Hupa', 'Iban', 'Icelandic', 'Ido', 'Igbo', 'Ijo', 'Iloko', 'Inari Sami', 'Indic (Other)', 'Indo-European (Other)', 'Indonesian', 'Ingush', 'Interlingua (International Auxiliary Language Association)', 'Interlingue',
				'Inuktitut', 'Inupiaq', 'Iranian (Other)', 'Irish', 'Irish, Middle (900-1200)', 'Irish, Old (to 900)', 'Iroquoian languages', 'Italian', 'Japanese', 'Javanese', 'Judeo-Arabic', 'Judeo-Persian', 'Kabardian', 'Kabyle', 'Kachin', 'Kalaallisut', 'Kalmyk', 'Kamba', 'Kannada', 'Kanuri', 'Karachay-Balkar', 'Kara-Kalpak', 'Karen', 'Kashmiri', 'Kashubian', 'Kawi', 'Kazakh', 'Khasi',
				'Khmer', 'Khoisan (Other)', 'Khotanese', 'Kikuyu', 'Kimbundu', 'Kinyarwanda', 'Kirghiz', 'Klingon', 'Komi', 'Kongo', 'Konkani', 'Korean', 'Kosraean', 'Kpelle', 'Kru', 'Kuanyama', 'Kumyk', 'Kurdish', 'Kurukh', 'Kutenai', 'Kwanyama', 'Ladino', 'Lahnda', 'Lamba', 'Lao', 'Latin', 'Latvian', 'Letzeburgesch', 'Lezghian',
				'Limburgan', 'Limburger', 'limburgish', 'Lingala', 'Lithuanian', 'Lojban', 'Low German', 'Low Saxon', 'Lower Sorbian', 'Lozi', 'Luba-Katanga', 'Luba-Lulua', 'Luiseno', 'Lule Sami', 'Lunda', 'Luo (Kenya and Tanzania)', 'Luxembourgish', 'Lushai', 'Macedonian', 'Madurese', 'Magahi', 'Maithili', 'Makasar', 'Malagasy', 'Malay', 'Malayalam', 'Maltese', 'Manchu', 'Mandar',
				'Mandingo', 'Manipuri', 'Manobo languages', 'Manx', 'Maori', 'Marathi', 'Mari', 'Marshallese', 'Marwari', 'Masai', 'Mayan languages', 'Mende', 'Micmac', 'Mi''kmaq', 'Minangkabau', 'Mirandese', 'Miscellaneous languages', 'Mohawk', 'Moksha', 'Moldavian', 'Mon-Khmer (Other)', 'Mongo', 'Mongolian', 'Mossi', 'Multiple languages', 'Munda languages', 'Nahuatl', 'Nauru', 'Navaho',
				'Navajo', 'Ndebele, North', 'Ndebele, South', 'Ndonga', 'Neapolitan', 'Nepal Bhasa', 'Nepali', 'Newari', 'Nias', 'Niger-Kordofanian (Other)', 'Nilo-Saharan (Other)', 'Niuean', 'Nogai', 'Norse, Old', 'North American Indian (Other)', 'Northern Sami', 'Northern Sotho', 'North Ndebele', 'Norwegian', 'Norwegian Bokmål', 'Norwegian Nynorsk', 'Nubian languages', 'Nyamwezi', 'Nyanja', 'Nyankole', 'Nynorsk, Norwegian', 'Nyoro', 'Nzima', 'Occitan (post 1500)',
				'Ojibwa', 'Old Bulgarian', 'Old Church Slavonic', 'Old Newari', 'Old Slavonic', 'Oriya', 'Oromo', 'Osage', 'Ossetian', 'Ossetic', 'Otomian languages', 'Pahlavi', 'Palauan', 'Pali', 'Pampanga', 'Pangasinan', 'Panjabi', 'Papiamento', 'Papuan (Other)', 'Pedi', 'Persian', 'Persian, Old (ca.600-400)', 'Philippine (Other)', 'Phoenician', 'Pilipino', 'Pohnpeian', 'Polish', 'Portuguese', 'Prakrit languages',
				'Provençal', 'Provençal, Old (to 1500)', 'Punjabi', 'Pushto', 'Quechua', 'Raeto-Romance', 'Rajasthani', 'Rapanui', 'Rarotongan', 'Reserved for local user', 'Romance (Other)', 'Romanian', 'Romany', 'Rundi', 'Russian', 'Salishan languages', 'Samaritan Aramaic', 'Sami languages (Other)', 'Samoan', 'Sandawe', 'Sango', 'Sanskrit', 'Santali', 'Sardinian', 'Sasak', 'Saxon, Low', 'Scots',
				'Scottish Gaelic', 'Selkup', 'Semitic (Other)', 'Sepedi', 'Serbian', 'Serer', 'Shan', 'Shona', 'Sichuan Yi', 'Sicilian', 'Sidamo', 'Sign languages', 'Siksika', 'Sindhi', 'Sinhala', 'Sinhalese', 'Sino-Tibetan (Other)', 'Siouan languages', 'Skolt Sami', 'Slave (Athapascan)', 'Slavic (Other)', 'Slovak', 'Slovenian', 'Sogdian', 'Somali', 'Songhai', 'Soninke', 'Sorbian languages', 'Sotho, Northern', 'Sotho, Southern',
				'South American Indian (Other)', 'Southern Altai', 'Southern Sami', 'South Ndebele', 'Spanish', 'Sukuma', 'Sumerian', 'Sundanese', 'Susu', 'Swahili', 'Swati', 'Swedish', 'Syriac', 'Tagalog', 'Tahitian', 'Tai (Other)', 'Tajik', 'Tamashek', 'Tamil', 'Tatar', 'Telugu', 'Tereno', 'Tetum', 'Thai', 'Tibetan', 'Tigre', 'Tigrinya', 'Timne', 'Tiv',
				'tlhIngan-Hol', 'Tlingit', 'Tok Pisin', 'Tokelau', 'Tonga (Nyasa)', 'Tonga (Tonga Islands)', 'Tsimshian', 'Tsonga', 'Tswana', 'Tumbuka', 'Tupi languages', 'Turkish', 'Turkish, Ottoman (1500-1928)', 'Turkmen', 'Tuvalu', 'Tuvinian', 'Twi', 'Udmurt', 'Ugaritic', 'Uighur', 'Ukrainian', 'Umbundu', 'Undetermined', 'Upper Sorbian', 'Urdu', 'Uyghur', 'Uzbek', 'Vai',
				'Valencian', 'Venda', 'Vietnamese', 'Volapük', 'Votic', 'Wakashan languages', 'Walamo', 'Walloon', 'Waray', 'Washo', 'Welsh', 'Wolof', 'Xhosa', 'Yakut', 'Yao', 'Yapese', 'Yiddish', 'Yoruba', 'Yupik languages', 'Zande', 'Zapotec', 'Zenaga', 'Zhuang', 'Zulu', 'Zuni');

        CoverHints: array[0..6] of string = ('', ' f', '_f', 'cover', 'front', 'forside', 'folder');

        PatternHelpText : String =
                        'It is possible to use certain codes to dynamically generate a file path and/or filename.' + #13 +
                        'These are:' + #13 +
												'%artist%' + #13 +
                        '%artist1% (the first letter in artist)' + #13 +
                        '%album%' + #13 +
                        '%album1% (the first letter in album)' + #13 +
                        '%title%' + #13 +
                        '%track%  (3 -> 3) ' + #13 +
												'%track0% (3 -> 03)' + #13 +
												'%year%' + #13 +
                        '%group%' + #13 +
                        '%genre%' + #13 +
                        '%pos%'   + #13 +
                        '%tpos%'  + #13#13 +
                        'It is also possible to do write one value if a field exists and another if it doesn''t.' + #13 +
                        'The syntax is: "<expression ? valueIfTrue|valueIfFalse>" The false value can be left out. Advanced example:' + #13 +
                        '   %artist%\<%album% ? %album%|Unknwon album>\<%pos% ? Disc %pos%<%tpos% ? of %tpos%>>\%title%' + #13 + #13 +

                        'To generate only a new file path, the pattern should have a trailing "\". Example:' + #13 +
                        'C:\Music\%artist%\%album%\' + #13#13 +
                        'To generate both file path and filename, use for example:' + #13 +
                        'C:\Music\%artist%\%album%\%track0% - %title%' + #13 +
                        'Or:' + #13 +
                        'C:\Music\%artist% - %album%\%track0%. %title%' + #13 +
                        'When generating a filename, the file-extension (i.e. .mp3) is automatically added.';

				MUSEPACKPROFILES: array [0..6] of string =
                          ('Telephone', 'Thumb', 'Radio', 'Standard', 'Xtreme', 'Insane', 'Braindead');

	Function winampGetGeneralPurposePlugin: PWinampGeneralPurposePlugin; cdecl; export;

{	procedure SetFlag(var destination: TRecFlag; const flagToSet: TRecFlag; value: Boolean); overload;
  procedure SetFlag(const rec: Prec; flagToSet: TRecFlag; value: Boolean); overload;
  function GetFlag(const flags, flagToGet: TRecFlag): Boolean; overload;
  function GetFlag(const rec: Prec; flagToGet: TRecFlag): Boolean; overload;    }

var
	hWnd_WinAmp, hWnd_PL, hWnd_EQ, hWnd_MB, winamp5Window: hWnd;
  WinampVersion: Integer;
	DirSpy : TJvChangeNotify;
	AudioTypes : Array of TAudioType;
	SkinArray: Array of TSkinRec;
	CurrentActiveForm : TForm;
	loadother, washown, settingsreset, initializing, quitting, MultiUser:boolean;
	VolumeSerialNo     : DWORD;
	winampdir, plugindir, settingsdir, skinDir, username, undoDir, showCoverDir, languageDir, currentLanguageFile, CurrentSkin, CurrentWinampSkin, SkinnerFileName:string;
  CoverThumbsDir: String;
	CurrentSkinDate: TDateTime;
	WinampProcHookID: HHOOK;
	OldWinampWndProc: pointer;
	IconData : TNotifyIconData;
	RecList, GroupList, FieldList, m3uList, AddRecList: Tlist;
  fHashedRecList: TRecHashTable;
	GenreList : TQ_Stringlist;
	ArtistList, albumList, fpathList: TQ_StringList;
	ForceQuit:Boolean;
	FSnap : TSnap;
	IconShowingInSystray: Boolean;
  SongChangedInWinamp: Boolean;

  SetArtistAlbumFilenameCriticalSection, UseReclistCriticalSection, UseId3v2CriticalSection: TCriticalSection;

	BasicSettings, Settings: TMexpIniFile;

  AppFirstRunDate:TDateTime;

implementation
//uses mousehook;

{function GetHTML(hwnd: hwnd; const url: String; const dlgTitle: String; out s: String): Boolean;
var
	GetHTTP: TGetHTTPProc;
  i: integer;
  Str: TStream;
  fname: String;
begin
	try
    @GetHTTP := pointer(SendMessage(hwnd_winamp,WM_USER,0,240));
    if integer(@GetHTTP) in [0, 1] then
    	result := false
    else
		begin
    	repeat
      	fname := plugindir + AppName + '\httpTmp_' + inttostr(random(high(integer))) + '.' + inttostr(random(999))
      until not fileexists(fname);

			i := GetHTTP(hwnd, pchar(url), pchar(fname), pchar(dlgTitle));
    	if (i = 0) and fileexists(fname) then
      begin
      	result := true;
        Str := TFileStream.Create(fname, fmOpenRead	or fmShareDenyWrite);
        if Str.Size > 0 then
        begin
	        SetLength(s, Str.Size);
          Str.Read(s[1], Str.Size)
        end
        else
        	s := '';
        Str.Free;
        Deletefile(fname)
      end
      else
      	result := false
    end
  except
  	result := false
  end
end;        }

{procedure SetFlag(var destination: word; const flagToSet: TRecFlag; value: Boolean); overload;
begin
	if value then
  	//set
  	destination := destination or flagToSet
  else
  	//unset
    destination := destination and not flagToSet
end;

procedure SetFlag(const rec: PRec;  flagToSet: TRecFlag; value: Boolean); overload;
begin
	SetFlag(rec.flags, flagToSet, value)
end;

function GetFlag(const flags, flagToGet: TRecFlag): Boolean; overload;
begin
	result := flags and flagToGet = flagToGet
end;

function GetFlag(const rec: Prec; flagToGet: TRecFlag): Boolean; overload;
begin
	result := Rec.flags and flagToGet = flagToGet
end;      }

procedure BeginSetArtistAlbumFilename;
begin
	SetArtistAlbumFilenameCriticalSection.Enter
end;

procedure EndSetArtistAlbumFilename;
begin
	SetArtistAlbumFilenameCriticalSection.Leave
end;

procedure BeginUseReclist;
begin
	UseReclistCriticalSection.Enter
end;

procedure EndUseReclist;
begin
	UseReclistCriticalSection.Leave
end;

procedure BeginUseId3v2;
begin
	UseId3v2CriticalSection.Enter
end;

procedure EndUseId3v2;
begin
	UseId3v2CriticalSection.Leave
end;

Function GetGenreCount(rec: PRec): Integer;
begin
	if rec.Genree = nil then
  	result := 0
  else
    Move(pointer(integer(rec.Genree)-4)^, result, 4) 
end;

function GetLanguageCodeFromLanguageName(const languageName: string): String;
var
	i: integer;
begin
	if languageName = GetText(TXT_Unknown) then
  	result := UnknownLanguageCode
  else
  begin
	  for i:=0 to length(languageNames)-1 do
	  	if Q_SameText(languageName, languageNames[i]) then
	    begin
	    	result := languageCodes[i];
	      exit
	    end;
		result := ''
	end
end;

function GetLanguageNameFromLanguageCode(const languageCode: string): String;
var
	i: integer;
begin
	i := IndexOfLanguageCode(languageCode);
	if i = -1 then
  	result := GetText(TXT_Unknown)
  else
		result := LanguageNames[i]
end;

function IndexOfLanguageCode(const languageCode: string): integer;
var
	i: integer;
begin
	result := -1;

  for i:=0 to length(languageCodes)-1 do
  	if Q_PosText(languageCode, languageCodes[i]) > 0 then
    begin
    	result := i;
      break
    end;
end;

Procedure FillLanguagesToTStrings(strLst: TStrings);
var
	i: integer;
begin
	strLst.Capacity := strLst.Count + length(LanguageCodes);
  for i:=0 to Length(LanguageCodes)-1 do
  	strLst.AddObject(LanguageNames[i], TObject(LanguageCodes[i]))
end;

procedure GetAbsoluteFilename(BasePath: String; var filename: String);
var
	i: Integer;
begin
  if (length(Filename) > 1) and (filename[1] = '\') and (filename[2] <> '\') then
  	if (BasePath[2] = ':') then
    	filename := Q_CopyRange(BasePath, 1, 2) + filename
    else
    	filename := Q_CopyRange(BasePath, 1, Q_StrScan(BasePath, '\', Q_StrScan(BasePath, '\', 3)+1)-1) + filename

  else

  if not ((length(filename) < 3) or Q_SameStrL(filename, '\\', 2) or (filename[2] = ':') or (Q_PosStr('://', filename)>0)) then
  begin
		while Q_SameStrL(filename, '..\', 3) do
	  begin
      Q_CutRight(BasePath, 1);
      BasePath := Q_CopyRange(basePath, 1, Q_StrRScan(BasePath, '\'));
	    Q_CutLeft(filename, 3)
	  end;
    filename := BasePath + filename
  end;

  i := Q_PosStr('..\', filename);
  while i > 0 do
  begin
  	filename := Q_CopyRange(filename, 1, Q_StrRScan(filename, '\', i-1)) + Q_CopyFrom(filename, i+3);
    i := Q_PosStr('..\', filename)
  end
end;

function GetRelativePath(const BaseName, DestName: string): string;
var      //only works with paths without filename e.g. c:\mp3\albums\
  BasePath, DestPath: string;
  BaseDirs, DestDirs: array[0..129] of PChar;
  BaseDirCount, DestDirCount: Integer;
  I, J: Integer;

  function ExtractFilePathNoDrive(const FileName: string): string;
  begin
		Result := Filename;
    Q_CutLeft(Result, Length(ExtractFileDrive(Result)) + 1)
  end;

  procedure SplitDirs(var Path: string; var Dirs: array of PChar;
    var DirCount: Integer);
  var
    I, J: Integer;
  begin
    I := 1;
    J := 0;
    while I <= Length(Path) do
    begin
      if Path[I] in LeadBytes then Inc(I)
      else if Path[I] = '\' then             { Do not localize }
      begin
        Path[I] := #0;
        Dirs[J] := @Path[I + 1];
        Inc(J);
      end;
      Inc(I);
    end;
    DirCount := J - 1;
  end;

begin
  if Q_SameText(ExtractFileDrive(BaseName), ExtractFileDrive(DestName)) then
  begin
    BasePath := ExtractFilePathNoDrive(BaseName);
    DestPath := ExtractFilePathNoDrive(DestName);
    SplitDirs(BasePath, BaseDirs, BaseDirCount);
    SplitDirs(DestPath, DestDirs, DestDirCount);
    I := 0;
    while (I < BaseDirCount) and (I < DestDirCount) do
    begin
      if AnsiStrIComp(BaseDirs[I], DestDirs[I]) = 0 then
        Inc(I)
      else Break;
    end;
    Result := '';
    for J := I to BaseDirCount - 1 do
      Result := Result + '..\';              { Do not localize }
    for J := I to DestDirCount - 1 do
      Result := Result + DestDirs[J] + '\';  { Do not localize }
  end else Result := DestName;
end;

function InvertDate(date: TDateTime):TDateTime;
var
	i64: int64;
begin
  i64 := 0; //alloc
  move(date, i64, SizeOf(date));
  i64 := not i64;
  move(i64, date, SizeOf(date));
  result := date
end;

Function RemoveBrackets(const S:String): String;
begin
	result := s;
	if ((length(s) > 3) and (((s[1] = '(') and (s[length(s)]=')') and (Q_StrScan(Q_CopyRange(s, 2, length(s)-1), ')')=0)) or ((s[1] = '[') and (s[length(s)]=']')))) then
	begin
		Q_CutLeft(result,1);
		Q_CutRight(result,1);
		Q_TrimInPlace(result)
	end
end;

function GetFuzzyText(const s:string):String;
	const removeChars: array[1..29] of char = ('-', '(', ')', '[', ']', '?', ',', ':', ';', ',', '.', '_', '^', '¨', '~', '@', '#', '!', '½', '%', '&', '/', '=', '´', '''', '*', ' ', '|', '`');
  const replaceChars: array[1..8] of array[1..2] of char = (('@', 'a'), ('ø', 'o'), ('c', 'k'), ('w', 'v'), ('ä', 'a'), ('ö', 'o'), ('ü', 'u'), ('ß', 's'));
  var
  	i, k, p, l: Integer;
    b: Boolean;
begin
  try
    l := length(s);
    p := 0;
    setLength(result, l);
    for i:=1 to length(s) do
      begin
        b := false;
      	for k:=1 to 8 do
      		if s[i] = replaceChars[k][1] then
          begin
          	b := true;
            inc(p);
            result[p] := replaceChars[k][2]
          end;
        if not b then
        begin
        	for k:=1 to 29 do
          	if removeChars[k] = s[i] then
            begin
            	b := true;
              break
            end;
        	if not b then
          begin
            inc(p);
          	result[p] := s[i]
          end
      	end
      end;
			if p < l then
      	Q_CutRight(result, l-p);
      Q_StrLower(result);
      result := Q_ReplaceText(result, 'å', 'aa');
    	result := Q_ReplaceText(result, 'æ', 'ae');
    except
    	result := ''
    end
end;

function sameRect(const r1, r2: TRect): Boolean;
begin
	result := (r1.Left = r2.Left) and (r1.Top = r2.Top) and (r1.Right = r2.Right) and (r1.Bottom = r2.Bottom)
end;

function pointInRect(const pt:Tpoint; const rt:Trect):boolean;
begin
  result := (pt.x >= rt.Left) and (pt.x <= rt.Right) and (pt.y >= rt.Top) and (pt.y <= rt.Bottom)
end;

function RandomFilename(pathName, extension: String; returnWithPath: boolean): String;
begin
	if (length(pathName)>1) and (pathName[length(pathName)-1] <> '\') then
  	pathName := pathName + '\';

	repeat
  begin
		result := chr(random(24) + 65) + chr(random(24) + 65) + chr(random(24) + 65) + chr(random(24) + 65) + chr(random(24) + 65) + chr(random(24) + 65) + '.' + extension
  end
  until not fileexists(pathName + result);

  if returnWithPath then
  	result := pathName + result
end;

function DrivePresent(drive:char):boolean;
var
   DrvNum: byte;
   EMode: Word;
begin
   result := false;
   DrvNum := ord(Drive);
   if DrvNum >= ord('a') then dec(DrvNum,$20);
   EMode := SetErrorMode(SEM_FAILCRITICALERRORS);
   try
			if DiskSize(DrvNum-$40) <> -1 then result := true;
   finally
       SetErrorMode(EMode);
   end;
end;

function FileDeleteRB(const FileName:string): boolean; //sletter filen vha. recycle bin
var
  fos : TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);
  with fos do begin
    wFunc  := FO_DELETE;
    pFrom  := PChar(FileName+#00);
		fFlags := FOF_ALLOWUNDO
              or FOF_NOCONFIRMATION
              or FOF_SILENT;
  end;
  Result := (ShFileOperation(fos)=0);
end;


function GetTextWidth(const s:String; f:Tfont):integer;
var      b:TBitmap;
begin
  b := TBitmap.create;
  b.Canvas.Font := f;
  result := b.Canvas.TextWidth(s);
  b.free
end;

{function GetFileTimes(const FileName: string; var Created: TDateTime; var Accessed: TDateTime; var Modified: TDateTime): Boolean;
var
	h: THandle;
	sr: TSearchRec;
	Info1, Info2, Info3: TFileTime;
	SysTimeStruct: SYSTEMTIME;
	Bias: Double;
begin
	Result := False;
	Bias   := 0;
	h      := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
	if h > 0 then
	begin
		try
			//if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
			//  Bias := TimeZoneInfo.Bias / 1440; // 60x24
			GetFileTime(h, @Info1, @Info2, @Info3);
			if FileTimeToSystemTime(Info1, SysTimeStruct) then
				Created := SystemTimeToDateTime(SysTimeStruct) - Bias;
			if FileTimeToSystemTime(Info2, SysTimeStruct) then
				Accessed := SystemTimeToDateTime(SysTimeStruct) - Bias;
			if FileTimeToSystemTime(Info3, SysTimeStruct) then
				Modified := SystemTimeToDateTime(SysTimeStruct) - Bias;
			Result := True;
		finally
			FileClose(h);
		end;
	end;
	if (h > 0) and (created = 0) then
	begin
		if findFirst(FileName, faAnyFile, sr)=0 then
		try
			if FileTimeToSystemTime(sr.FindData.ftCreationTime, SysTimeStruct) then
				Created := SystemTimeToDateTime(SysTimeStruct) - Bias
			finally
				FindClose(sr)
		end
	end
end;      }

{function GetFileAge(const Filename:String):TDateTime;
var      accessed, created:TDateTime;
begin
	GetFileTimes(filename, created, accessed, result)
end;   }

procedure SetFilename(rec: PRec; const newFilename:String; updateHashedReclist: boolean);  //updateHashedReclist is used with AutoScan
var
	index:integer;
  hash: LongWord;
begin
	hash := Q_TextHashKey(newFilename);

  if updateHashedReclist then
  begin
		//Remove old
	  if (rec.fPath < fPathList.Count) and fHashedRecList.FindFilename(FpathList.strings[rec.fPath] + rec.fName, index) then
	  	fHashedRecList.Delete(index);

	  //Get index to new file
		if fHashedRecList.FindFilename(newFilename, hash, index) and (fHashedRecList.List^[index] = rec) then
		begin
	  	//The file is somehow already in the list (this shouldn't happen). Remove the old
			fHashedRecList.Delete(index)
		end;
  end;

  rec.FilenameHash := hash;
	rec.fPath := MainFormInstance.SetFpath(Q_CopyLeft(newFilename, Q_StrRScan(newFilename, '\')));
	SetPCharString(rec.Fname, Q_CopyFrom(newFilename, Q_StrRScan(newFilename, '\')+1));

	if updateHashedReclist then
  	fHashedRecList.Insert(index, rec)
end;

function GetFileSize(const s:String):cardinal;
var      Fstr:TStream;
begin
  try
	  Fstr := TFileStream.Create(s, fmOpenRead or fmShareDenyNone);
	  result := Fstr.Size;
	  Fstr.free
  except
  	result := 0
  end
end;

function MoveFileX(const source: String; const destination: String; Overwrite: Boolean): Boolean;
var
	sameDrive, DeleteDestination, CanOpenSource: Boolean;
begin
	result := true;
	if Q_SameText(source, destination) then	//filen skal omdøbes til sig selv -> alt i orden
		exit;

	sameDrive := Q_SameText(ExtractFileDrive(source), ExtractFileDrive(destination));

	CanOpenSource := GetFileAccess(source, true, true, true);

	DeleteDestination := Overwrite and FileExists(destination) and CanOpenSource and GetFileAccess(destination, false, true, true);
	if not DeleteDestination and FileExists(destination) then
	begin	//der må ikke overskrives, og filen existerer i forvejen
		result := false;
		exit
	end;

	if FileExists(source) and CanOpenSource then
	begin
		if DeleteDestination then
		try
			result := DeleteFile(destination);
		except
			result := false;
		end;

		if result then
		begin
			try
				if sameDrive then
					result := MoveFile(Pchar(source), pChar(destination))
				else
				begin
					if CopyFile(pChar(source), PChar(destination), false) then
						result := DeleteFile(source)
					else
						result := false
				end
			except
				result := false
			end;
		end else result := false
	end else result := false
end;

Procedure ReleaseForm(var F:TForm);
begin
        if not assigned(F) then exit;
        try
                F.Release;
                freeandnil(F)
        except
        end
end;

Procedure AddToTlist(target:Tlist; source:Tlist);
var       i:integer;
begin
     target.Capacity := target.count + source.count;
     for i:=0 to source.count-1 do
         target.Add(source.items[i])
end;

Procedure ChangeCursor(i:integer);
begin
        case i of
                0 : screen.cursor := crDefault;
                1 : screen.Cursor := crHourglass;
                2 : screen.Cursor := crAppStart
        end
end;

Function GetFileAccess(const FileName : String; Read, Write:Boolean; TryUnsetReadOnlyAttribute:Boolean=false; TestShareExclusive:boolean=false):Boolean;
var
	Str:TStream;
begin
{$I-}
        result := false;
				Str := nil;
        if Fileexists(Filename) then
				begin
             result := true;
             if Read then
             begin
                  try
                     Str := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
										 freeAndNil(Str)
                  except
                        result := false
                  end;
                  if assigned(Str) then freeAndNil(Str)
             end;
             if TryUnsetReadOnlyAttribute and (FileGetAttr(Filename) and fareadonly <> 0) then FileSetAttr(Filename, FileGetAttr(Filename) and not faReadOnly);
             if Write and Result then
             begin
									try
                     if TestShareExclusive then
												Str := TFileStream.Create(Filename, fmOpenWrite or fmShareExclusive)//	fmShareDenyNone);
										 else Str := TFileStream.Create(Filename, fmOpenWrite or fmShareDenyNone);
										 freeAndNil(Str)
                  except
                        result := false
                  end;
                  if assigned(Str) then freeAndNil(Str)
             end
        end
{$I+}
end;

Function OpenReadWriteFileStream(const FileName : String; out filemode: Integer): TFileStream;
begin
{$I-}
	try
  	result := TFilestream.Create(Filename, fmOpenReadWrite or fmShareDenyWrite);
    fileMode := fmOpenReadWrite
  except
    try
      result := TFilestream.Create(Filename, fmOpenRead or fmShareDenyWrite);
      fileMode := fmOpenRead
    except
      try
        result := TFilestream.Create(Filename, fmOpenRead or fmShareDenyNone);
        fileMode := fmOpenRead
      except
        result := nil
      end
    end
  end
{$I+}
end;

Function NearestDiv(Number:Integer; By:Integer) :Integer;
var     r, delta:double;
        i:integer;
begin
  if (By = 0) or (number = 0) then
  	result := Number
  else
  begin
  	r := number / By;
	  i := Trunc(r);
	  delta := r - i;
	  if delta >= 0.5 then
    	result := (i+1) * By
    else
    	result := i * by
  end
end;

Function ConnectedToInternet:boolean;
var
  Key: hKey;
  PC: Array[0..4] of Char;
  Size: Integer;
  RegSays : Boolean;
  FCurrentIP : String;       {<--RLM Diagnostics}
  FpCurrHostEnt : PHostEnt;  {<--RLM Diagnostics}

	function IsIPPresent: Boolean;
	type
    TaPInAddr = Array[0..10] of PInAddr;
    PaPInAddr = ^TaPInAddr;
  var
    phe: PHostEnt;
    pptr: PaPInAddr;
    Buffer: Array[0..63] of Char;
    I: Integer;
    GInitData: TWSAData;
    IP: String;
  begin
    WSAStartup($101, GInitData);
    Result := False;
    GetHostName(Buffer, SizeOf(Buffer));
    phe := GetHostByName(buffer);
    FpCurrHostEnt := phe;
    if phe = nil then Exit;
    pPtr := PaPInAddr(phe^.h_addr_list);
    I := 0;
    while pPtr^[I] <> nil do
     begin
			IP := inet_ntoa(pptr^[I]^);
      Inc(I);
     end;
    FCurrentIP := IP;
    WSACleanup;
    Result := (IP <> '') and (IP <> '127.0.0.1');
  end;

begin
    try
		 result := IsIPPresent;

		 if RegOpenKey(HKEY_LOCAL_MACHINE, 'System\CurrentControlSet\Services\RemoteAccess', Key) = ERROR_SUCCESS then
      begin
       Size := 4;
       if RegQueryValueEx(Key, 'Remote Connection', nil, nil, @PC, @Size) = ERROR_SUCCESS then
        begin
         {Original}
         {
         FOnline := PC[0] = #1;
         FixOnlineState;
         }
         {Changed 12/13/99 RLM -- AOL leaves PC bytes all 00's}
         RegSays := PC[0] = #1;
				 result := result or RegSays
        end
       else
        begin
         result := IsIPPresent
        end;
       RegCloseKey(Key);
      end
     else
      begin
       result := IsIPPresent
      end;
    except
     result := false
    end
end;

Function GetOneOrZero(const c1:integer):integer;
begin
     if c1=0 then result := 0
     else if c1>0 then result := 1
     else result := -1
end;

Function CompInt64(const c1, c2:Int64):integer;
begin
		 if c1 = c2 then
        result := 0
     else if c1 < c2 then
					result := -1
     else result := 1
end;

Function CompCardinal(const c1, c2:cardinal):integer;
begin
     if c1 = c2 then
        result := 0
     else if c1 < c2 then
          result := -1
     else result := 1
end;

Function CompInteger(const c1, c2:Integer):integer;
begin
     if c1 = c2 then
        result := 0
		 else if c1 < c2 then
          result := -1
     else result := 1
end;

Function CompSmallInt(const c1, c2:smallInt):integer;
begin
     if c1 = c2 then
        result := 0
     else if c1 < c2 then
          result := -1
     else result := 1
end;

Function CompByte(const c1, c2:byte):integer;
begin
     if c1 = c2 then
        result := 0
     else if c1 < c2 then
          result := -1
     else result := 1
end;

Function CompWord(const c1, c2:word):integer;
begin
     if c1 = c2 then
				result := 0
     else if c1 < c2 then
					result := -1
     else result := 1
end;

Function CompShortInt(const c1, c2:ShortInt):integer;
begin
     if c1 = c2 then
        result := 0
     else if c1 < c2 then
          result := -1
     else result := 1
end;

Function CompSingle(const c1, c2:Single):integer;
begin
   if c1 = c2 then
    result := 0
 else if c1 < c2 then
      result := -1
 else result := 1
end;

Function TimeToInt(const Time:TTime):cardinal;
var
	h,m,s,n:word;
begin
	decodetime(time,h,m,s,n);
  result := (h*60*60*1000) + (m*60*1000) + (s*1000) + n
end;

Function IntToTime(const Time:int64):TTime;
var     h:word;
        m,s,n:word;
begin
	dectime(Time, h, m, s, n);
  result := encodetime(h, m, s, n);
end;

Procedure DecTime(const Time: int64; var h, m, s, ms: Word; Const NoMsec:Boolean=false);
var
	i:int64;
begin
	i := abs(time);
	h := i div 3600000;
	i := i - int64(h)*3600000;
	m := i div 60000;
	i := i - (m * 60000);
	s := i div 1000;
	ms := i - (s * 1000);

	if NoMsec and (ms >= 500) then
	begin
		inc(s);
		if s = 60 then
		begin
			inc(m);
			s := 0;
			if m = 60 then
			begin
				inc(h);
				m := 0
			end
		end
	end
end;

Function IntTimeToStr(const time:int64; TwoMinDigits, AlwaysShowHour:Boolean):String;
var     h:word;
				m,s,n:word;
begin
	DecTime(time,h,m,s,n,true);
  //den flipper somme tider:
  if s = 65535 then
  	s := 0;

	if (h > 0) or AlwaysShowHour then
  	result := inttostr(h) + ':'
  else
  	result := '';

	if TwoMinDigits or (h > 0) or AlwaysShowHour then
	begin
		if m > 9 then
			result := result + inttostr(m) + ':'
		else
			result := result + '0' + inttostr(m) + ':'
	end
	else
		result := result + inttostr(m) + ':';

	if s > 9 then
		result := result + inttostr(s)
	else
		result := result + '0' + inttostr(s)
end;

Function IntTimeToSec(const Time:int64):int64;
begin
	result := round(time / 1000)
end;

Function IsInteger(const s:String): boolean;
var
  E, i: Integer;
begin
  Val(S, i, E);
  Result := E = 0;
end;

Function TheFix(const s:String):String;
begin
  result := s;
  if (length(s) > 6) then
    if Q_SameTextL(s, 'THE ',4) then
       result := Q_CopyFrom(s, 5)
end;

function MyTrunc(const X : Double) : Int64;
begin
	result := trunc(x);
end;


{
function PLWndProc(hWnd:HWND; Mess:cardinal; wparam: WPARAM; lparam: LPARAM):LongInt;
begin
		if (Mess=WM_USER) and (wParam=$29A) and (lParam >= $40000000) then
		begin
				 //sangen er skiftet!
				 if assigned(MainFormInstance) and MainFormInstance.sliderTimer.enabled then
						MainFormInstance.slidertimertimer(nil)
		end;
		result := CallWindowProc(OldPLWndProc, hWnd, Mess, wParam, lParam)
end; }

function WinAMPWndProc(hWnd:HWND; Mess:cardinal; wparam: WPARAM; lparam: LPARAM):LongInt;
begin
	if (mess=WM_USER) and ((Lparam=$DEADBEEF) or (Lparam=1101) and (WParam=0)) and assigned(MainFormInstance) then
  	SongChangedInWinamp := true;
	if (Mess=WM_LBUTTONDBLCLK) then
		if assigned(pref) and (HiWord(LParam) in [57..69]) and (LoWord(LParam) > (242)) and (LoWord(LParam) < (264)) then
			MainFormInstance.WinAmpPlaylistBtnClicked;

  // Thread synchronization changed with Delphi6 and does not work from a dll.
  // Therefore we need to call CheckSynchronize manually. Not sure if this is the
  // best place for it but it seems to work. 
  CheckSynchronize();

	result := CallWindowProc(OldWinAMPWndProc, hWnd, Mess, wParam, lParam)
end;

procedure FillAudioType;
begin
		 SetLength(audioTypes, PREDEFINED_AUDIOTYPESCOUNT);

		 audioTypes[0].longName := 'MPEG Audio Layer 3';
		 audioTypes[0].shortName := 'MP3';
		 audioTypes[0].SortIndex := 2;
		 audioTypes[0].StopWinampWhenEdit := false;
		 audioTypes[0].Id3v1 := true;
		 audioTypes[0].Id3v2 := true;
		 audioTypes[0].Ogg   := false;
		 audioTypes[0].ApeV1 := false;
		 audioTypes[0].ApeV2 := false;
		 audioTypes[0].WMA   := false;
     audioTypes[0].audio := true;
     audioTypes[0].video := true;
     setLength(audioTypes[0].ext, 2);
     audioTypes[0].ext[0] := '.mp3';
     audioTypes[0].ext[1] := '.mp2';
     setLength(audioTypes[0].channelNames, 5);
     audioTypes[0].channelNames[0] := 'Stereo';
     audioTypes[0].channelNames[1] := 'Joint Stereo';
		 audioTypes[0].channelNames[2] := 'Dual Channel';
     audioTypes[0].channelNames[3] := 'Mono';
     audioTypes[0].channelNames[4] := 'Unknown';

		 audioTypes[1].longName := 'MusePack/MpegPlus';
		 audioTypes[1].shortName := 'MusePack';
		 audioTypes[1].SortIndex := 3;
		 audioTypes[1].StopWinampWhenEdit := false;
     audioTypes[1].Id3v1 := true;
		 audioTypes[1].Id3v2 := false;
		 audioTypes[1].Ogg   := false;
		 audioTypes[1].ApeV1 := true;
		 audioTypes[1].ApeV2 := true;
		 audioTypes[1].WMA   := false;
     audioTypes[1].audio := true;
     audioTypes[1].video := true;
     setLength(audioTypes[1].ext, 2);
     audioTypes[1].ext[0] := '.mpc';
     audioTypes[1].ext[1] := '.mp+';
     setLength(audioTypes[1].channelNames, 3);
     audioTypes[1].channelNames[0] := 'Unknown';
		 audioTypes[1].channelNames[1] := 'Stereo';
		 audioTypes[1].channelNames[2] := 'Joint Stereo';

		 audioTypes[2].shortName := 'Ogg';
		 audioTypes[2].longName := 'Ogg Vorbis';
		 audioTypes[2].SortIndex := 4;
		 audioTypes[2].StopWinampWhenEdit := true;
     audioTypes[2].Id3v1 := false;
		 audioTypes[2].Id3v2 := false;
		 audioTypes[2].Ogg   := true;
		 audioTypes[2].ApeV1 := false;
		 audioTypes[2].ApeV2 := false;
		 audioTypes[2].WMA   := false;
     audioTypes[2].audio := true;
     audioTypes[2].video := true;
     setLength(audioTypes[2].ext, 1);
		 audioTypes[2].ext[0] := '.ogg';
		 setLength(audioTypes[2].channelNames, 3);
     audioTypes[2].channelNames[0] := 'Unknown';
     audioTypes[2].channelNames[1] := 'Mono';
     audioTypes[2].channelNames[2] := 'Stereo';

		 audioTypes[3].shortName := 'WMA';
		 audioTypes[3].longName := 'Windows Media Audio';
		 audioTypes[3].SortIndex := 6;
		 audioTypes[3].StopWinampWhenEdit := false;
		 audioTypes[3].Id3v1 := false;
		 audioTypes[3].Id3v2 := false;
		 audioTypes[3].Ogg   := false;
		 audioTypes[3].ApeV1 := false;
		 audioTypes[3].ApeV2 := false;
		 audioTypes[3].WMA   := true;
     audioTypes[3].audio := true;
     audioTypes[3].video := true;
		 setLength(audioTypes[3].ext, 1);
		 audioTypes[3].ext[0] := '.wma';
		 setLength(audioTypes[3].channelNames, 3);
		 audioTypes[3].channelNames[0] := 'Unknown';
		 audioTypes[3].channelNames[1] := 'Mono';
		 audioTypes[3].channelNames[2] := 'Stereo';

		 audioTypes[4].shortName := 'Ape';
		 audioTypes[4].longName := 'Monkey''s Audio';
		 audioTypes[4].SortIndex := 1;
		 audioTypes[4].StopWinampWhenEdit := false;
		 audioTypes[4].Id3v1 := true;
		 audioTypes[4].Id3v2 := false;
		 audioTypes[4].Ogg   := false;
		 audioTypes[4].ApeV1 := true;
		 audioTypes[4].ApeV2 := false;
		 audioTypes[4].WMA   := false;
     audioTypes[4].audio := true;
     audioTypes[4].video := true;
		 setLength(audioTypes[4].ext, 1);
		 audioTypes[4].ext[0] := '.ape';
		 setLength(audioTypes[4].channelNames, 3);
		 audioTypes[4].channelNames[0] := 'Unknown';
		 audioTypes[4].channelNames[1] := 'Mono';
		 audioTypes[4].channelNames[2] := 'Stereo';

		 audioTypes[5].longName := 'Wave';
		 audioTypes[5].shortName := 'Wave';
		 audioTypes[5].SortIndex := 5;
		 audioTypes[5].StopWinampWhenEdit := false;
		 audioTypes[5].Id3v1 := false;
		 audioTypes[5].Id3v2 := false;
		 audioTypes[5].Ogg   := false;
		 audioTypes[5].ApeV1 := false;
		 audioTypes[5].ApeV2 := false;
		 audioTypes[5].WMA   := false;
     audioTypes[5].audio := true;
     audioTypes[5].video := true;
		 setLength(audioTypes[5].ext, 1);
		 audioTypes[5].ext[0] := '.wav';
		 setLength(audioTypes[5].channelNames, 3);
		 audioTypes[5].channelNames[0] := 'Unknown';
		 audioTypes[5].channelNames[1] := 'Mono';
		 audioTypes[5].channelNames[2] := 'Stereo';
end;

Function GetUser: String;
var
	UName: PChar;
	iSize: DWORD;
begin
	iSize := SizeOf(ShortString);
	GetMem(UName, iSize);
	GetUserName(UName, iSize);
	result := Trim(StrPas(UName));
	FreeMem(UName)
end;


procedure AddAppStartDate(date: TDateTime);
begin
	if date < AppFirstRunDate then
  	AppFirstRunDate := date
end;

function rot(const s:String):String;
var
	i, c:integer;
begin
	setLength(result, length(s));
	for i:=1 to length(s) do
	begin
		c := ord(s[i]) + 128;
		if c > 255 then
			dec(c, 256);
		result[i] := chr(c)
	end
end;

procedure DisplaySystrayIcon(initiallyToggled: boolean);
begin
	IconShowingInSystray := true;
	IconData.cbSize := sizeof(IconData);
  IconData.Wnd := MainFormInstance.Handle;
  IconData.uID := 100;
  IconData.uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  IconData.uCallbackMessage := WM_USER + 1;
  if initiallyToggled then
  	IconData.hIcon := MainFormInstance.Icon2.picture.Icon.Handle
  else
  	IconData.hIcon := MainFormInstance.Icon1.picture.Icon.Handle;
  StrPCopy(IconData.szTip, AppName);
  Shell_NotifyIcon(NIM_ADD, @IconData)
end;

Procedure InitSnap;
var
	i: Integer;
begin
	winamp5Window := FindWindow(pchar('BaseWindow_RootWnd'), pchar('Player Window'));
  if Assigned(FSnap) then
  	FSnap.Free;

  FSnap := TSnap.Create(MainFormInstance);
  FSnap.AddHook(hWnd_Pl, hWnd_PL,  nil, true, false, false, false, false, false);
  FSnap.AddHook(hWnd_Eq, hWnd_Eq, nil, true, false, false, false, false, false);
  FSnap.AddHook(hWnd_MB, hWnd_MB, nil, true, false, false, false, false, false);
  if winamp5Window = 0 then
    FSnap.AddHook(hWnd_winamp, hWnd_winamp, nil, true, false, false, false, false, false)
  else
  begin
    FSnap.AddHook(hWnd_winamp, winamp5Window, nil, true, false, false, false, false, true);	//USed for show/hide with winamp
    //FSnap.AddHook(winamp5Window, winamp5Window, nil, false, false, false, false, false, true); //Used for snapping
  end;

  if pref.showhide.Checked then
  begin
    if winamp5Window = 0 then
      i := hwnd_Winamp
    else
      i := winamp5Window
  end
  else
    i := 0;

  TSnapWin(FSnap.AddHook(MainFormInstance.handle, MainFormInstance.handle, MainFormInstance, false, true, true, true, MainFormInstance.aot.Checked, false)).ShowHideWith := i;
end;

Function Init: Integer; cdecl;
var
	 pbuffer:array[0..max_path] of char;
begin
 // Sleep(10000);
	initializing := true;
  AppFirstRunDate := now;
  SongChangedInWinamp := false;
	BasicSettings := nil;
	Settings := nil;
	CurrentActiveForm := nil;
	FSnap := nil;
	dirSpy := nil;
	MainFormInstance := nil;
	pref := nil;
	quitting := false;
	ForceQuit := false;
	loadother := true;
	if loadother then
	begin
	  if IsWindow(hWnd_winamp) then
			SetWindowLong(hWnd_Winamp, GWL_WNDPROC, LongInt(OldWINAMPWndProc));

    SetArtistAlbumFilenameCriticalSection := TCriticalSection.Create;
    UseReclistCriticalSection := TCriticalSection.Create;
		UseId3v2CriticalSection := TCriticalSection.Create;

		//dirs:
		GetModuleFileName(application.handle,pbuffer,max_path);
		winampdir := ExtractFileDir(pbuffer) + '\';
		GetModuleFileName((GetModuleHandle('gen_mexp.dll')),pbuffer,MAX_PATH);
		plugindir := ExtractFileDir(pbuffer) + '\';
		LanguageDir := pluginDir + AppName + '\Languages\';
		currentLanguageFile := 'english';
		undoDir := plugindir + AppName + '\Undo\';
		skinDir := plugindir + AppName + '\Skins\';
    CoverThumbsDir := plugindir + AppName + '\Cache\Covers\Thumbs\';

    if not directoryexists(CoverThumbsDir) then
			forcedirectories(CoverThumbsDir);

    showCoverDir := plugindir + AppName + '\ShowCover\';

    hWnd_WinAmp := WinampGeneralPurposePlugin.hwndParent;// = FindWindow('Winamp v1.x', nil) then
		hWnd_PL := findWindow('Winamp PE',nil);
		hWnd_EQ := findWindow('Winamp EQ',nil);
		hWnd_MB := findWindow('Winamp MB',nil);
    WinampVersion := SendMessage(hwnd_winamp, WM_USER, 0, 0);

		CurrentSkin := 'Base';
		CurrentWinampSkin := '';

		BasicSettings := TMexpIniFile.Create(pluginDir + AppName + '\Settings.ini');

		username := GetUser;
		MultiUser := BasicSettings.ValueExists('MultipleUsers') and BasicSettings.ReadBool('MultipleUsers');
		if MultiUser then
			settingsdir := plugindir + AppName + '\Users\' + username + '\'
		else
			settingsdir := plugindir + AppName + '\Users\Standard\';

		if MultiUser and fileexists(SettingsDir + UseDefaultDummyFile) then
			settingsdir := plugindir + AppName + '\Users\Standard\';

    if not directoryexists(settingsdir) then
			forcedirectories(settingsdir);

		Settings := TMexpIniFile.Create(SettingsDir + 'Settings.ini');
     
    if BasicSettings.ValueExists(rot('Fåæáo´ôÖá´oå')) then
	    AddAppStartDate(BasicSettings.ReadDate(rot('Fåæáo´ôÖá´oå')))
    else
			BasicSettings.WriteDate(rot('Fåæáo´ôÖá´oå'), AppFirstRunDate);

    if Settings.ValueExists('Fåæáo´ôÖá´oå') then
	    AddAppStartDate(Settings.ReadDate('Fåæáo´ôÖá´oå'))
    else
			Settings.WriteDate('Fåæáo´ôÖá´oå', AppFirstRunDate);

		SkinnerFileName := plugindir + AppName + '\Skinner\Skinner.exe';

		// end of Dirs
		FillAudioType;

		LoadLanguage(LanguageDir + CurrentLanguageFile);

		Application.CreateForm(TMainForm, MainFormInstance);

		Application.CreateForm(Tpref, pref);

		pref.allowmu.checked := MultiUser;
		pref.usernamel.caption := GetText(TXT_guiCurrentUser, [username]);
		pref.userdir.caption := settingsdir;

		if pref.sit.checked then
			MainFormInstance.BorderStyle :=  bsSizeable
		else
			MainFormInstance.BorderStyle := bssizetoolwin;
    
    if pref.IconInSystray.Checked then
			DisplaySystrayIcon(true)
    else
			IconShowingInSystray := false;

    //		MainFormInstance.BorderIcons := [biSystemMenu];

		setWindowLong(MainFormInstance.Handle, GWL_STYLE, GetWindowLong(MainFormInstance.Handle,GWL_STYLE) and not WS_CAPTION and not WS_THICKFRAME);

		MainFormInstance.Height :=MainFormInstance.ClientHeight;
		MainFormInstance.width := MainFormInstance.clientwidth;
		OldWinAMPWndProc := pointer(SetWindowLong(hwnd_Winamp, GWL_WNDPROC, longInt(@WinAMPWndProc))); //til doubleclick
    winamp5Window := FindWindow(pchar('BaseWindow_RootWnd'), pchar('Player Window'));
	end;

	if assigned(MainFormInstance) and assigned(pref) then
	begin
    InitSnap;
		MainFormInstance.loadSettings;
		if Settings.ValueExists('visible') and Settings.readBool('visible') then
			MainFormInstance.showAform
		else
			if ((pref.loadon.itemindex = 0) or pref.ControlPlaylist.Checked) and (not DBinitiated) then
				MainFormInstance.InitDB
      end;
  MainFormInstance.ToggleSystrayIcon(false);
  initializing := false;
	result := 0 //the plugin was succesfully initialized
end;

Procedure Config; cdecl;
begin
end;

Procedure Quit; cdecl;
begin
if loadother then
begin
  MainFormInstance.ToggleSystrayIcon(true);
	if MainFormInstance.Partymode1.Checked then
		MainFormInstance.DisablePartyMode;
//	MainFormInstance.QuitTimer.enabled := false;
	quitting := true;

	if IconShowingInSystray then
  begin
    IconShowingInSystray := false;
		Shell_NotifyIcon(NIM_DELETE, @IconData)
  end;

	MainFormInstance.filtertimer.enabled := false;
	MainFormInstance.slidertimer.enabled := false;

	if MainFormInstance.ScanThread.Runing then
	begin
		MainFormInstance.StopScanning
	end;

  MainFormInstance.StopCoverThread;

	MainFormInstance.KillDirSpys;

	if pref.Visible then
		pref.modalresult := mrcancel;

	try
  	if DBinitiated then
			MainFormInstance.SaveSettings(true);
		MainFormInstance.tabel.Clear;
	except
	end;

	if assigned(FSnap) then
		FSnap.free;	//Skal kaldes efter  SaveSettings!

	MainFormInstance.release;
	pref.release;
	if assigned(Editor) then Editor.release;
	if assigned(dbpref) then dbpref.release;
	if assigned(deletefromhd) then deletefromhd.release;
	if assigned(groupsform) then groupsform.release;
	if assigned(addgroup) then addgroup.release;
	if assigned(DubWizForm) then DubWizForm.release;
	if assigned(inputbox2) then inputbox2.release;

	UnloadLanguage;

	SetLength(SkinArray, 0);

	if assigned(BasicSettings) then
		BasicSettings.Free;
	if assigned(Settings) then
		Settings.Free;

  try
  	SetArtistAlbumFilenameCriticalSection.free;
    UseReclistCriticalSection.Free;
    UseId3v2CriticalSection.Free
  except
  end;

	if ForceQuit then
  	application.terminate;
end
	//When winamp is closed, this method is executed.
	//here you can free alocated memory
end;

Function winampGetGeneralPurposePlugin: PWinampGeneralPurposePlugin; cdecl;
begin
	Result := @WinampGeneralPurposePlugin;
end;


end.

