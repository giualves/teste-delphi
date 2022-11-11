unit uPedido;

interface

uses
  udmConexao,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.Samples.Spin;

type
  TfrmPedido = class(TForm)
    DBGrid1: TDBGrid;
    stNomeCliente: TStaticText;
    btnSalvar: TButton;
    dsItem: TDataSource;
    lcbItem: TDBLookupComboBox;
    dsPedidoItem: TDataSource;
    lbSelecionarItem: TLabel;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    pnRodape: TPanel;
    dsPedido: TDataSource;
    DBNavigator1: TDBNavigator;
    edValorUnit: TDBEdit;
    edQuantidade: TDBEdit;
    lbSelecionarCliente: TLabel;
    btnNovoPedido: TButton;
    edCliente: TDBEdit;
    edTotal: TDBEdit;
    lbTotal: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure lcbItemExit(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    dmConexao: TdmConexao;
    procedure PesquisarCliente;
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

uses
  uPesquisa;

{$R *.dfm}

procedure TfrmPedido.btnNovoPedidoClick(Sender: TObject);
begin
  dmConexao.qryPedido.Insert;
  btnSalvar.Enabled := True;
  edCliente.Clear;
  stNomeCliente.Caption := '';
end;

procedure TfrmPedido.btnSalvarClick(Sender: TObject);
begin
  dmConexao.Salvar;
  btnSalvar.Enabled := False;
end;

procedure TfrmPedido.edClienteChange(Sender: TObject);
begin
  stNomeCliente.Caption := '';
  if edCliente.Text <> '' then
    stNomeCliente.Caption := dmConexao.GetNomeCliente(StrToIntDef(edCliente.Text, 0));
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  dmConexao := TdmConexao.Create(nil);
  dmConexao.CarregarItem;

  dsItem.DataSet := dmConexao.qryItem;
  dsPedido.DataSet := dmConexao.qryPedido;
  dsPedidoItem.DataSet := dmConexao.PedidoItemList;

  dmConexao.qryPedido.Insert;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  btnNovoPedido.SetFocus;
end;

procedure TfrmPedido.lcbItemExit(Sender: TObject);
begin
  if dmConexao.PedidoItemList.State in dsEditModes then
    dmConexao.PedidoItemList.FieldByName('valorunit').AsCurrency := dmConexao.qryItem['preco'];
end;

procedure TfrmPedido.PesquisarCliente;
var
  frmPesquisa: TFrmPesquisa;
begin
  frmPesquisa := TFrmPesquisa.Create(nil);
  try
    frmPesquisa.Tabela := 'CLIENTE';
    frmPesquisa.CampoWhere := 'NOME';
    if frmPesquisa.ShowModal = mrOk then
      dmConexao.qryPedido['cli_idf'] := frmPesquisa.Resultado;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmPedido.SpeedButton1Click(Sender: TObject);
begin
  PesquisarCliente;
end;

end.
