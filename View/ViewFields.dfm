object WindowFields: TWindowFields
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'WindowFields'
  ClientHeight = 628
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Title1: TLabel
    Left = 8
    Top = 5
    Width = 201
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Firebird'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblCampos: TLabel
    Left = 8
    Top = 35
    Width = 201
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Campos Firebird'
  end
  object LblNCampos: TLabel
    Left = 210
    Top = 35
    Width = 130
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'N'#186' Campo DataFlex'
  end
  object Title2: TLabel
    Left = 210
    Top = 5
    Width = 130
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'DataFlex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object GridFirebird: TStringGrid
    Left = 8
    Top = 54
    Width = 332
    Height = 566
    ColCount = 2
    DefaultColWidth = 200
    FixedColor = clWindow
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing]
    TabOrder = 0
    RowHeights = (
      24)
  end
end
