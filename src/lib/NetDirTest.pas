unit NetDirTest;

interface

uses Windows;

{-- NetDirectoryExists ------------------------------------------------}
{: Test for the existence of a network directory.
@Param dirname is the name of the directory to test for
@Param timeoutMSecs is the time, in milliseconds, to wait for the
  test to complete.
@Returns true if the directory exists, false if it does not or the
  test timed out.
@Precondition  dirname <> '', timeoutMSecs > 0
@Desc Uses a background thread to call DirectoryExists. This deals with
  the possible lengthy network timeout on Windows when the remote
  computer the directory resides on is not connected.
@Raises any exception DirectoryExists may raise.
}{ Created 29.3.2002 by P. Below
-----------------------------------------------------------------------}


type
	TDirExistsTestResult = (trNoDirectory, trDirectoryExists, trTimeout );

Function NewDirThread(const dirname: String; timeoutMSecs: Dword; index:integer; name:string): TDirExistsTestResult;

implementation

uses
  Classes, Sysutils, FileCtrl;

type
  ExceptionClass = Class Of Exception;
  TNetDirThread = class(TThread)
  private
    FDirname: String;
    FErr    : String;
    FErrclass: ExceptionClass;
    FResult : Boolean;
  protected
    procedure Execute; override;
  public
    Function TestForDir( const dirname: String; timeoutMSecs: Dword ):TDirExistsTestResult;
  end;

Function NewDirThread(const dirname: String; timeoutMSecs: Dword; index:integer; name:string): TDirExistsTestResult;
Var
  thread: TNetDirThread;
Begin
  thread:= TNetDirThread.Create( true );
  try
    result := thread.TestForDir( dirname, timeoutMSecs );
    If result <> trTimeout Then
      thread.Free;
    {Note: if the thread timed out it will free itself when it finally
     terminates on its own. }
  except
    try
    	thread.free
    except
    end
  end;
End;

{Function NetDirectoryExists(
           const dirname: String; timeoutMSecs: Dword ): Boolean;
Var
  res: TTestResult;
  thread: TNetDirThread;
Begin
  result := false;
  thread:= TNetDirThread.Create( true );
  try
    res:= thread.TestForDir( dirname, timeoutMSecs );
    Result := res = trDirectoryExists;
    If res <> trTimeout Then
      thread.Free;
    //Note: if the thread timed out it will free itself when it finally terminates on its own.
  except
    try
	    thread.free;
  	except
    end
  end;
End;  }

procedure TNetDirThread.Execute;
begin
  try
    FResult := DirectoryExists(FDirname);
  except
    On E: Exception Do Begin
      FErr := E.Message;
      FErrclass := ExceptionClass( E.Classtype );
    End;
  end;
end;

function TNetDirThread.TestForDir(const dirname: String; timeoutMSecs: Dword): TDirExistsTestResult;
begin
  FDirname := dirname;
  Resume;
  If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT
  Then
  Begin
    Result := trTimeout;
    FreeOnTerminate := true;
  End
  Else Begin
    If Assigned( FErrclass ) Then
      raise FErrClass.Create( FErr );
    If FResult Then
      Result := trDirectoryExists
    Else
      Result := trNoDirectory;
  End;
end;

end.
