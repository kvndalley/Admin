object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 396
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 683
    Height = 41
    Align = alTop
    Caption = 'Administration Log'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 263
    Width = 683
    Height = 105
    Align = alBottom
    Caption = 'Options'
    TabOrder = 1
    ExplicitTop = 265
    DesignSize = (
      683
      105)
    object btnStart: TButton
      Left = 72
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 224
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btnStopClick
    end
    object btnClose: TButton
      Left = 528
      Top = 48
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Close'
      TabOrder = 2
      OnClick = btnCloseClick
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 683
    Height = 207
    Align = alClient
    Caption = 'Details'
    TabOrder = 2
    ExplicitHeight = 209
    object mmoDetails: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 673
      Height = 184
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitHeight = 186
    end
  end
  object sbMessages: TStatusBar
    AlignWithMargins = True
    Left = 3
    Top = 374
    Width = 683
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 376
  end
  object ADOConAdmin: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Admin;Data Source=SAGE_SERVER\SAGE200'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 67
    Top = 82
  end
  object aspInsertAdminRecord: TADOStoredProc
    Connection = ADOConAdmin
    ProcedureName = 'aspInsertAdminRecord;1'
    Parameters = <
      item
        Name = '@StartDate'
        Attributes = [paNullable]
        DataType = ftDateTime
      end
      item
        Name = '@EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
      end
      item
        Name = '@Description'
        Attributes = [paNullable]
        DataType = ftString
        Size = 5000
      end>
    Left = 59
    Top = 146
  end
end
