object frmVerificacaoArqBancario: TfrmVerificacaoArqBancario
  Left = 0
  Top = 0
  Caption = 'Verifica'#231#227'o de arquivo de remessa bancaria'
  ClientHeight = 391
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    784
    391)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 768
    Height = 293
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 281
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 89
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'AGENCIA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 89
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 108
        Visible = True
      end>
  end
  object pnlTotal: TPanel
    Left = 8
    Top = 307
    Width = 768
    Height = 58
    Anchors = [akLeft, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'Total R$ 000.000.000,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 318
    ExplicitWidth = 804
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 372
    Width = 784
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
    ExplicitLeft = 416
    ExplicitTop = 224
    ExplicitWidth = 0
  end
  object ActionList1: TActionList
    Left = 216
    Top = 248
    object actImportarArquivo: TAction
      Caption = 'Importar Arquivo'
      ShortCut = 116
      OnExecute = actImportarArquivoExecute
    end
    object actIterarArquivo: TAction
      Caption = 'Iterar Arquivo'
      OnExecute = actIterarArquivoExecute
    end
    object actExportarArquivo: TAction
      Caption = 'Exportar Dados'
      ShortCut = 117
      OnExecute = actExportarArquivoExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivo de Texto (*.txt)|*.txt|Todos os arquivos (*.*)|*.*'
    Title = 'Importar arquivo de remessa banc'#225'ria'
    Left = 216
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = tblMem
    Left = 112
    Top = 248
  end
  object tblMem: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 112
    Top = 192
    object tblMemID: TIntegerField
      FieldName = 'ID'
    end
    object tblMemCPF: TStringField
      DisplayWidth = 14
      FieldName = 'CPF'
      Size = 14
    end
    object tblMemNOME: TStringField
      DisplayWidth = 44
      FieldName = 'NOME'
      Size = 30
    end
    object tblMemVALOR: TFloatField
      DisplayWidth = 16
      FieldName = 'VALOR'
      DisplayFormat = '###.###.###,##'
    end
    object tblMemAGENCIA: TStringField
      FieldName = 'AGENCIA'
      Size = 4
    end
    object tblMemCONTA: TStringField
      FieldName = 'CONTA'
    end
  end
  object MainMenu1: TMainMenu
    Left = 384
    Top = 224
    object Aplicativo1: TMenuItem
      Caption = 'Aplicativo'
      object Fechar1: TMenuItem
        Caption = 'Fechar'
        ShortCut = 32883
        OnClick = Fechar1Click
      end
    end
    object ImportarExportar1: TMenuItem
      Caption = 'Importar / Exportar'
      object ImportarArquivo1: TMenuItem
        Action = actImportarArquivo
      end
      object Exportar1: TMenuItem
        Action = actExportarArquivo
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    FileName = 'teste'
    Filter = 'Arquivos de exporta'#231#227'o CSV (*.csv)|*.csv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 288
    Top = 176
  end
  object TimerAutoImport: TTimer
    Interval = 1
    OnTimer = TimerAutoImportTimer
    Left = 400
    Top = 144
  end
end
