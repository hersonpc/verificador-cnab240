program VerificacaoArquivoBancario;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {frmVerificacaoArqBancario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVerificacaoArqBancario, frmVerificacaoArqBancario);
  Application.Run;
end.
