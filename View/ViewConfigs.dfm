object WindowConfigs: TWindowConfigs
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Migrator - Configura'#231#245'es'
  ClientHeight = 343
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelRows: TPanel
    Left = 8
    Top = 8
    Width = 350
    Height = 105
    TabOrder = 0
    object LblLimitRows: TLabel
      Left = 8
      Top = 8
      Width = 92
      Height = 13
      Caption = 'Linhas para migrar:'
    end
    object TxtLimitRows: TEdit
      Left = 150
      Top = 33
      Width = 82
      Height = 21
      AutoSelect = False
      AutoSize = False
      Enabled = False
      NumbersOnly = True
      TabOrder = 0
    end
    object RadioBtnAllRows: TRadioButton
      Left = 8
      Top = 35
      Width = 49
      Height = 17
      Caption = 'Todas'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioBtnAllRowsClick
    end
    object RadioBtnLimitRows: TRadioButton
      Left = 95
      Top = 35
      Width = 49
      Height = 17
      Caption = 'Limite:'
      TabOrder = 2
      OnClick = RadioBtnLimitRowsClick
    end
    object CheckBoxKeep: TCheckBox
      Left = 288
      Top = 80
      Width = 49
      Height = 17
      Caption = 'Manter'
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 119
    Width = 350
    Height = 105
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 8
    Top = 230
    Width = 350
    Height = 105
    TabOrder = 2
  end
end
