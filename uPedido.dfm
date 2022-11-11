object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  ActiveControl = DBGrid1
  BorderStyle = bsSingle
  Caption = 'Pedido'
  ClientHeight = 501
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 185
    Width = 502
    Height = 244
    TabStop = False
    Align = alClient
    DataSource = dsPedidoItem
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'item_idf'
        Title.Caption = 'C'#243'd do Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'item_nome'
        Title.Caption = 'Descri'#231#227'o'
        Width = 236
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valorunit'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 73
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 502
    Height = 185
    Align = alTop
    TabOrder = 0
    ExplicitTop = -6
    object lbSelecionarItem: TLabel
      Left = 48
      Top = 96
      Width = 74
      Height = 13
      Caption = 'Selecionar Item'
    end
    object SpeedButton1: TSpeedButton
      Left = 95
      Top = 64
      Width = 23
      Height = 23
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object lbSelecionarCliente: TLabel
      Left = 48
      Top = 50
      Width = 85
      Height = 13
      Caption = 'Selecionar Cliente'
    end
    object lcbItem: TDBLookupComboBox
      Left = 48
      Top = 111
      Width = 225
      Height = 21
      DataField = 'item_idf'
      DataSource = dsPedidoItem
      KeyField = 'id'
      ListField = 'nome;preco'
      ListSource = dsItem
      TabOrder = 2
      OnExit = lcbItemExit
    end
    object stNomeCliente: TStaticText
      Left = 119
      Top = 65
      Width = 290
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 6
    end
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 159
      Width = 500
      Height = 25
      DataSource = dsPedidoItem
      VisibleButtons = [nbPrior, nbNext, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
      Align = alBottom
      TabOrder = 5
      TabStop = True
    end
    object edValorUnit: TDBEdit
      Left = 328
      Top = 110
      Width = 81
      Height = 21
      DataField = 'valorunit'
      DataSource = dsPedidoItem
      TabOrder = 4
    end
    object edQuantidade: TDBEdit
      Left = 278
      Top = 110
      Width = 45
      Height = 21
      DataField = 'quantidade'
      DataSource = dsPedidoItem
      TabOrder = 3
    end
    object btnNovoPedido: TButton
      Left = 47
      Top = 8
      Width = 97
      Height = 33
      Caption = 'Novo Pedido'
      TabOrder = 0
      OnClick = btnNovoPedidoClick
    end
    object edCliente: TDBEdit
      Left = 48
      Top = 65
      Width = 46
      Height = 21
      DataField = 'cli_idf'
      DataSource = dsPedido
      TabOrder = 1
      OnChange = edClienteChange
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 429
    Width = 502
    Height = 72
    Align = alBottom
    TabOrder = 2
    object lbTotal: TLabel
      Left = 204
      Top = 27
      Width = 68
      Height = 16
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnSalvar: TButton
      Left = 387
      Top = 20
      Width = 97
      Height = 33
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object edTotal: TDBEdit
      Left = 278
      Top = 24
      Width = 75
      Height = 24
      HelpType = htKeyword
      Color = cl3DLight
      DataField = 'total'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object dsItem: TDataSource
    Left = 448
    Top = 8
  end
  object dsPedidoItem: TDataSource
    Left = 448
    Top = 104
  end
  object dsPedido: TDataSource
    Left = 448
    Top = 56
  end
end
