object DataModuleConn: TDataModuleConn
  OldCreateOrder = False
  Height = 132
  Width = 216
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Transaction = Trans
    Left = 24
    Top = 40
  end
  object Trans: TFDTransaction
    Options.AutoStop = False
    Connection = Conn
    Left = 88
    Top = 40
  end
  object Query: TFDQuery
    Connection = Conn
    Transaction = Trans
    Left = 160
    Top = 40
  end
end
