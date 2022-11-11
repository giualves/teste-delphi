object frmPesquisa: TfrmPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisa'
  ClientHeight = 364
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgDadosPesquisa: TDBGrid
    Left = 0
    Top = 57
    Width = 515
    Height = 247
    Align = alClient
    DataSource = dsPesquisa
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgDadosPesquisaDblClick
  end
  object pnCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 57
    Align = alTop
    TabOrder = 0
    object edPesquisa: TEdit
      Left = 16
      Top = 19
      Width = 369
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnPesquisa: TButton
      Left = 400
      Top = 13
      Width = 97
      Height = 34
      Caption = 'Pesquisa'
      TabOrder = 1
      OnClick = btnPesquisaClick
    end
  end
  object pnSalvar: TPanel
    Left = 0
    Top = 304
    Width = 515
    Height = 60
    Align = alBottom
    TabOrder = 2
    object btnOK: TButton
      Left = 400
      Top = 13
      Width = 97
      Height = 34
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
  object dsPesquisa: TDataSource
    Left = 456
    Top = 80
  end
end
