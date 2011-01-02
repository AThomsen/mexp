{$B-}
unit ID3Tags;

{

  Class for manipulation with ID3v1 & ID3v1.1 tags

  (c) 1999,2000 Andrey V.Sorokin
  Saint-Petersburg, Russia
  anso@mail.ru
  anso@usa.net
  http://anso.da.ru
  http://anso.virtualave.net

  v. 1.1 27.02.00
   -=- (-) Fixed file open modes

  v. 1.0 27.11.99
   -=- First release
}

interface

uses
 Classes;

type
 TID3v1Tag = class // ID3v1 & ID3v1.1

   private
    fOk : boolean;
    fModified : boolean;
    fv1 : boolean;
    fTitle : string; // 30
    fArtist : string; // 30
    fAlbum : string; // 30
    fTrack : integer;
    fComment : string; // 30 in ID3v1, 28 in ID3v1.1
    fYear : string; // 4
    fGenreID : integer;
    fGenre : string;

    procedure Setv1 (b : boolean);
    procedure SetField (AIdx : integer; const s : string);
    procedure SetGenreID (AGenreID : integer);
    procedure SetTrack (ATrack : integer);

   public

    constructor Create;

    procedure Load (const ABuf; ABufSz : integer);
    // Load tag from ABuf (max ABufSz)

    procedure LoadFromStream (AStream : TStream; AStreamSz : integer);
    // find ID3tag in AStream (max AStreamSz bytes from curren position)
    // and Load it. If success then returns offset to tag, else -1

    procedure LoadFromFile (const AFileName : string);
    // Load ID3Tag from file AFileName

    procedure Save (var ABuf; ABufSz : integer);
    // Write tag into ABuf (max ABufSz bytes), clear Modified

    procedure SaveToStream (AStream : TStream);
    // Write tag ito current position of AStream, clear Modified

    procedure SaveToFile (const AFileName : string);
    // Add/Update tag in file AFileName, clear Modified

    procedure DeleteFromFile (const AFileName : string);
    // Delete tag from file AFileName (if exists)

    property Ok : boolean read fOk write fOk;
    // True if loaded tag seems to be Ok

    property Modified : boolean read fModified;
    // true if anything changed

    property v1 : boolean read fv1 write Setv1;
    // True if ID3v1, false if ID3v1.1

    property Title : string index 1 read fTitle write SetField;
    // Music title

    property Artist : string index 2 read fArtist write SetField;
    // Performer

    property Year : string index 3 read fYear write SetField;
    // year as 4-chars string

    property Album : string index 4 read fAlbum write SetField;
    // Album title

    property Track : integer read fTrack write SetTrack; // ID3v1.1 only
    // Track number (only if not v1)

    property Comment : string index 5 read fComment write SetField;
    // Comment

    property GenreID : integer read fGenreID write SetGenreID;
    // Genre ID (see ID3Genres withc contains genres
    // list as TStrings)

    property Genre : string read fGenre;
    // Genre string
  end;


const
 ID3v1TagLen = 128;

var
  ID3Genres : TStringList;

implementation

uses
 SysUtils;


constructor TID3v1Tag.Create;
 begin
  inherited;
  fOk := false;
  fModified := false;
 end; { of constructor TID3v1Tag.Create
--------------------------------------------------------------}

procedure TID3v1Tag.Setv1 (b : boolean);
 begin
  if fv1 <> b then begin
    fv1 := b;
    fModified := True;
   end;
 end; { procedure TID3v1Tag.Setv1
--------------------------------------------------------------}

procedure TID3v1Tag.SetField (AIdx : integer; const s : string);
 procedure SetIt (const ANewValue : string; AMaxLen : integer; var AField : string);
  var s2:String;
  begin
   if aNewValue = '' then s2 := #0 else s2 := aNewValue;
   if copy (s2, 1, AMaxLen) <> AField then begin
     AField := copy (s2, 1, AMaxLen);
     fModified := True;
    end;
  end;
 begin
  case AIdx of
    1: SetIt (s, 30, fTitle);
    2: SetIt (s, 30, fArtist);
    3: SetIt (s, 4, fYear);
    4: SetIt (s, 30, fAlbum);
    5: if fv1
        then SetIt (s, 30, fComment)
        else SetIt (s, 28, fComment);
   end;
 end; { of procedure TID3v1Tag.SetTitle
--------------------------------------------------------------}

