unit uPesquisa;

interface

uses
  udmConexao, FireDAC.Comp.Client,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmPesquisa = class(TForm)
    dbgDadosPesquisa: TDBGrid;
    pnCabecalho: TPanel;
    edPesquisa: TEdit;
    btnPesquisa: TButton;
    dsPesquisa: TDataSource;
    pnSalvar: TPanel;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure dbgDadosPesquisaDblClick(Sender: TObject);
  private
    dmConexao: TdmConexao;
    FTabela: string;
    FCampoWhere: string;
    FValorWhere: string;
    FResultado: integer;
    Query: TFDQuery;
    procedure ConfirmarPesquisa;
  public
    function ExecutarPesquisa: string;
    property Tabela: string read FTabela write FTabela;
    property CampoWhere: string read FCampoWhere write FCampoWhere;
    property ValorWhere: string read FValorWhere write FValorWhere;
    property Resultado: integer read FResultado write FResultado;
  end;

var
  frmPesquisa: TfrmPesquisa;

const
  _SelectBasePesquisa = 'SELECT * FROM %s where %s like %s';

implementation

{$R *.dfm}

{ TfrmPesquisa }

procedure TfrmPesquisa.btnOKClick(Sender: TObject);
begin
  ConfirmarPesquisa;
end;

procedure TfrmPesquisa.btnPesquisaClick(Sender: TObject);
begin
  ExecutarPesquisa;
end;

procedure TfrmPesquisa.ConfirmarPesquisa;
begin
  FResultado := Query['id'];
  ModalResult := mrOk;
end;

procedure TfrmPesquisa.dbgDadosPesquisaDblClick(Sender: TObject);
begin
  ConfirmarPesquisa;
end;

function TfrmPesquisa.ExecutarPesquisa: string;
begin
  FValorWhere := edPesquisa.Text;
  Query.SQL.Text := Format(_SelectBasePesquisa,
    [FTabela, FCampoWhere, QuotedStr('%'+UpperCase(FValorWhere)+'%')]);
  Query.Open;
end;

procedure TfrmPesquisa.FormCreate(Sender: TObject);
begin
  Query := TFDQuery.Create(nil);
  dsPesquisa.DataSet := Query;

  dmConexao := TdmConexao.Create(nil);
  Query.Connection := dmConexao.FDConnection1;
end;

end.

