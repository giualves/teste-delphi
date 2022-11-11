program TesteDephi;

uses
  Vcl.Forms,
  uPedido in 'uPedido.pas' {frmPedido},
  udmConexao in 'udmConexao.pas' {dmConexao: TDataModule},
  uPesquisa in 'uPesquisa.pas' {frmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
