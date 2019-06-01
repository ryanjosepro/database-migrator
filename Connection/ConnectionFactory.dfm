object ConnFactory: TConnFactory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 139
  Width = 161
  object Conn: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      
        'Database=C:\Users\Denis Denon.PCX\Documents\Embarcadero\Studio\P' +
        'rojects\ProjectMigration2.0\Win32\Debug\DB\NSC.FDB'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object Trans: TFDTransaction
    Connection = Conn
    Left = 104
    Top = 16
  end
  object QuerySQL: TFDQuery
    Connection = Conn
    Left = 24
    Top = 80
  end
  object QueryTable: TFDQuery
    Connection = Conn
    FetchOptions.AssignedValues = [evRowsetSize, evRecordCountMode]
    FetchOptions.RowsetSize = 150
    SQL.Strings = (
      'SELECT RF.RDB$FIELD_NAME FIELD_NAME'
      'FROM RDB$RELATION_FIELDS RF'
      'JOIN RDB$FIELDS F ON (F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE)'
      
        'LEFT OUTER JOIN RDB$CHARACTER_SETS CH ON (CH.RDB$CHARACTER_SET_I' +
        'D = F.RDB$CHARACTER_SET_ID)'
      
        'LEFT OUTER JOIN RDB$COLLATIONS DCO ON ((DCO.RDB$COLLATION_ID = F' +
        '.RDB$COLLATION_ID) AND (DCO.RDB$CHARACTER_SET_ID = F.RDB$CHARACT' +
        'ER_SET_ID))'
      
        'WHERE (RF.RDB$RELATION_NAME = :TABLE_NAME) AND (COALESCE(RF.RDB$' +
        'SYSTEM_FLAG, 0) = 0)'
      'ORDER BY RF.RDB$FIELD_POSITION;')
    Left = 104
    Top = 80
    ParamData = <
      item
        Name = 'TABLE_NAME'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
        Value = ''
      end>
  end
end
