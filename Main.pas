unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Data.DB, Data.Win.ADODB;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    btnStart: TButton;
    btnStop: TButton;
    btnClose: TButton;
    GroupBox2: TGroupBox;
    mmoDetails: TMemo;
    sbMessages: TStatusBar;
    ADOConAdmin: TADOConnection;
    aspInsertAdminRecord: TADOStoredProc;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function isValidWindowsLogin: Boolean;
    function GetVersion(sFileName: string): string;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure Initialise;
  private
    { Private declarations }
    StartDate, EndDate: TDateTime;
    Description: string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  UserName: String;

implementation

{$R *.dfm}

procedure TfrmMain.Initialise;
begin
  StartDate := Now;
  EndDate := Now;
  Description := '';
  mmoDetails.Clear;
  sbMessages.SimpleText := 'User Name: ' + UserName;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TfrmMain.isValidWindowsLogin: Boolean;
var
  UserNameLen: Dword;
  rtvUser: string;
  rtvUserID: integer;
begin
  UserNameLen := 255;
  SetLength(UserName, UserNameLen);
  if GetUserName(PChar(UserName), UserNameLen) Then
    rtvUser := Copy(UserName, 1, UserNameLen - 1)
  else
    rtvUser := 'Unknown';
  UserName := rtvUser;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  StartDate := Now;
  sbMessages.SimpleText:= 'Query initiated at: ' + DateTimeToStr(StartDate);
  btnStart.Enabled := False;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  if mmoDetails.Text = '' then
  begin
    MessageDlg('You have not entered any details', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  Description := mmoDetails.Text;
  EndDate := Now;
  aspInsertAdminRecord.Parameters.ParamByName('@StartDate').Value :=
    StartDate;
  aspInsertAdminRecord.Parameters.ParamByName('@EndDate').Value := EndDate;
  aspInsertAdminRecord.Parameters.ParamByName('@Description').Value :=
    Description;
  aspInsertAdminRecord.ExecProc;
  Initialise;
  btnStart.Enabled := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  isValidWindowsLogin;
  sbMessages.SimpleText := 'User Name: ' + UserName;
  frmMain.Caption := 'Admin V' + (GetVersion(GetCurrentDir + '\Admin.exe') +
    ' - Main');
end;

function TfrmMain.GetVersion(sFileName: string): string;
var
  VerInfoSize: Dword;
  VerInfo: Pointer;
  VerValueSize: Dword;
  VerValue: PVSFixedFileInfo;
  Dummy: Dword;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(sFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

end.
