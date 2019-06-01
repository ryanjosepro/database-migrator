object WindowDB: TWindowDB
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Database'
  ClientHeight = 201
  ClientWidth = 275
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
  PixelsPerInch = 96
  TextHeight = 13
  object ImageTitle: TImage
    Left = 136
    Top = 5
    Width = 33
    Height = 33
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
      00200804000000D973B27F0000000467414D410000B18F0BFC61050000000262
      4B47440000AA8D2332000000097048597300000EC400000EC401952B0E1B0000
      000774494D4507E3051B081909FF33DC66000002DC4944415478DA9D956D4CCD
      6118C67F472A740A794B693396ED2C2F07D1C2F8920DA36119C3FA20F3323E30
      123666984D31CC0763B2A11AF332136BB33E599692D4D66AD332F31A15524D7A
      91EB7F5E3AE7D0C9F9BB9FEDD49EE7B9AFE7FFDCD775DD8F05DFB092A0114F2C
      318CC5C248CD7DA597CFBCE72DD53CA79C36EF044BDF7FC1AC613DC974524915
      AF94F0C5918A032652809398815DFB8AC8E716DDBE00AB39ABA5AB14F0941EFC
      471049AC208D9FECE29E07E0183B39C0159D1E588490CE09CE71C409B050E7CE
      D7FDCCC5349EB08C6203E02436524CA61B719F5A320D806C7D50227526D3A750
      CA65329C00DB69672F79FC0A3039880D9C621817DC00A32851515AC9E181281C
      38EC2C6713E11C141FCD6E80485DC22A7236EA2A4D54F082D7D241033FE8D0FA
      108612251D4C6426B3755829B95C939C72A4142F00678C618136D9249A28CD86
      B8663BB5B541E2AA95128B6974CDF60BF0E75D23F4FBDD8FB4BC00C6EBE3CD47
      2E1FDD00E9CCA1DE64FA649EE91B5C00DB54AC3D420C94C641A2F1B48A7BD153
      8342E9D1C20DEEAA4CBD03A45A64F655ACD351FB59EA5BC450D692CA62F9AC42
      2075A2B19116BA308C1EA1DE1023EDCDD208E51177745467FF2C44480953D550
      6C22345CDAB06AAE4DA35570351AD5B27B6BE0343ADDEAEF4A5E00D12A8AF9C8
      E3831B6033734DBB318E328F1BB7A8C36548DFDD01260F966FB2F57BC9538302
      B2C4EB4DD158F68F9E98C84AF1D541A67AA34F114344622A4B945E29225FAA89
      37C98D2D5A0F131FA3D5E8E36433BB200AB9ADD1D53F0B613A215E44DA645B83
      46E7BB60D0D8EC20B146666E3743E340D10790C5043D29E6239F77EC330016A9
      9125FD475B2F515B7FEC7C588EB383432225F087652B4739CF61CFD396C21915
      F0BAE82C7118C85F04334F4D354D45DDADBD783FAE418E8564FDADD2A8974C0D
      37F6385686CB8DD1EA9376A64B6C4592DC43B75A2C7F9D90A06D76B11ECB3869
      6D84E6BE29E9136FA48C4A8D725FBDFE0664F3EA2107DC645500000025744558
      74646174653A63726561746500323031392D30352D32375430363A32353A3039
      2B30323A3030E26CD8070000002574455874646174653A6D6F64696679003230
      31392D30352D32375430363A32353A30392B30323A3030933160BB0000001974
      455874536F667477617265007777772E696E6B73636170652E6F72679BEE3C1A
      0000000049454E44AE426082}
  end
  object LblUserName: TLabel
    Left = 8
    Top = 47
    Width = 43
    Height = 16
    Caption = 'Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblPassword: TLabel
    Left = 8
    Top = 77
    Width = 41
    Height = 16
    Caption = 'Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblDatabase: TLabel
    Left = 8
    Top = 107
    Width = 39
    Height = 16
    Caption = 'Banco:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblTable: TLabel
    Left = 8
    Top = 137
    Width = 44
    Height = 16
    Caption = 'Tabela:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtnSave: TSpeedButton
    Left = 175
    Top = 171
    Width = 92
    Height = 22
    Caption = 'Salvar'
    OnClick = BtnSaveClick
  end
  object BtnTestConn: TSpeedButton
    Left = 80
    Top = 171
    Width = 89
    Height = 22
    Caption = 'Testar Conex'#227'o'
    OnClick = BtnTestConnClick
  end
  object TxtUserName: TEdit
    Left = 80
    Top = 44
    Width = 187
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = EditsChange
  end
  object TxtPassword: TEdit
    Left = 80
    Top = 74
    Width = 187
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = EditsChange
  end
  object TxtDatabase: TEdit
    Left = 80
    Top = 104
    Width = 187
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = EditsChange
  end
  object TxtTable: TEdit
    Left = 80
    Top = 134
    Width = 187
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = EditsChange
  end
end
