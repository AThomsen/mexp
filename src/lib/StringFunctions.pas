unit StringFunctions;

interface
uses
  Classes;

  procedure SplitString(const stringToSplit, separator: string; const output: TStringList; allowEmptyString, useQuotes: boolean);

implementation

procedure SplitString(const stringToSplit, separator: string; const output: TStringList; allowEmptyString, useQuotes: boolean);
var
  i: Integer;
  tempStr, tempBaseString: string;
  inQuotes : boolean;
begin
  output.Clear;
  tempBaseString := stringToSplit;

  inQuotes := false;
  tempstr := '';
  tempbasestring := tempbasestring + ' ';
  for i:=1 to length(tempbasestring) do
  begin
      if (not inQuotes) and (tempbasestring[i] = '"') then
        inQuotes := true
      else
        if ((not inQuotes or not useQuotes) and (tempBaseString[i] = ' ')) or (inQuotes and (tempBaseString[i] = '"')) then
        begin
          if ((tempStr = '') and allowEmptyString) or (tempStr <> '') then output.add(tempStr);
          tempStr := '';
          inQuotes := false
      end
      else
        tempStr := tempStr + tempbasestring[i]
  end;
end;

end.