procedure TID3v1Tag.SetGenreID (AGenreID : integer);
 begin
  if fGenreID <> AGenreID then begin
    fGenreID := AGenreID;
    fModified := True;
   end;
 end; { of procedure TID3v1Tag.SetGenreID
--------------------------------------------------------------}

procedure TID3v1Tag.SetTrack (ATrack : integer);
 begin
  if fTrack <> ATrack then begin
    fTrack := ATrack;
    fv1 := fTrack = 0;
    fModified := True;
   end;
 end; { of procedure TID3v1Tag.SetTrack
--------------------------------------------------------------}

procedure TID3v1Tag.Load (const ABuf; ABufSz : integer);
 var
  b : array [0 .. ID3v1TagLen - 1] of byte absolute ABuf;
  GenreIdx : integer;
 function BufStr (APos, ALen : integer) : string;
  begin
   SetString (Result, nil, ALen);
   Move (b [APos], Result [1], ALen);
   if Pos (#0, Result) > 0
    then Result := copy (Result, 1, Pos (#0, Result) - 1);
   Result := TrimRight (Result);
  end;
 begin
  fOk := false;
  fModified := false;
  if ABufSz < ID3v1TagLen
   then EXIT;
    if BufStr (0, 3) = 'TAG' then begin
      fOk := true;
      fTitle := BufStr (3, 30);
      fArtist:= BufStr (33, 30);
      fAlbum:= BufStr (63, 30);
      fYear:= BufStr (93, 4);
      fComment:= BufStr (97, 30);
      if (b [97 + 28] = 0) and (b [97 + 29] <> 0) then begin
         fv1 := false;
         fTrack := b [97 + 29];
        end
       else begin
         fv1 := true;
         fTrack := 0;
        end;
      fGenreID := b [127];
      GenreIdx := ID3Genres.IndexOfObject (TObject (fGenreID));
      if GenreIdx >= 0
       then fGenre := ID3Genres [GenreIdx]
       else fGenre := '';
     end;
 end; { of procedure TID3v1Tag.Load
--------------------------------------------------------------}

procedure TID3v1Tag.LoadFromStream (AStream : TStream; AStreamSz : integer);
 var
  Buf : array [0 .. ID3v1TagLen - 1] of byte;
 begin
  if AStreamSz >= ID3v1TagLen then begin
     // AStream.Position := AStream.Position + AStreamSz - ID3v1TagLen;
     		 AStream.Position := AStreamSz - ID3v1TagLen;

     AStream.ReadBuffer (Buf, ID3v1TagLen);
     Load (Buf, ID3v1TagLen);
    end
   else fOk := false;
 end; { of procedure TID3v1Tag.LoadFromStream
--------------------------------------------------------------}

procedure TID3v1Tag.LoadFromFile (const AFileName : string);
 var
  f : TStream;
 begin
  f := TFileStream.Create (AFileName, fmOpenRead or fmShareDenyNone);
  try
     LoadFromStream (f, f.Size);
    finally f.Free;
   end;
 end; { of procedure TID3v1Tag.LoadFromFile
--------------------------------------------------------------}

procedure TID3v1Tag.Save (var ABuf; ABufSz : integer);
 var
  b : array [0 .. ID3v1TagLen - 1] of byte absolute ABuf;
 procedure StrBuf (APos, ALen : integer; AStr : string);
  var
   Len : integer;
  begin
   if length(AStr)=0 then AStr := #0;
   Len := Length (AStr);
   if Len > ALen
    then Len := ALen;
   Move (AStr [1], b [APos], Len);
   if Len < ALen
    then FillChar (b [APos + Len], ALen - Len, $20);
  end;
 begin
  if ABufSz < ID3v1TagLen
   then raise Exception.Create ('TID3v1Tag.Save: Buffer too small');
  // fOk ?!!
  StrBuf (0, 3, 'TAG');
  StrBuf (3, 30, fTitle);
  StrBuf (33, 30, fArtist);
  StrBuf (63, 30, fAlbum);
  StrBuf (93, 4, fYear);
  StrBuf (97, 30, fComment);
  if not fv1 then begin
    b [97 + 28] := 0;
    b [97 + 29] := fTrack;
   end;
  b [127] := fGenreID;
  fModified := false;
 end; { of procedure TID3v1Tag.Save
--------------------------------------------------------------}

procedure TID3v1Tag.SaveToStream (AStream : TStream);
 var
  Buf : array [0 .. ID3v1TagLen - 1] of byte;
 begin
  Save (Buf, ID3v1TagLen);
  AStream.WriteBuffer (Buf, ID3v1TagLen);
 end; { of procedure TID3v1Tag.SaveToStream
--------------------------------------------------------------}

procedure TID3v1Tag.SaveToFile (const AFileName : string);
 var
  f : TStream;
  s : string;
 begin
  f := TFileStream.Create (AFileName, fmOpenReadWrite or fmShareDenyNone);
  try
     if f.Size >= ID3v1TagLen then begin
        f.Position := f.Size - ID3v1TagLen;
        SetString (s, nil, 3);
        f.ReadBuffer (s [1], 3);
       end
      else s := 'NON';
     if s = 'TAG'
      then f.Position := f.Size - ID3v1TagLen
      else f.Position := f.Size;
     SaveToStream (f);
    finally f.Free;
   end;
 end; { of procedure TID3v1Tag.SaveToFile
--------------------------------------------------------------}

procedure TID3v1Tag.DeleteFromFile (const AFileName : string);
 var
  f : TStream;
  s : string;
 begin
  f := TFileStream.Create (AFileName, fmOpenReadWrite or fmShareExclusive);
  try
     if f.Size >= ID3v1TagLen then begin
        f.Position := f.Size - ID3v1TagLen;
        SetString (s, nil, 3);
        f.ReadBuffer (s [1], 3);
        if s = 'TAG' then begin
          f.Size := f.Size - ID3v1TagLen;
         end;
       end;
    finally f.Free;
   end;
 end; { of procedure TID3v1Tag.DeleteFromFile
--------------------------------------------------------------}

var
 i : integer; // for genres initialization

initialization
 ID3Genres := TStringList.Create;
 ID3Genres.Duplicates := dupAccept;
 ID3Genres.Sorted := false;
 ID3Genres.CommaText :=
  '"Blues","Classic Rock","Country","Dance","Disco","Funk","Grunge",'
  + '"Hip-Hop","Jazz","Metal","New Age","Oldies","Other","Pop",'
  + '"R&B","Rap","Reggae","Rock","Techno","Industrial","Alternative",'
  + '"Ska","Death Metal","Pranks","Soundtrack","Euro-Techno","Ambient",'
  + '"Trip-Hop","Vocal","Jazz+Funk","Fusion","Trance","Classical",'
  + '"Instrumental","Acid","House","Game","Sound Clip","Gospel",'
  + '"Noise","AlternRock","Bass","Soul","Punk","Space","Meditative",'
  + '"Instrumental Pop","Instrumental Rock","Ethnic","Gothic",'
  + '"Darkwave","Techno-Industrial","Electronic","Pop-Folk","Eurodance",'
  + '"Dream","Southern Rock","Comedy","Cult","Gangsta","Top 40",'
  + '"Christian Rap","Pop/Funk","Jungle","Native American","Cabaret",'
  + '"New Wave","Psychedelic","Rave","Showtunes","Trailer","Lo-Fi",'
  + '"Tribal","Acid Punk","Acid Jazz","Polka","Retro","Musical",'
  + '"Rock & Roll","Hard Rock",' // 79 standard genres
  + '"Folk","Folk/Rock","National Folk","Swing","Fast Fusion",'
  + '"Bebob","Latin","Revival","Celtic","Bluegrass","Avantgarde",'
  + '"Gothic Rock","Progressive Rock","Psychedelic Rock",'
  + '"Symphonic Rock","Slow Rock","Big Band","Chorus","Easy Listening",'
  + '"Acoustic","Humour","Speech","Chanson","Opera","Chamber Music",'
  + '"Sonata","Symphony","Booty Bass","Primus","Porn Groove",'
  + '"Satire","Slow Jam","Club","Tango","Samba","Folklore",' // add
  + '"Ballad","Power Ballad","Rhythmic Soul","Freestyle",'
  + '"Duet","Punk Rock","Drum Solo","Acapella","Euro-House",'
  + '"Dance Hall", "Goa", "Drum & Bass", "Club-House", "Hardcore",'
  + '"Terror", "Indie", "BritPop", "Negerpunk", "Polsk Punk", "Beat",'
  + '"Christian Gangs", "Heavy Metal", "Black Metal", "Crossover",'
  + '"Contemporary Ch?", "Cristian Rock", "Merengue", "Salsa",'
  + '"Thrash Metal", "Anime", "JPop", "Synthpop"'; // 0 .. 93h

 // save genres IDs for genres list resorting ability
 for i := 0 to ID3Genres.Count - 1
  do ID3Genres.Objects [i] := TObject (i);


finalization

 if Assigned (ID3Genres)
  then ID3Genres.Free;

end.

