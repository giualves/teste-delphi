object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 268
  Width = 290
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=testedelphi'
      'User_Name=delphiuser'
      'Password=password'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 40
    Top = 48
  end
  object qryPedido: TFDQuery
    BeforePost = qryPedidoBeforePost
    OnNewRecord = qryPedidoNewRecord
    CachedUpdates = True
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evDetailCascade]
    SQL.Strings = (
      'select * from produto')
    Left = 152
    Top = 88
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 40
    Top = 104
  end
  object qryItem: TFDQuery
    Connection = FDConnection1
    Left = 152
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 40
    Top = 152
  end
  object FDCommand: TFDCommand
    Connection = FDConnection1
    Left = 152
    Top = 200
  end
  object PedidoItemList: TFDMemTable
    AfterPost = PedidoItemListAfterPost
    BeforeCancel = PedidoItemListBeforeCancel
    OnNewRecord = PedidoItemListNewRecord
    OnUpdateRecord = PedidoItemListUpdateRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 144
    object PedidoItemListITEM_ID: TIntegerField
      FieldName = 'ITEM_IDF'
    end
    object PedidoItemListITEM_NOME: TStringField
      FieldName = 'ITEM_NOME'
      Size = 255
    end
    object PedidoItemListQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object PedidoItemListVALORUNIT: TCurrencyField
      FieldName = 'VALORUNIT'
    end
  end
end
