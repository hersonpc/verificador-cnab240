unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TfrmVerificacaoArqBancario = class(TForm)
    DBGrid1: TDBGrid;
    ActionList1: TActionList;
    actImportarArquivo: TAction;
    OpenDialog1: TOpenDialog;
    actIterarArquivo: TAction;
    DataSource1: TDataSource;
    tblMem: TFDMemTable;
    tblMemCPF: TStringField;
    tblMemNOME: TStringField;
    tblMemVALOR: TFloatField;
    pnlTotal: TPanel;
    tblMemAGENCIA: TStringField;
    tblMemCONTA: TStringField;
    MainMenu1: TMainMenu;
    Aplicativo1: TMenuItem;
    Fechar1: TMenuItem;
    ImportarExportar1: TMenuItem;
    ImportarArquivo1: TMenuItem;
    actExportarArquivo: TAction;
    Exportar1: TMenuItem;
    SaveDialog1: TSaveDialog;
    tblMemID: TIntegerField;
    StatusBar1: TStatusBar;
    TimerAutoImport: TTimer;
    procedure actImportarArquivoExecute(Sender: TObject);
    procedure actIterarArquivoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure actExportarArquivoExecute(Sender: TObject);
    procedure TimerAutoImportTimer(Sender: TObject);
  private
    ArqBancario: TStrings;
  public
    { Public declarations }
  end;

var
  frmVerificacaoArqBancario: TfrmVerificacaoArqBancario;

implementation

{$R *.dfm}

procedure TfrmVerificacaoArqBancario.actExportarArquivoExecute(Sender: TObject);
var
  output: TStrings;
begin
  if not Assigned(ArqBancario) then
    raise Exception.Create('Arquivo bancario não carregado!');

  if tblMem.RecordCount <= 0 then
    raise Exception.Create('Não existem dados a serem exportados!');

  output := TStringList.Create;
  output.Add('CPF;NOME;VALOR;AGENCIA;CONTA');
  tblMem.First;
  while not tblMem.Eof do
  try
    output.Add(
      '"' + tblMem.FieldByName('CPF').AsString + '";' +
      '"' + tblMem.FieldByName('NOME').AsString + '";' +
      tblMem.FieldByName('VALOR').AsString + ';' +
      tblMem.FieldByName('AGENCIA').AsString + ';' +
      tblMem.FieldByName('CONTA').AsString
    );
  finally
    tblMem.Next;
  end;

  SaveDialog1.FileName := Format('visualizacao_remessa_%s.csv', [FormatDateTime('yyyy-mm-dd-hhnnss', Now)]);
  if SaveDialog1.Execute then
  begin
    output.SaveToFile(SaveDialog1.FileName);
    Application.MessageBox('Exportação concluida com sucesso!', 'Exportação de dados', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TfrmVerificacaoArqBancario.actImportarArquivoExecute(Sender: TObject);
begin
//  OpenDialog1.FileName := '\\192.168.3.36\TI$\Arquivo bancário CS 0619.TXT';
  if OpenDialog1.Execute then
  begin
    if not Assigned(ArqBancario) then
      ArqBancario := TStringList.Create;
    ArqBancario.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[1].Text := OpenDialog1.FileName;
//    Memo1.Lines.Assign(ArqBancario);
    actIterarArquivoExecute(nil);
  end;

end;

procedure TfrmVerificacaoArqBancario.actIterarArquivoExecute(Sender: TObject);
var
  i, id: Integer;
  total: Double;
  linha, tipo, tipo2, agencia, conta, nome, cpf, valor: String;
  listaContas: TStrings;
begin
  if not Assigned(ArqBancario) then
    raise Exception.Create('Arquivo bancario não carregado!');

  listaContas := TStringList.Create;

//  Memo1.Clear;
  tblMem.Active := True;
  tblMem.EmptyDataSet;
  total := 0;
  for i := 0 to ArqBancario.Count -1 do
  begin
    linha := ArqBancario[i];

    tipo := Copy(linha, 8, 1);
    tipo2 := Copy(linha, 14, 1);

    if((tipo = '3') and (tipo2 = 'A')) then
    begin
      agencia := Trim(Copy(linha, 25, 4));
      if StrToInt64Def(Copy(linha, 30, 12), 0) > 0 then
        conta := Trim(IntToStr(StrToInt64Def(Copy(linha, 30, 12), 0)) + '-' + Copy(linha, 42, 1))
      else
        conta := '';

      if (conta <> '') and (listaContas.IndexOf(conta) > 0) then
      begin
        Application.MessageBox(PChar('ATENÇÃO'#13#10#13#10'Registro identificado por constar mais de uma vez neste arquivo bancario.'#13#10#13#10'Nome: '+nome+#13#10'Agencia: ' + agencia +#13#10'Conta: ' + conta + ''), 'ALERTA DE INTEGRIDADE', MB_OK + MB_ICONEXCLAMATION);
      end
      else
        listaContas.Add(conta);

      nome := Trim(Copy(linha, 44, 30));
      cpf := Copy(linha, 74, 11);
      valor := FloatToStr( StrToFloat(Copy(linha, 105, 28)) ) + ',' + Copy(linha, 133, 2);

//      Memo1.Lines.Append(format('Nome: %s CPF: %s R$ %s', [nome, cpf, valor]));
      id := tblMem.RecordCount+1;
      tblMem.Append;
      tblMem.FieldByName('ID').AsInteger := id;
      tblMem.FieldByName('CPF').AsString := Copy(cpf, 1,3)+'.'+Copy(cpf, 4,3)+'.'+Copy(cpf, 7,3)+'-'+Copy(cpf, 10,2);
      tblMem.FieldByName('NOME').AsString := nome;
      tblMem.FieldByName('VALOR').AsFloat := StrToFloatDef(valor, 0);
      tblMem.FieldByName('AGENCIA').AsString := agencia;
      tblMem.FieldByName('CONTA').AsString := conta;
//      tblMemVALOR.AsFloat := StrToFloat(valor);
      tblMem.Post;

      total := total +StrToFloatDef(valor, 0);
    end;

  end;
  tblMem.First;
  StatusBar1.Panels[0].Text := 'Total de itens: ' + tblMem.RecordCount.ToString;
  pnlTotal.Caption := 'Total R$ '+ FormatCurr('###,###,##0.00', total);
  Application.MessageBox('Importação concluida com sucesso!', 'Importação de dados', MB_OK + MB_ICONINFORMATION);

  listaContas.Free;
end;

procedure TfrmVerificacaoArqBancario.Fechar1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmVerificacaoArqBancario.FormCreate(Sender: TObject);
begin
  pnlTotal.Caption := '';
end;

procedure TfrmVerificacaoArqBancario.TimerAutoImportTimer(Sender: TObject);
begin
  TimerAutoImport.Enabled := False;
  actImportarArquivoExecute(nil);
end;

end.
