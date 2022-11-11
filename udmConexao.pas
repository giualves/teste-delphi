unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TdmConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryPedido: TFDQuery;
    qryItem: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDCommand: TFDCommand;
    PedidoItemList: TFDMemTable;
    PedidoItemListITEM_ID: TIntegerField;
    PedidoItemListITEM_NOME: TStringField;
    PedidoItemListQUANTIDADE: TIntegerField;
    PedidoItemListVALORUNIT: TCurrencyField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryPedidoNewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PedidoItemListNewRecord(DataSet: TDataSet);
    procedure PedidoItemListBeforeCancel(DataSet: TDataSet);
    procedure qryPedidoBeforePost(DataSet: TDataSet);
    procedure PedidoItemListAfterPost(DataSet: TDataSet);
    procedure PedidoItemListUpdateRecord(ASender: TDataSet;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
      AOptions: TFDUpdateRowOptions);
  private
    procedure AtualizarTotal;
  public
    procedure CarregarItem;
    function GetNomeCliente(nCliente_Id: integer): string;
    function GetNomeByID(Tabela: string; Id: integer): string;
    function InserirPedidoItem: Boolean;
    procedure Salvar;
  end;

var
  dmConexao: TdmConexao;

const
  _InserirPedidoItem = 'INSERT INTO PEDIDO_ITEM(ITEM_IDF, QUANTIDADE, VALORUNIT, TOTAL, PED_IDF) VALUES (%d, %d, %s, %s, %d);';
  _BuscarNomeByID = 'SELECT NOME FROM %s WHERE ID = %d';

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  Dialogs;

procedure TdmConexao.AtualizarTotal;
begin
  PedidoItemList.First;
  qryPedido['total'] := 0;
  while not PedidoItemList.Eof do
  begin
    qryPedido['total'] := qryPedido['total'] + (PedidoItemList['valorunit'] * PedidoItemList['quantidade']);
    PedidoItemList.Next;
  end;
end;

procedure TdmConexao.CarregarItem;
begin
  qryItem.Open;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  qryItem.SQL.Text := 'SELECT * FROM ITEM';

  qryPedido.SQL.Text := 'SELECT * FROM PEDIDO where false';
  qryPedido.Open;

  PedidoItemList.CreateDataSet;
  PedidoItemList.Open;
end;

procedure TdmConexao.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(PedidoItemList);
end;

function TdmConexao.GetNomeByID(Tabela: string; Id: integer): string;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FDConnection1;
    qry.SQL.Text := Format(_BuscarNomeByID, [Tabela, Id]);
    qry.Open;
    Result := qry['nome'];
  finally
    FreeAndNil(qry);
  end;
end;

function TdmConexao.GetNomeCliente(nCliente_Id: integer): string;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FDConnection1;
    qry.SQL.Text := Format(_BuscarNomeByID, ['CLIENTE', nCliente_Id]);
    qry.Open;
    Result := qry['nome'];
  finally
    FreeAndNil(qry);
  end;
end;

function TdmConexao.InserirPedidoItem: Boolean;
begin
  try
    PedidoItemList.First;
    while not PedidoItemList.Eof do
    begin
      FDCommand.CommandText.Add(Format(_InserirPedidoItem, [
        PedidoItemList.FieldByName('item_idf').AsInteger,
        PedidoItemList.FieldByName('quantidade').AsInteger,
        CurrToStr(PedidoItemList.FieldByName('valorunit').AsCurrency),
        CurrToStr(PedidoItemList.FieldByName('valorunit').AsCurrency *
          PedidoItemList.FieldByName('quantidade').AsInteger),
        qryPedido.FieldByName('id').AsInteger]));
      PedidoItemList.Next;
    end;
    FDCommand.Execute;
    Result := True;
  except
    on E:Exception do
    begin
      Result := False;
      raise Exception.Create('Problema ao gravar os itens do pedido.'
        + sLineBreak + E.Message);
    end;
  end;
end;

procedure TdmConexao.PedidoItemListAfterPost(DataSet: TDataSet);
begin
  AtualizarTotal;
end;

procedure TdmConexao.PedidoItemListBeforeCancel(DataSet: TDataSet);
begin
  qryItem.Refresh;
end;

procedure TdmConexao.PedidoItemListNewRecord(DataSet: TDataSet);
begin
  DataSet['quantidade'] := 1;
  if qryItem['id'] > 0 then
  begin
    DataSet['item_nome'] := GetNomeByID('ITEM', qryItem['id']);
    DataSet['valorunit'] := qryItem['preco'];
  end
  else
    DataSet['valorunit'] := 0;
end;

procedure TdmConexao.PedidoItemListUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  ASender['item_nome'] := GetNomeByID('ITEM', qryItem['id']);
end;

procedure TdmConexao.qryPedidoBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('cli_idf').IsNull then
    raise Exception.Create('Cliente é obrigatório');
  AtualizarTotal;
end;

procedure TdmConexao.qryPedidoNewRecord(DataSet: TDataSet);
begin
  DataSet['total'] := 0;
  DataSet['emissao'] := Now;
  PedidoItemList.EmptyDataSet;
end;

procedure TdmConexao.Salvar;
var
  iErrors: integer;
begin
  if qryPedido.State in dsEditModes then
    qryPedido.Post;

  if PedidoItemList.State in dsEditModes then
    PedidoItemList.Post;

  FDConnection1.StartTransaction;
  iErrors := qryPedido.ApplyUpdates;

  if (iErrors = 0) and (InserirPedidoItem) then
  begin
    qryPedido.CommitUpdates;
    FDConnection1.Commit;
    MessageDlg('Pedido gravado com sucesso!', mtInformation,
      [mbOk], 0, mbOk);
  end
  else
    FDConnection1.Rollback;
end;

end.
