object WindowConfigs: TWindowConfigs
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Migrator - Configura'#231#245'es'
  ClientHeight = 366
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  DesignSize = (
    338
    366)
  PixelsPerInch = 96
  TextHeight = 13
  object BtnDiscard: TSpeedButton
    Left = 139
    Top = 338
    Width = 89
    Height = 23
    Action = ActDiscard
    Anchors = [akLeft, akBottom]
  end
  object BtnSave: TSpeedButton
    Left = 234
    Top = 338
    Width = 92
    Height = 23
    Action = ActSave
    Anchors = [akLeft, akBottom]
  end
  object PageConfigs: TPageControl
    Left = 8
    Top = 8
    Width = 322
    Height = 324
    ActivePage = TabExceptions
    TabOrder = 0
    object TabMigration: TTabSheet
      Caption = 'Migra'#231#227'o'
      object GroupCommit: TRadioGroup
        Left = 3
        Top = 0
        Width = 308
        Height = 73
        Caption = 'Commitar'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'No Final'
          'A cada:')
        TabOrder = 2
        OnClick = GroupCommitClick
      end
      object TxtCommit: TEdit
        Left = 222
        Top = 32
        Width = 82
        Height = 21
        AutoSelect = False
        AutoSize = False
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
      end
      object GroupLimit: TRadioGroup
        Left = 3
        Top = 72
        Width = 308
        Height = 73
        Caption = 'Limite de Migra'#231#227'o'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Todas'
          'Limite:')
        TabOrder = 3
        OnClick = GroupLimitClick
      end
      object TxtLimit: TEdit
        Left = 222
        Top = 102
        Width = 82
        Height = 21
        AutoSelect = False
        AutoSize = False
        Enabled = False
        NumbersOnly = True
        TabOrder = 1
      end
    end
    object TabExceptions: TTabSheet
      Caption = 'Exce'#231#245'es'
      ImageIndex = 2
      object GroupException: TRadioGroup
        Left = 3
        Top = 0
        Width = 308
        Height = 73
        Caption = 'Tratamento de Erro'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Parar a Migra'#231#227'o'
          'Pular o Dado'
          'Tratar Dado')
        TabOrder = 0
        OnClick = GroupCommitClick
      end
    end
    object TabFirebird: TTabSheet
      Caption = 'Firebird'
      ImageIndex = 1
      object CheckTruncFB: TCheckBox
        Left = 3
        Top = 3
        Width = 308
        Height = 17
        Caption = 'Truncar tabela firebird ao iniciar migra'#231#227'o'
        TabOrder = 0
        OnClick = CheckTruncFBClick
      end
    end
  end
  object Actions: TActionList
    Left = 288
    Top = 280
    object ActSave: TAction
      Caption = 'Salvar'
      OnExecute = ActSaveExecute
    end
    object ActDiscard: TAction
      Caption = 'Descartar'
      OnExecute = ActDiscardExecute
    end
  end
end
